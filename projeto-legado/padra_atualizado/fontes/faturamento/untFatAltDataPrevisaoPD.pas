unit untFatAltDataPrevisaoPD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, untTypesSistema,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, untFuncoesSimples,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmFatAltDataPrevisaoPD = class(TfrmPaiOrdena)
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lbl1: TLabel;
    lbl6: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    lbl7: TLabel;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    shpMultSel: TShape;
    rdgDatas: TRadioGroup;
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
  private
    arrVen,
    arrCli  : TConsultasArray;
    procedure pAtualizaPrevisao(dtsFatGor: TDataSet);
  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fSetParametros: Boolean; override;
  end;


implementation

uses untFuncoesConsulta, untConsultas;

{$R *.dfm}

function TfrmFatAltDataPrevisaoPD.fGetSql(blnLike: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT FGO_NUMDOC, ';
  strSQL := strSQL + '       FGO_ESPDOC, ';
  strSQL := strSQL + '       FGO_CODEMP, ';
  strSQL := strSQL + '       FGO_CODCLI, ';
  strSQL := strSQL + '       IF(FGO_NOMCON = "" OR FGO_NOMCON IS NULL, CLI_NOMCLI, FGO_NOMCON) AS "FGO_NOMCLI", ';
  strSQL := strSQL + '       FGO_CODVEN, ';
  strSQL := strSQL + '       FGO_DTAENT, ';
  strSQL := strSQL + '       FGO_VLRCON, ';
  strSQL := strSQL + '       FGO_PREVIS, ';
  strSQL := strSQL + '       FATGOR.AUTOINCREM AS "AUTOINCREM" ';
  strSQL := strSQL + '  FROM FATGOR ';
  strSQL := strSQL + ' INNER JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + ' WHERE FGO_CODEMP = ' + QuotedStr(VS_strCodEmp);
  strSQL := strSQL + '   AND FGO_ESPDOC = "PD" ';

  If (rdgDatas.ItemIndex = 0) Then
    strSQL := strSQL + '  AND FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN '
  Else 
    strSQL := strSQL + '  AND FGO_PREVIS BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(edtCodVen.Text) Then
    strSQL := strSQL + fStrLocate(edtCodVen, arrVen, 'FGO_CODVEN', 'CODVEN');

  If Not fEmptyStr(edtCodCli.Text) Then
    strSQL := strSQL + fStrLocate(edtCodCli, arrCli, 'FGO_CODCLI', 'CODCLI');

  If (Not fCfgSis('MOPDFA', varBoolean)) Then
    strSQL := strSQL + '  AND FGO_JAFATU = FALSE ';

  Result := strSQL;
End;

procedure TfrmFatAltDataPrevisaoPD.pAtualizaPrevisao(dtsFatGor: TDataSet);
  Var
    qryPrevis: TUniQuery;
Begin
  qryPrevis := fCriaQuery(Self);

  With qryPrevis Do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE FATGOR SET FGO_PREVIS = :PREVIS');
    SQL.Add('WHERE AUTOINCREM = :AUTINC');

    ParamByName('PREVIS').AsDate   := dtsFatGor.FieldByName('FGO_PREVIS').AsDateTime;
    ParamByName('AUTINC').AsString := dtsFatGor.FieldByName('AUTOINCREM').AsString;

    ExecSQL;
  End;

  FreeAndNil(qryPrevis);
End;

procedure TfrmFatAltDataPrevisaoPD.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;
  pAtualizaPrevisao(DataSet);
end;

function TfrmFatAltDataPrevisaoPD.fSetParametros: Boolean;
  Var
    strVen : String;
    strCli : String;
Begin
  Result := TRUE;
  With qryConsulta Do
  Begin

    If Not (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    pSetaParam(edtCodVen.Text, arrVen, strVen, 'CODVEN', qryConsulta);
    pSetaParam(edtCodCli.Text, arrCli, strCli, 'CODCLI', qryConsulta);

  End;
End;

function TfrmFatAltDataPrevisaoPD.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&OK']);
        Result := FALSE;
      End

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&OK']);
        Result := False;
      End
      Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&OK']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodCli) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&OK']);
        Result := FALSE;
        Sender := mskDtaIni;
      End
      Else
      Begin
        fAbreConsulta(TRUE);
        cdsConsulta.FieldByName('FGO_PREVIS').FocusControl;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatAltDataPrevisaoPD.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(rdgDatas.Buttons[0]);
end;

procedure TfrmFatAltDataPrevisaoPD.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  If pnlPesquisa.Visible Then
    inherited
  Else
  Case Key Of

    VK_RETURN: If cdsConsulta.State = dsEdit Then
               Begin
                 cdsConsulta.Post;
                 cdsConsulta.FieldByName('FGO_PREVIS').FocusControl;
               End
               Else If cdsConsulta.Active And (Not SameText(dbgConsulta.SelectedField.FieldName,'FGO_PREVIS')) Then
               Begin
                 cdsConsulta.FieldByName('FGO_PREVIS').FocusControl;
                 cdsConsulta.Edit;
               End
               Else
                 inherited;

    VK_ESCAPE: If cdsConsulta.State = dsEdit Then
                 cdsConsulta.Cancel
               Else
                 If ((ActiveControl) = mskDtaIni) Then
                   inherited
                 Else
                 Begin
                   mskDtaIni.Clear;
                   mskDtaFin.Clear;
                   cdsConsulta.Close;
                   pSetFocus(mskDtaIni);
                 End;

    Else       inherited;

  End;

end;

procedure TfrmFatAltDataPrevisaoPD.FormShow(Sender: TObject);
begin
  inherited;

  blnSempreRelerBanco := FALSE;
  blnTemSelecao       := FALSE;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftDateTime;
end;

procedure TfrmFatAltDataPrevisaoPD.cdsConsultaBeforePost(
  DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  If FieldByName('FGO_PREVIS').AsDateTime < FieldByName('FGO_DTAENT').AsDateTime Then
  Begin
    fMensagem('ATENÇÃO!', 'A Data de Previsão deve ser maior ou igual a Data de Entrada!', ['&O k']);
    Cancel;
    Abort;
  End;

end;

procedure TfrmFatAltDataPrevisaoPD.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCli, arrCli, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmFatAltDataPrevisaoPD.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatAltDataPrevisaoPD.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtDesVen, arrVen, fRetNomeOperador, Nil, 'do Vendedor');
end;

procedure TfrmFatAltDataPrevisaoPD.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtDesVen, Nil, Key, arrVen, False) Then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.
