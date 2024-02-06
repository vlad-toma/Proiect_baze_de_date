import sys
import cx_Oracle
from PyQt5 import QtWidgets
from PyQt5.QtWidgets import (QDialog, QApplication, QTableWidgetItem, QPushButton,  QMessageBox)
from PyQt5.uic import loadUi

con = cx_Oracle.connect("bd146", "bd146", "bd-dc.cs.tuiasi.ro:1539/orcl")
global indexClient
global indexBilet
indexClient = -1
indexBilet = -1

class ComboBoxNume(QtWidgets.QComboBox):

    def showPopup(self):
        self.popupAboutToBeShown.emit()
        super(ComboBoxNume, self).showPopup()

class MainUI(QDialog):
    def __init__(self):
        super(MainUI, self).__init__()
        loadUi("main.ui", self)
        self.clientNou.clicked.connect(self.clientNouClicked)
        self.clientExistent.clicked.connect(self.clientExistentClicked)
        self.administrator.clicked.connect(self.adminClicked)

    def adminClicked(self):
        admin = AdminUI()
        widget.addWidget(admin)
        widget.setCurrentIndex(widget.currentIndex()+1)
    def clientNouClicked(self):
        clientnou = ClientNou()
        widget.addWidget(clientnou)
        widget.setCurrentIndex(widget.currentIndex()+1)

    def clientExistentClicked(self):
        clientexistent = ClientExistent()
        widget.addWidget(clientexistent)
        widget.setCurrentIndex(widget.currentIndex()+1)
class ClientNou(QDialog):
    def __init__(self):
        super(ClientNou, self).__init__()
        loadUi("clientnou.ui", self)
        self.butonInapoi.clicked.connect(self.inapoiClicked)
        self.creareCont.clicked.connect(self.creareClicked)

    def creareClicked(self):
        nume = self.nume.text()
        prenume = self.prenume.text()
        cnp = self.cnp.text()
        telefon = self.telefon.text()
        email = self.email.text()

        cur = con.cursor()
        try:
            cur.execute("insert into client values (NULL, \'{}\', \'{}\', \'{}\')".format(nume, prenume, cnp))
            cur.execute("INSERT INTO Detalii_client values(CLIENT_ID_SEQ.currval, \'{}\', \'{}\')".format(telefon, email))
        except cx_Oracle.DatabaseError as exc:
            error, = exc.args
            print("Oracle-Error-Message:", error.message)
            msg = QMessageBox()
            msg.setWindowTitle("Eroare!")
            msg.setText("Oracle-Error-Message:" + error.message)
            msg.setIcon(QMessageBox.Critical)
            msg.exec_()
        else:
            con.commit()
            cur.execute("SELECT ID_Client from Client where cnp = {}".format(cnp))
            indexClientRez = cur.fetchall()
            global indexClient
            indexClient = indexClientRez[0][0]
            msg = QMessageBox()
            msg.setWindowTitle("Succes!")
            msg.setText("Client creat!")
            msg.setIcon(QMessageBox.Information)
            msg.exec_()
            clientui = ClientUI()
            widget.addWidget(clientui)
            widget.setCurrentIndex(widget.currentIndex() + 1)

        cur.close()

    def inapoiClicked(self):
        mainUI = MainUI()
        widget.addWidget(mainUI)
        widget.setCurrentIndex(widget.currentIndex() + 1)

class ClientExistent(QDialog):
    def __init__(self):
        super(ClientExistent, self).__init__()
        loadUi("clientexistent.ui", self)
        self.butonInapoi.clicked.connect(self.inapoiClicked)
        self.butonOK.clicked.connect(self.okClicked)
        self.refreshPrenume.clicked.connect(self.prenumeClicked)
        self.refreshCnp.clicked.connect(self.cnpClicked)
        self.loadNume()

    def loadNume(self):
        cur = con.cursor()
        cur.execute("SELECT Nume from Client")
        listanume = cur.fetchall()
        for numee in listanume:
            self.nume.addItem(str(numee[0]))
        cur.close()
    def prenumeClicked(self):
        cur = con.cursor()
        cur.execute("SELECT Prenume from Client WHERE Nume = \'{}\'".format(str(self.nume.currentText())))
        listaprenume = cur.fetchall()
        self.prenume.clear()
        for prenumee in listaprenume:
            self.prenume.addItem(str(prenumee[0]))
        cur.close()
    def cnpClicked(self):
        cur = con.cursor()
        cur.execute("SELECT cnp from Client WHERE Nume = \'{}\' AND Prenume = \'{}\'".format(str(self.nume.currentText()), str(self.prenume.currentText())))
        listacnp = cur.fetchall()
        self.cnp.clear()
        for cnpp in listacnp:
            self.cnp.addItem(str(cnpp[0]))
        cur.close()

    def inapoiClicked(self):
        mainUI = MainUI()
        widget.addWidget(mainUI)
        widget.setCurrentIndex(widget.currentIndex() + 1)

    def okClicked(self):
        nume = str(self.nume.currentText())
        prenume = str(self.prenume.currentText())
        cnp = str(self.cnp.currentText())

        cur = con.cursor()
        try:
            cur.execute("SELECT ID_Client FROM client WHERE nume = \'{}\' AND prenume = \'{}\'AND cnp = \'{}\'".format(nume, prenume, cnp))
        except cx_Oracle.DatabaseError as exc:
            error, = exc.args
            print("Oracle-Error-Message:", error.message)
            msg = QMessageBox()
            msg.setWindowTitle("Eroare!")
            msg.setText("Oracle-Error-Message:" + error.message)
            msg.setIcon(QMessageBox.Critical)
            msg.exec_()
        else:
            rezultat = cur.fetchall()
            if len(rezultat) == 1:
                global indexClient
                indexClient = rezultat[0][0]
                clientui = ClientUI()
                widget.addWidget(clientui)
                widget.setCurrentIndex(widget.currentIndex() + 1)

