unit untCadCotItensFornec;

interface

uses
  Windows, Classes, Controls, Forms, untPaiOrdena, StdCtrls, DBCtrls, DB, UniClientDataSet,
  UniDataSetProvider, Uni, AppEvnts, Menus, EditFocus, Mask, MaskEditFocus, Grids,
  DBGridCitel, DBGrids, Buttons, ExtCtrls, DBLookupComboBoxFocus, DBEditFocus, BitBtnLockedIncrem,
  MemDS, DBAccess, Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient;

type
  TfrmCadCotItensFornec = class(TfrmPaiOrdena)
    Fornecedor: TLabel;
    dbLookCodFor: TDBLookupComboBoxFocus;
    Label1: TLabel;
    dbeTotFor: TDBEditFocus;
    cdsConsultaTOTFOR: TAggregateField;
    dbeDtaEnt: TDBEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    dbeConPag: TDBEditFocus;
    dtsCotCfo: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbLookCodForClick(Sender: TObject);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    blnEdiCot : Boolean;
  public
    { Public declarations }
    strSeqGer: String;

    procedure pAbreConsulta;

    Procedure pSetaFiltro;

    procedure pDesabilitaAlteracao;

  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fGetFilter: String;  Override;
    Procedure pSetFilterDefault;  Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadCotItensFornec: TfrmCadCotItensFornec;

implementation

uses SysUtils, Variants, Graphics, untPai, untFuncoesSimples;

{$R *.dfm}

Const
  COL_UNITAR = 5;

Procedure TfrmCadCotItensFornec.pSetaFiltro;
Begin
  pSetFilterDefault;
End;

function TfrmCadCotItensFornec.fGetFilter: String;
Begin
  Result := Inherited fGetFilter;

  If fEmptyStr(dbLookCodFor.Text) Or (dbLookCodFor.KeyValue = Null) Then
  Begin
    Result := ' CODFOR = -1 ';
    Exit;
  End;

  If Not fEmptyStr(Result) Then
    Result := Result + ' AND ';

  Result := Result + ' CODFOR = ' + dbLookCodFor.KeyValue;

End;

Procedure TfrmCadCotItensFornec.pSetFilterDefault;
Begin

  If fEmptyStr(dbLookCodFor.Text) Or (dbLookCodFor.KeyValue = Null) Then
    cdsConsulta.Filter := ' CODFOR = -1'
  Else
    cdsConsulta.Filter := ' CODFOR = ' + dbLookCodFor.KeyValue;

  cdsConsulta.Filtered := TRUE;

End;