class AdminUI(QDialog):
    def __init__(self):
        super(AdminUI, self).__init__()
        loadUi("administrator.ui", self)
        self.butonInapoi.clicked.connect(self.inapoiClicked)
        self.butonAdauga.clicked.connect(self.adaugaClicked)
        self.butonSterge.clicked.connect(self.stergeClicked)
        self.butonModifica.clicked.connect(self.modificaClicked)
        for i in range(0, 17):
            self.tabel.setColumnWidth(i, 150)
        self.loadData()

    def loadData(self):
        cur = con.cursor()
        cur.execute("SELECT c.Nume, eg.Nume, ed.Nume, e.Data_si_ora_eveniment, ce.cota, e.id_eveniment "
                    "from competitie c, echipa eg, echipa ed, eveniment e, cota_eveniment ce, tip_pariu tp "
                    "where e.id_echipa_gazda = eg.id_echipa and e.id_echipa_deplasare = ed.id_echipa and ce.id_eveniment = e.id_eveniment "
                    "and c.id_competitie = e.id_competitie and ce.id_pariu = tp.id_pariu ORDER BY e.id_eveniment, ce.id_pariu")
        cote = cur.fetchall()
        self.tabel.setRowCount(len(cote) / 12)
        index = 0
        for i in range(0, len(cote), 12):
            self.tabel.setItem(index, 0, QTableWidgetItem(str(cote[i][5])))
            self.tabel.setItem(index, 1, QTableWidgetItem(str(cote[i][0])))
            self.tabel.setItem(index, 2, QTableWidgetItem(str(cote[i][1])))
            self.tabel.setItem(index, 3, QTableWidgetItem(str(cote[i][2])))
            self.tabel.setItem(index, 4, QTableWidgetItem(str(cote[i][3])))
            for j in range(0, 12):
                self.tabel.setItem(index, 5 + j, QTableWidgetItem(str(cote[i + j][4])))
            index += 1
        self.tabel.show()
        self.tabel.setEditTriggers(QtWidgets.QTableWidget.NoEditTriggers)
        cur.close()

    def inapoiClicked(self):
        mainUI = MainUI()
        widget.addWidget(mainUI)
        widget.setCurrentIndex(widget.currentIndex() + 1)
    def adaugaClicked(self):
        evenimentui = EvenimentUI()
        widget.addWidget(evenimentui)
        widget.setCurrentIndex(widget.currentIndex() + 1)
    def stergeClicked(self):
        if self.tabel.rowCount()>0:
            cur = con.cursor()
            try:
                cur.execute("DELETE FROM pariu WHERE ID_Eveniment = {}".format(int(self.tabel.item(self.tabel.currentRow(), 0).text())))
                cur.execute("DELETE FROM cota_eveniment WHERE ID_Eveniment = {}".format(int(self.tabel.item(self.tabel.currentRow(), 0).text())))
                cur.execute("DELETE FROM eveniment WHERE ID_Eveniment = {}".format(int(self.tabel.item(self.tabel.currentRow(), 0).text())))
            except cx_Oracle.DatabaseError as exc:
                error, = exc.args
                print("Oracle-Error-Message:", error.message)
                msg = QMessageBox()
                msg.setWindowTitle("Eroare!")
                msg.setText("Oracle-Error-Message:" + error.message)
                msg.setIcon(QMessageBox.Critical)
                msg.exec_()
            else:
                con.commit()
                msg = QMessageBox()
                msg.setWindowTitle("Succes!")
                msg.setText("Eveniment sters")
                msg.setIcon(QMessageBox.Information)
                msg.exec_()
                self.loadData()
            cur.close()

    def modificaClicked(self):
        cotanoua = round(float(self.newcota.text()), 2)
        cur = con.cursor()
        try:
            cur.execute("UPDATE cota_eveniment SET cota = {} WHERE ID_Pariu = {} "
                        "AND ID_Eveniment = {}".format(cotanoua, self.tabel.currentColumn() - 4, int(self.tabel.item(self.tabel.currentRow(), 0).text())))
        except cx_Oracle.DatabaseError as exc:
            error, = exc.args
            print("Oracle-Error-Message:", error.message)
            msg = QMessageBox()
            msg.setWindowTitle("Eroare!")
            msg.setText("Oracle-Error-Message:" + error.message)
            msg.setIcon(QMessageBox.Critical)
            msg.exec_()
        else:
            con.commit()
            msg = QMessageBox()
            msg.setWindowTitle("Succes!")
            msg.setText("Cota modificata!")
            msg.setIcon(QMessageBox.Information)
            msg.exec_()
            self.loadData()
        cur.close()

class ClientUI(QDialog):
    def __init__(self):
        super(ClientUI, self).__init__()
        loadUi("client.ui", self)
        self.butonInapoi.clicked.connect(self.inapoiClicked)
        self.butonAdaugaBilet.clicked.connect(self.adaugaBiletClicked)
        self.butonScoateBilet.clicked.connect(self.scoateBiletClicked)

        self.tabel.setColumnWidth(0, 150)
        self.tabel.setColumnWidth(1, 150)
        self.tabel.setColumnWidth(2, 150)
        self.tabel.setColumnWidth(3, 150)
        self.tabel.setColumnWidth(4, 150)
        self.tabel.setColumnWidth(5, 150)
        self.loadData()

    def adaugaBiletClicked(self):
        pariuui = PariuUI()
        widget.addWidget(pariuui)
        widget.setCurrentIndex(widget.currentIndex() + 1)
    def scoateBiletClicked(self):
        cur = con.cursor()
        try:
            cur.execute("DELETE FROM PARIU WHERE ID_Bilet = {}".format(int(self.tabel.item(self.tabel.currentRow(), 0).text())))
            cur.execute("DELETE FROM BILET WHERE ID_Bilet = {}".format(int(self.tabel.item(self.tabel.currentRow(), 0).text())))
        except cx_Oracle.DatabaseError as exc:
            error, = exc.args
            print("Oracle-Error-Message:", error.message)
            msg = QMessageBox()
            msg.setWindowTitle("Eroare!")
            msg.setText("Oracle-Error-Message:" + error.message)
            msg.setIcon(QMessageBox.Critical)
            msg.exec_()
        else:
            con.commit()
            msg = QMessageBox()
            msg.setWindowTitle("Succes!")
            msg.setText("Bilet scos!")
            msg.setIcon(QMessageBox.Information)
            msg.exec_()
            self.loadData()
        cur.close()
    def loadData(self):
        cur = con.cursor()
        cur.execute("SELECT ID_Bilet, suma_jucata, cota_totala, castig_potential, to_char(data_si_ora_plasarii_biletului, 'DD-MM-YYYY HH:MI:SS'), ID_Client FROM bilet "
                    "WHERE ID_Client = \'{}\'".format(indexClient))
        bilete = cur.fetchall()
        self.tabel.setRowCount(len(bilete))
        index = 0
        for bilet in bilete:
            btn = QPushButton()
            btn.setText('Click')
            self.tabel.setItem(index, 0, QTableWidgetItem(str(bilet[0])))
            self.tabel.setItem(index, 1, QTableWidgetItem(str(bilet[1])))
            self.tabel.setItem(index, 2, QTableWidgetItem(str(bilet[2])))
            self.tabel.setItem(index, 3, QTableWidgetItem(str(bilet[3])))
            self.tabel.setItem(index, 4, QTableWidgetItem(str(bilet[4])))
            self.tabel.setCellWidget(index, 5, btn)
            btn.clicked.connect(self.veziBiletClicked)
            index += 1

        self.tabel.show()
        self.tabel.setEditTriggers(QtWidgets.QTableWidget.NoEditTriggers)
    def inapoiClicked(self):
        mainUI = MainUI()
        widget.addWidget(mainUI)
        widget.setCurrentIndex(widget.currentIndex() + 1)
    def veziBiletClicked(self):
        button = self.sender()
        index = self.tabel.indexAt(button.pos())
        global indexBilet
        indexBilet = int(self.tabel.item(index.row(), 0).text())
        biletui = BiletUI()
        widget.addWidget(biletui)
        widget.setCurrentIndex(widget.currentIndex() + 1)