function TfrmCadCotItensFornec.fGetSql(blnLike: Boolean): String;
Begin

  Result := '';
  Result := Result + ' SELECT                                          ';
  Result := Result + '   CI.ITE_CODITE AS AUTOINCREM,                  ';
  Result := Result + '   COT_CODFOR AS CODFOR,                         ';
  Result := Result + '   FO.FOR_NOMFOR AS NOMFOR,                      ';
  Result := Result + '   CI.ITE_CODITE AS CODITE,                      ';
  Result := Result + '   CI.ITE_CODSIM AS CODSIM,                      ';
  Result := Result + '   CAST((SELECT GROUP_CONCAT(SEM_CODSEM) FROM CADSEM WHERE CI.ITE_CODITE = SEM_CODITE) AS CHAR(255)) AS CODSEM, ';
  Result := Result + '   CI.ITE_CODFAB AS CODFAB,                      ';
  Result := Result + '   CI.ITE_CODGRU AS CODGRU,                      ';
  Result := Result + '   CI.ITE_MSGLV1 AS MSGLV1,                      ';

  Result := Result + '   IG.ITE_PRECUS AS PRECUS,                      ';

  Result := Result + '   IF(CI.ITE_APLICA IS NULL, "", CI.ITE_APLICA) AS APLICA, ';
  If blnEdiCot then
    Result := Result + '   COT_DESITE AS DESITE, '
  Else
    Result := Result + '   IF(LOCATE("ITEM ESPECIAL", ITE_DESITE) > 0, COT_DESITE, ITE_DESITE) AS DESITE, ';
  Result := Result + '   CI.ITE_REFERE AS REFERE,                      ';
  Result := Result + '   CI.ITE_CODUNI AS CODUNI,                      ';
  Result := Result + '   UNI_SIGUNI AS SIGUNI,                         ';
  Result := Result + '   MAR_DESMAR AS DESMAR,                         ';  
  Result := Result + '   COT_QTDITE AS QTDITE,                         ';
  Result := Result + '   COT_VALUNI AS VALUNI,                         ';
  Result := Result + '   COT_IPIENT AS IPIENT,                         ';
  Result := Result + '   COT_SUBSTI AS SUBSTI,                         ';

  Result := Result + '   (COT_VALUNI * COT_QTDITE)                        ';
  Result := Result + '     + (COT_IPIENT * COT_VALUNI * COT_QTDITE) / 100 ';
  Result := Result + '     + (COT_SUBSTI * COT_VALUNI * COT_QTDITE) / 100 ';
  Result := Result + '       AS VALTOT,                                   ';

  Result := Result + '   COT_STATUS AS STATUS,                         ';
  Result := Result + '   CAST(0 AS UNSIGNED) AS PREESC,                ';

  Result := Result + '  (SELECT UG.ITE_DTAULT                             FROM ITEGER UG WHERE UG.ITE_CODITE = IG.ITE_CODITE ORDER BY UG.ITE_DTAULT DESC, UG.ITE_DHUPES DESC LIMIT 1) AS DTAULT, ';
  Result := Result + '  (SELECT CONCAT(UG.ITE_FORULT, "-", UF.FOR_NOMFOR) FROM ITEGER UG INNER JOIN CADFOR UF ON UF.FOR_CODFOR = UG.ITE_FORULT ';
  Result := Result + '                                                                   WHERE UG.ITE_CODITE = IG.ITE_CODITE ORDER BY UG.ITE_DTAULT DESC, UG.ITE_DHUPES DESC LIMIT 1) AS FORULT, ';
  Result := Result + '  (SELECT UG.ITE_PREULT                             FROM ITEGER UG WHERE UG.ITE_CODITE = IG.ITE_CODITE ORDER BY UG.ITE_DTAULT DESC, UG.ITE_DHUPES DESC LIMIT 1) AS PREULT  ';

  Result := Result + ' FROM                                            ';
  Result := Result + '   COTFOR F                                      ';
  Result := Result + ' INNER JOIN COTITE I ON                          ';
  Result := Result + '   I.COT_SEQGER = F.COT_SEQGER AND               ';
  Result := Result + '   I.COT_CODITE = F.COT_CODITE                   ';
  Result := Result + ' INNER JOIN CADFOR FO ON FO.FOR_CODFOR = COT_CODFOR    ';
  Result := Result + ' INNER JOIN CADITE CI ON CI.ITE_CODITE = I.COT_CODITE  ';
  Result := Result + ' INNER JOIN ITEGER IG ON IG.ITE_CODITE = I.COT_CODITE AND ';
  Result := Result + '                         IG.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + ' LEFT  JOIN CADUNI ON CI.ITE_CODUNI = UNI_CODUNI    ';
  Result := Result + ' LEFT  JOIN CADMAR ON CI.ITE_CODMAR = MAR_CODMAR    ';  
  Result := Result + ' LEFT  JOIN CADFOR UF ON UF.FOR_CODFOR = IG.ITE_FORULT ';
  Result := Result + ' WHERE                                           ';
  Result := Result + '   I.COT_SEQGER = ' + QuotedStr(strSeqGer) + '   ';

End;

procedure TfrmCadCotItensFornec.FormShow(Sender: TObject);
begin
  inherited;
  blnTemSelecao := FALSE;
  pLimpaEventoEdits;

end;

procedure TfrmCadCotItensFornec.pAbreConsulta;
Begin
  blnSempreRelerBanco := FALSE;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  fAbreConsulta(TRUE);

  TFloatField(cdsConsulta.FieldByName('VALUNI')).DisplayFormat := '#,##0.0000';
  TFloatField(cdsConsulta.FieldByName('PREULT')).DisplayFormat := '#,##0.00';

End;

procedure TfrmCadCotItensFornec.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  Action := caNone;

end;

procedure TfrmCadCotItensFornec.FormCreate(Sender: TObject);
begin
  inherited;
  blnEdiCot := fCfgSis('EDICOT', varBoolean);

  blnFecharComEscape      := False;
end;

procedure TfrmCadCotItensFornec.dbLookCodForClick(Sender: TObject);
begin
  inherited;

  pLimpaPesquisa;

  pSetFilterDefault;

end;