class BiletUI(QDialog):
    def __init__(self):
        super(BiletUI, self).__init__()
        loadUi("bilet.ui", self)
        self.butonInapoi.clicked.connect(self.inapoiClicked)

        self.tabel.setColumnWidth(0, 150)
        self.tabel.setColumnWidth(1, 150)
        self.tabel.setColumnWidth(2, 150)
        self.tabel.setColumnWidth(3, 150)
        self.tabel.setColumnWidth(4, 150)
        self.tabel.setColumnWidth(5, 150)
        self.tabel.setColumnWidth(6, 150)
        self.tabel.setColumnWidth(7, 150)
        self.loadData()

    def loadData(self):
        cur = con.cursor()
        cur.execute("SELECT DISTINCT b.ID_Bilet, p.ID_Pariu, tp.Nume_Pariu, ce.Cota, ev.ID_Eveniment, co.Nume, e1.Nume, e2.Nume, "
                    "to_char(ev.Data_si_ora_eveniment, 'DD-MM-YYYY HH:MI:SS') FROM "
                    "client c, detalii_client dc, bilet b, competitie co, echipa e1, echipa e2, eveniment ev, tip_pariu tp, "
                    "cota_eveniment ce, pariu p WHERE p.id_bilet = b.id_bilet and p.id_pariu = tp.id_pariu and p.id_pariu = ce.id_pariu "
                    "and p.id_eveniment = ev.id_eveniment and p.id_eveniment = ce.id_eveniment and ev.id_echipa_gazda = e1.id_echipa "
                    "and ev.id_echipa_deplasare = e2.id_echipa and ev.id_competitie = co.id_competitie and b.ID_Bilet = \'{}\'".format(indexBilet))
        pariuri = cur.fetchall()
        self.tabel.setRowCount(len(pariuri))
        index=0
        for pariu in pariuri:
            self.tabel.setItem(index, 0, QTableWidgetItem(str(pariu[1])))
            self.tabel.setItem(index, 1, QTableWidgetItem(str(pariu[2])))
            self.tabel.setItem(index, 2, QTableWidgetItem(str(pariu[3])))
            self.tabel.setItem(index, 3, QTableWidgetItem(str(pariu[4])))
            self.tabel.setItem(index, 4, QTableWidgetItem(str(pariu[5])))
            self.tabel.setItem(index, 5, QTableWidgetItem(str(pariu[6])))
            self.tabel.setItem(index, 6, QTableWidgetItem(str(pariu[7])))
            self.tabel.setItem(index, 7, QTableWidgetItem(str(pariu[8])))
            index += 1

        self.tabel.show()
        self.tabel.setEditTriggers(QtWidgets.QTableWidget.NoEditTriggers)
    def inapoiClicked(self):
        clientui = ClientUI()
        widget.addWidget(clientui)
        widget.setCurrentIndex(widget.currentIndex() + 1)

class PariuUI(QDialog):
    def __init__(self):
        super(PariuUI, self).__init__()
        loadUi("pariu.ui", self)
        self.butonInapoi.clicked.connect(self.inapoiClicked)
        self.butonAdauga.clicked.connect(self.adaugaClicked)
        self.butonSterge.clicked.connect(self.stergeClicked)
        self.butonRefresh.clicked.connect(self.refreshClicked)
        self.butonFinal.clicked.connect(self.finalClicked)
        for i in range(0, 17):
            self.tabel.setColumnWidth(i, 150)
        self.tabel2.setColumnWidth(0, 100)
        self.tabel2.setColumnWidth(1, 100)
        self.tabel2.setColumnWidth(2, 100)
        self.tabel2.setColumnWidth(3, 100)
        self.tabel2.setColumnWidth(4, 100)
        self.tabel2.setColumnWidth(5, 100)
        self.loadData()

    def loadData(self):
        cur = con.cursor()
        cur.execute("SELECT c.Nume, eg.Nume, ed.Nume, e.Data_si_ora_eveniment, ce.cota "
                    "from competitie c, echipa eg, echipa ed, eveniment e, cota_eveniment ce, tip_pariu tp "
                    "where e.id_echipa_gazda = eg.id_echipa and e.id_echipa_deplasare = ed.id_echipa and ce.id_eveniment = e.id_eveniment "
                    "and c.id_competitie = e.id_competitie and ce.id_pariu = tp.id_pariu ORDER BY e.id_eveniment, ce.id_pariu")
        global cote
        cote = cur.fetchall()
        self.tabel.setRowCount(len(cote))
        index = 0
        for i in range(0, len(cote), 12):
            self.tabel.setItem(index, 0, QTableWidgetItem(str(cote[i][0])))
            self.tabel.setItem(index, 1, QTableWidgetItem(str(cote[i][1])))
            self.tabel.setItem(index, 2, QTableWidgetItem(str(cote[i][2])))
            self.tabel.setItem(index, 3, QTableWidgetItem(str(cote[i][3])))
            for j in range(0, 12):
                self.tabel.setItem(index, 4 + j, QTableWidgetItem(str(cote[i + j][4])))
            index += 1

        self.tabel.show()
        self.tabel.setEditTriggers(QtWidgets.QTableWidget.NoEditTriggers)

    def adaugaClicked(self):
        pariu = self.tabel.item(self.tabel.currentRow(), self.tabel.currentColumn()).text()
        a = self.tabel2.rowCount()
        self.tabel2.setRowCount(a + 1)
        self.tabel2.setItem(a, 0, QTableWidgetItem(str(cote[12 * self.tabel.currentRow()][0])))
        self.tabel2.setItem(a, 1, QTableWidgetItem(str(cote[12 * self.tabel.currentRow()][1])))
        self.tabel2.setItem(a, 2, QTableWidgetItem(str(cote[12 * self.tabel.currentRow()][2])))
        self.tabel2.setItem(a, 3, QTableWidgetItem(str(cote[12 * self.tabel.currentRow()][3])))
        cur = con.cursor()
        cur.execute("SELECT Nume_Pariu FROM Tip_Pariu WHERE ID_Pariu = {}".format(self.tabel.currentColumn() - 3))
        nume_pariu = cur.fetchall()
        self.tabel2.setItem(a, 4, QTableWidgetItem(nume_pariu[0][0]))
        cur.execute("SELECT cota FROM cota_eveniment WHERE ID_Pariu = (SELECT ID_Pariu FROM TIP_PARIU WHERE Nume_pariu = \'{}\') AND ID_Eveniment = (SELECT ID_Eveniment FROM eveniment WHERE ID_Echipa_gazda = (SELECT ID_Echipa from ECHIPA WHERE Nume = \'{}\') AND Data_si_ora_eveniment = to_date(\'{}\', 'YYYY-MM-DD HH:MI:SS'))".format(nume_pariu[0][0], str(self.tabel.item(self.tabel.currentRow(), 1).text()), str(self.tabel.item(self.tabel.currentRow(), 3).text())))
        cota_pariu = cur.fetchall()

        self.tabel2.setItem(a, 5, QTableWidgetItem(str(cota_pariu[0][0])))

        self.tabel2.show()
        self.tabel2.setEditTriggers(QtWidgets.QTableWidget.NoEditTriggers)

    def stergeClicked(self):
        if self.tabel2.rowCount()>0:
            self.tabel2.removeRow(self.tabel2.currentRow())
    def refreshClicked(self):
        if self.tabel2.rowCount()>0:
            cota = 1.00
            for i in range(0, self.tabel2.rowCount()):
                cota *= round(float(self.tabel2.item(i, 5).text()), 2)
            self.cotaTotala.setText(str(round(cota, 2)))
            suma_jucata = round(float(self.sumaJucata.text()), 2)
            self.castigPotential.setText(str(round(float(suma_jucata * cota), 2)))
    def finalClicked(self):
        if self.tabel2.rowCount()>0:
            self.refreshClicked()
            cur = con.cursor()
            suma_jucata = round(float(self.sumaJucata.text()), 2)
            cota_totala = round(float(self.cotaTotala.text()), 2)
            castig_potential = round(float(self.castigPotential.text()), 2)
            try:
                cur.execute("INSERT INTO BILET VALUES (NULL, {}, {}, {}, {}, SYSDATE)".format(indexClient, suma_jucata,
                                                                                              cota_totala,
                                                                                              castig_potential))
                for i in range(0, self.tabel2.rowCount()):
                    cur.execute("INSERT INTO PARIU VALUES (BILET_ID_SEQ.currval, "
                                "(SELECT ID_Eveniment FROM eveniment WHERE ID_Echipa_gazda = (SELECT ID_Echipa from ECHIPA WHERE Nume = \'{}\') "
                                "AND Data_si_ora_eveniment = to_date(\'{}\', 'YYYY-MM-DD HH:MI:SS')), (SELECT ID_Pariu FROM TIP_PARIU WHERE Nume_pariu = \'{}\'))"
                                .format(str(self.tabel2.item(i, 1).text()), str(self.tabel2.item(i, 3).text()),
                                        str(self.tabel2.item(i, 4).text())))
            except cx_Oracle.DatabaseError as exc:
                error, = exc.args
                print("Oracle-Error-Message:", error.message)
                msg = QMessageBox()
                msg.setWindowTitle("Eroare!")
                msg.setText("Oracle-Error-Message:" + error.message)
                msg.setIcon(QMessageBox.Critical)
                msg.exec_()
            else:
                con.commit()
                msg = QMessageBox()
                msg.setWindowTitle("Succes!")
                msg.setText("Bilet creat!")
                msg.setIcon(QMessageBox.Information)
                msg.exec_()
                self.loadData()
            cur.close()

    def inapoiClicked(self):
        clientui = ClientUI()
        widget.addWidget(clientui)
        widget.setCurrentIndex(widget.currentIndex() + 1)