procedure TfrmCadCotItensFornec.cdsConsultaBeforePost(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin

    If FieldByName('VALUNI').AsFloat < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor unitário deve ser maior ao igual a zero.', ['&Ok']);
      pSetFocus(dbgConsulta);
      Abort;
      Exit;
    End;

    If FieldByName('IPIENT').AsFloat < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Percentaul de IPI deve ser maior ao igual a zero.', ['&Ok']);
      pSetFocus(dbgConsulta);
      Abort;
      Exit;
    End;

    If FieldByName('SUBSTI').AsFloat < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Percentaul de Substituição deve ser maior ao igual a zero.', ['&Ok']);
      pSetFocus(dbgConsulta);
      Abort;
      Exit;
    End;

    FieldByName('VALTOT').AsFloat :=
       FieldByName('VALUNI').AsFloat * FieldByName('QTDITE').AsFloat +
       (FieldByName('VALUNI').AsFloat * FieldByName('QTDITE').AsFloat) * FieldByName('IPIENT').AsFloat / 100 +
       (FieldByName('VALUNI').AsFloat * FieldByName('QTDITE').AsFloat) * FieldByName('SUBSTI').AsFloat / 100;

  End;

end;

procedure TfrmCadCotItensFornec.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  If Not cdsConsulta.Active Then
    Exit;

  If Pos(Column.FieldName, 'DTAULT_FORULT_PREULT') > 0 Then
  Begin
    dbgConsulta.Canvas.Brush.Color := 13434828;
    dbgConsulta.Canvas.Font.Color  := clBlack;    
    dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

  inherited;
end;

procedure TfrmCadCotItensFornec.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: Begin
                 If dbgConsulta.SelectedIndex < COL_UNITAR Then
                   dbgConsulta.SelectedIndex := COL_UNITAR

                 Else If (cdsConsulta.State = dsEdit) Then
                 Begin

                   If (dbgConsulta.SelectedField.FieldName = 'VALUNI') Then
                    dbgConsulta.SelectedIndex := COL_UNITAR + 1

                   Else If (dbgConsulta.SelectedField.FieldName = 'IPIENT') Then
                    dbgConsulta.SelectedIndex := COL_UNITAR + 2

                   Else If (dbgConsulta.SelectedField.FieldName = 'SUBSTI') Then
                   Begin
                     cdsConsulta.Next;
                     dbgConsulta.SelectedIndex := COL_UNITAR
                   End;

                 End

               End;

    VK_ESCAPE: Begin
                 If Shift = [ssCtrl] Then
                   Key := 0;
               End;
  End;

end;

procedure TfrmCadCotItensFornec.pDesabilitaAlteracao;
Begin
  dbgConsulta.Options := dbgConsulta.Options - [dgEditing];
  dbeDtaEnt.ReadOnly  := TRUE;
  dbeConPag.ReadOnly  := TRUE;
End;

function TfrmCadCotItensFornec.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  blnMudarFoco := FALSE;
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbLookCodFor) Then
      pSetFocus(dbeDtaEnt)

    Else If (Sender = dbeDtaEnt) Then
    Begin

     If fEmptyStr(fTiraCaracEspeciais(dbeDtaEnt.Text)) Then
     Begin
       fMensagem('ATENÇÃO!', 'Informe a data de entrega!', ['&O k']);
       Result := False;
     End

     Else If dtsCotCfo.DataSet.State = dsEdit Then
     Begin
       dtsCotCfo.DataSet.Post;
       pSetFocus(dbeConPag);
     End;

    End

    Else If (Sender = dbeConPag) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(dbeConPag.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaCndPag(dbeConPag.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
        Result := False;
      End

      Else If dtsCotCfo.DataSet.State = dsEdit Then
      Begin
        dtsCotCfo.DataSet.Post;
        If dbgConsulta.CanFocus Then
        Begin
          pSetFocus(dbgConsulta);
          dbgConsulta.SelectedIndex := COL_UNITAR;
        End;  
      End;  

    End;

  End;

  If (Not Result) Then
  Begin
    If dtsCotCfo.DataSet.State = dsEdit Then
      dtsCotCfo.DataSet.Cancel;

    pSetFocus(Sender);
  End;

end;



procedure TfrmCadCotItensFornec.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F3: Key := 0;
    VK_F5: Key := 0;
  End;

  Case Key Of
    VK_RETURN: If dbLookCodFor.Focused And dbeDtaEnt.CanFocus Then
               Begin
                 If dtsCotCfo.DataSet.State <> dsEdit Then
                   dtsCotCfo.DataSet.Edit;
                 pSetFocus(dbeDtaEnt);
               End;  
  End;
                 
end;

end.