class EvenimentUI(QDialog):
    def __init__(self):
        super(EvenimentUI, self).__init__()
        loadUi("eveniment.ui", self)
        self.butonInapoi.clicked.connect(self.inapoiClicked)
        self.butonCreare.clicked.connect(self.creareClicked)
        self.butonEchipa.clicked.connect(self.echipaClicked)
        self.butonCompetitie.clicked.connect(self.competitieClicked)
        self.refreshCompetitie.clicked.connect(self.refreshCompetitieClicked)
        self.refreshGazda.clicked.connect(self.refreshGazdaClicked)
        self.refreshDeplasare.clicked.connect(self.refreshDeplasareClicked)

    def inapoiClicked(self):
        adminui = AdminUI()
        widget.addWidget(adminui)
        widget.setCurrentIndex(widget.currentIndex() + 1)

    def refreshCompetitieClicked(self):
        cur = con.cursor()
        cur.execute("SELECT Nume from Competitie")
        lista = cur.fetchall()
        self.competitie.clear()
        for numee in lista:
            self.competitie.addItem(str(numee[0]))
        cur.close()

    def refreshGazdaClicked(self):
        if str(self.deplasare.currentText()) == '':
            cur = con.cursor()
            cur.execute("SELECT Nume from Echipa")
            lista = cur.fetchall()
            self.gazda.clear()
            for numee in lista:
                self.gazda.addItem(str(numee[0]))
            cur.close()
        else:
            cur = con.cursor()
            cur.execute("SELECT ID_Echipa from Echipa WHERE Nume = \'{}\'".format(str(self.deplasare.currentText())))
            id_deplasare = cur.fetchall()
            cur.execute("SELECT Nume from Echipa WHERE ID_Echipa != {}".format(int(id_deplasare[0][0])))
            lista = cur.fetchall()
            self.gazda.clear()
            for numee in lista:
                self.gazda.addItem(str(numee[0]))
            cur.close()
    def refreshDeplasareClicked(self):
        if str(self.gazda.currentText()) == '':
            cur = con.cursor()
            cur.execute("SELECT Nume from Echipa")
            lista = cur.fetchall()
            self.deplasare.clear()
            for numee in lista:
                self.deplasare.addItem(str(numee[0]))
            cur.close()
        else:
            cur = con.cursor()
            cur.execute("SELECT ID_Echipa from Echipa WHERE Nume = \'{}\'".format(str(self.gazda.currentText())))
            id_gazda = cur.fetchall()
            cur.execute("SELECT Nume from Echipa WHERE ID_Echipa != {}".format(int(id_gazda[0][0])))
            lista = cur.fetchall()
            self.deplasare.clear()
            for numee in lista:
                self.deplasare.addItem(str(numee[0]))
            cur.close()
    def competitieClicked(self):
        competitieui = CompetitieUI()
        widget.addWidget(competitieui)
        widget.setCurrentIndex(widget.currentIndex() + 1)
    def echipaClicked(self):
        echipaui = EchipaUI()
        widget.addWidget(echipaui)
        widget.setCurrentIndex(widget.currentIndex() + 1)
    def creareClicked(self):
        qcompetitie = str(self.competitie.currentText())
        qgazda = str(self.gazda.currentText())
        qdeplasare = str(self.deplasare.currentText())
        qziua = str(self.ziua.text())
        qluna = str(self.luna.text())
        qan = str(self.an.text())
        qora = str(self.ora.text())
        qminut = str(self.minut.text())
        qsecunda = str(self.secunda.text())
        data = qziua + '-' + qluna + '-' + qan + ' ' + qora + ':' + qminut + ':' + qsecunda
        cgazda = round(float(self.echipagazda.text()), 2)
        cegal = round(float(self.egal.text()), 2)
        cdeplasare = round(float(self.echipadeplasare.text()), 2)
        cmae = round(float(self.mae.text()), 2)
        csub0 = round(float(self.sub0.text()), 2)
        cpeste0 = round(float(self.peste0.text()), 2)
        csub1 = round(float(self.sub1.text()), 2)
        cpeste1 = round(float(self.peste1.text()), 2)
        csub2 = round(float(self.sub2.text()), 2)
        cpeste2 = round(float(self.peste2.text()), 2)
        csub3 = round(float(self.sub3.text()), 2)
        cpeste3 = round(float(self.peste3.text()), 2)
        cote = [cgazda, cegal, cdeplasare, cmae, csub0, cpeste0, csub1, cpeste1, csub2, cpeste2, csub3, cpeste3]
        cur = con.cursor()
        try:
            cur.execute("INSERT INTO Eveniment VALUES(NULL, (SELECT ID_Competitie FROM Competitie WHERE NUME = \'{}\')"
                        ", (SELECT ID_Echipa FROM Echipa WHERE NUME = \'{}\'), "
                        "(SELECT ID_Echipa FROM Echipa WHERE NUME = \'{}\'), to_date(\'{}\', 'DD-MM-YYYY HH:MI:SS'))".format(qcompetitie, qgazda, qdeplasare, data))
            for i in range(1, 13):
                cur.execute("INSERT INTO Cota_eveniment VALUES(EVENIMENT_ID_SEQ.currval, {}, {})".format(i, cote[i - 1]))
        except cx_Oracle.DatabaseError as exc:
            error, = exc.args
            print("Oracle-Error-Message:", error.message)
            msg = QMessageBox()
            msg.setWindowTitle("Eroare!")
            msg.setText("Oracle-Error-Message:" + error.message)
            msg.setIcon(QMessageBox.Critical)
            msg.exec_()
        else:
            con.commit()
            msg = QMessageBox()
            msg.setWindowTitle("Succes!")
            msg.setText("Eveniment creat!")
            msg.setIcon(QMessageBox.Information)
            msg.exec_()
        cur.close()

class EchipaUI(QDialog):
    def __init__(self):
        super(EchipaUI, self).__init__()
        loadUi("echipa.ui", self)
        self.butonInapoi.clicked.connect(self.inapoiClicked)
        self.butonCreare.clicked.connect(self.creareClicked)
        self.butonSterge.clicked.connect(self.stergeClicked)
        self.tabel.setColumnWidth(0, 250)
        self.tabel.setColumnWidth(1, 250)
        self.tabel.setColumnWidth(2, 250)

        self.loadData()
    
    def loadData(self):
        cur = con.cursor()
        cur.execute("SELECT * FROM Echipa")
        echipe = cur.fetchall()
        index = 0
        self.tabel.setRowCount(len(echipe))
        for ech in echipe:
            self.tabel.setItem(index, 0, QTableWidgetItem(str(ech[1])))
            self.tabel.setItem(index, 1, QTableWidgetItem(str(ech[2])))
            self.tabel.setItem(index, 2, QTableWidgetItem(str(ech[3])))
            index += 1
        cur.close()

        self.tabel.show()
        self.tabel.setEditTriggers(QtWidgets.QTableWidget.NoEditTriggers)

    def inapoiClicked(self):
        evenimentui = EvenimentUI()
        widget.addWidget(evenimentui)
        widget.setCurrentIndex(widget.currentIndex() + 1)
    def creareClicked(self):
        qnume = str(self.nume.text())
        qtara = str(self.tara.text())
        qoras = str(self.oras.text())
        cur = con.cursor()
        try:
            cur.execute("INSERT INTO Echipa VALUES(NULL, \'{}\', \'{}\', \'{}\')".format(qnume, qtara, qoras))
        except cx_Oracle.DatabaseError as exc:
            error, = exc.args
            print("Oracle-Error-Message:", error.message)
            msg = QMessageBox()
            msg.setWindowTitle("Eroare!")
            msg.setText("Oracle-Error-Message:" + error.message)
            msg.setIcon(QMessageBox.Critical)
            msg.exec_()
        else:
            con.commit()
            msg = QMessageBox()
            msg.setWindowTitle("Succes!")
            msg.setText("Echipa creata!")
            msg.setIcon(QMessageBox.Information)
            msg.exec_()
            self.loadData()
        cur.close()
    def stergeClicked(self):
        cur = con.cursor()
        cur.execute("SELECT ID_Echipa FROM Echipa where Nume = \'{}\'".format(str(self.tabel.item(self.tabel.currentRow(), 0).text())))
        idd = cur.fetchall()
        id = int(idd[0][0])
        cur.execute("SELECT ID_Eveniment FROM Eveniment WHERE ID_Echipa_Gazda = {} OR ID_Echipa_Deplasare = {}".format(id, id))
        evv = cur.fetchall()
        try:
            if(len(evv) > 0):
                for i in range(0, len(evv)):
                    cur.execute("DELETE FROM pariu WHERE ID_Eveniment = {}".format(int(evv[i][0])))
                    cur.execute("DELETE FROM cota_eveniment WHERE ID_Eveniment = {}".format(int(evv[i][0])))
                    cur.execute("DELETE FROM eveniment WHERE ID_Eveniment = {}".format(int(evv[i][0])))
            cur.execute("DELETE FROM Echipa WHERE ID_Echipa = {}".format(id))
        except cx_Oracle.DatabaseError as exc:
            error, = exc.args
            print("Oracle-Error-Message:", error.message)
            msg = QMessageBox()
            msg.setWindowTitle("Eroare!")
            msg.setText("Oracle-Error-Message:" + error.message)
            msg.setIcon(QMessageBox.Critical)
            msg.exec_()
        else:
            con.commit()
            msg = QMessageBox()
            msg.setWindowTitle("Succes!")
            msg.setText("Echipa stearsa!")
            msg.setIcon(QMessageBox.Information)
            msg.exec_()
            self.loadData()
        cur.close()
class CompetitieUI(QDialog):
    def __init__(self):
        super(CompetitieUI, self).__init__()
        loadUi("competitie.ui", self)
        self.butonInapoi.clicked.connect(self.inapoiClicked)
        self.butonCreare.clicked.connect(self.creareClicked)
        self.butonSterge.clicked.connect(self.stergeClicked)
        self.tabel.setColumnWidth(0, 150)
        self.tabel.setColumnWidth(1, 150)
        self.tabel.setColumnWidth(2, 150)
        self.tabel.setColumnWidth(3, 150)

        self.loadData()
    
    def loadData(self):
        cur = con.cursor()
        cur.execute("SELECT * FROM Competitie")
        competitii = cur.fetchall()
        index = 0
        self.tabel.setRowCount(len(competitii))
        for com in competitii:
            self.tabel.setItem(index, 0, QTableWidgetItem(str(com[1])))
            self.tabel.setItem(index, 1, QTableWidgetItem(str(com[2])))
            self.tabel.setItem(index, 2, QTableWidgetItem(str(com[3])))
            self.tabel.setItem(index, 3, QTableWidgetItem(str(com[4])))
            index += 1
        cur.close()

        self.tabel.show()
        self.tabel.setEditTriggers(QtWidgets.QTableWidget.NoEditTriggers)

    def inapoiClicked(self):
        evenimentui = EvenimentUI()
        widget.addWidget(evenimentui)
        widget.setCurrentIndex(widget.currentIndex() + 1)
    def creareClicked(self):
        qnume = str(self.nume.text())
        qtara = str(self.tara.text())
        qizi = str(self.izi.text())
        qiluna = str(self.iluna.text())
        qian = str(self.ian.text())
        qiora = str(self.iora.text())
        qiminut = str(self.iminut.text())
        qisecunda = str(self.isecunda.text())
        qtzi = str(self.tzi.text())
        qtluna = str(self.tluna.text())
        qtan = str(self.tan.text())
        qtora = str(self.tora.text())
        qtminut = str(self.tminut.text())
        qtsecunda = str(self.tsecunda.text())
        idata = qizi + '-' + qiluna + '-' + qian + ' ' + qiora + ':' + qiminut + ':' + qisecunda
        tdata = qtzi + '-' + qtluna + '-' + qtan + ' ' + qtora + ':' + qtminut + ':' + qtsecunda
        cur = con.cursor()
        try:
            cur.execute("INSERT INTO Competitie VALUES(NULL, \'{}\', \'{}\', to_date(\'{}\', 'DD-MM-YYYY HH:MI:SS'), to_date(\'{}\', 'DD-MM-YYYY HH:MI:SS'))"
                        .format(qnume, qtara, idata, tdata))
        except cx_Oracle.DatabaseError as exc:
            error, = exc.args
            print("Oracle-Error-Message:", error.message)
            msg = QMessageBox()
            msg.setWindowTitle("Eroare!")
            msg.setText("Oracle-Error-Message:" + error.message)
            msg.setIcon(QMessageBox.Critical)
            msg.exec_()
        else:
            con.commit()
            msg = QMessageBox()
            msg.setWindowTitle("Succes!")
            msg.setText("Competitie creata!")
            msg.setIcon(QMessageBox.Information)
            msg.exec_()
            self.loadData()
        cur.close()
    def stergeClicked(self):
        cur = con.cursor()
        cur.execute("SELECT ID_Competitie FROM Competitie where Nume = \'{}\'".format(str(self.tabel.item(self.tabel.currentRow(), 0).text())))
        idd = cur.fetchall()
        id = int(idd[0][0])
        cur.execute("SELECT ID_Eveniment FROM Eveniment WHERE ID_Competitie = {}".format(id))
        evv = cur.fetchall()
        try:
            if(len(evv) > 0):
                for i in range(0, len(evv)):
                    cur.execute("DELETE FROM pariu WHERE ID_Eveniment = {}".format(int(evv[i][0])))
                    cur.execute("DELETE FROM cota_eveniment WHERE ID_Eveniment = {}".format(int(evv[i][0])))
                    cur.execute("DELETE FROM eveniment WHERE ID_Eveniment = {}".format(int(evv[i][0])))
            cur.execute("DELETE FROM Competitie WHERE ID_Competitie = {}".format(id))
        except cx_Oracle.DatabaseError as exc:
            error, = exc.args
            print("Oracle-Error-Message:", error.message)
            msg = QMessageBox()
            msg.setWindowTitle("Eroare!")
            msg.setText("Oracle-Error-Message:" + error.message)
            msg.setIcon(QMessageBox.Critical)
            msg.exec_()
        else:
            con.commit()
            msg = QMessageBox()
            msg.setWindowTitle("Succes!")
            msg.setText("Competitie stearsa!")
            msg.setIcon(QMessageBox.Information)
            msg.exec_()
            self.loadData()
        cur.close()


if __name__ == '__main__':
    app = QApplication(sys.argv)
    mainwindow = MainUI()
    widget = QtWidgets.QStackedWidget()
    widget.addWidget(mainwindow)
    widget.setFixedWidth(1420)
    widget.setFixedHeight(800)
    widget.setWindowTitle("Baze de date")
    widget.show()
    app.exec_()