{**************************************************}
{* RELATORIO DE LOG DE LIBERAÇÕES                 *}
{*                                                *}
{* DATA......: 22/08/2007                         *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI           *}
{*                                                *}
{***********************************************AF*}
unit untRelFatLogLib;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, frxDesgn,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, StrUtils, Uni, AppEvnts, untTypesSistema,
  BitBtnLockedIncrem, ComCtrls, frxExportCSVTestabilidade;

type
  TfrmRelFatLogLib = class(TfrmPaiRelatorio)
    Label11: TLabel;
    lblDesDtaIni: TLabel;
    lblDesDtaFin: TLabel;
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label1: TLabel;
    edtCodOpe: TEditFocus;
    edtDesOpe: TEditFocus;
    Label2: TLabel;
    edtOpeLib: TEditFocus;
    edtDesOpeLib: TEditFocus;
    edtNumDoc: TEditFocus;
    Label3: TLabel;
    edtEspecie: TEditFocus;
    Label4: TLabel;
    edtMotLib: TEditFocus;
    Label5: TLabel;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    pgbProgresso: TProgressBar;
    procedure edtCodOpeExit(Sender: TObject);
    procedure edtOpeLibExit(Sender: TObject);
    procedure edtOpeLibKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtEspecieExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    qryCadEmp: TUniQuery;
    QryRel   : TUniQuery;

    procedure pCarregaEmpresa(strCodEmp: String);
    procedure pGeraExcel;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelFatLogLib: TfrmRelFatLogLib;

implementation

uses untIFuncoes, untGeraExcel, untFuncoesFactory, DB, untQckFatLogLib;

{$R *.dfm}

procedure TfrmRelFatLogLib.edtCodOpeExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodOpe.Text) Then
    edtDesOpe.Text := 'TODOS'
  Else
    edtDesOpe.Text := fRetNomVendRep(edtCodOpe.Text);

  If fEmptyStr(edtDesOpe.Text) And (Not fEmptyStr(edtCodOpe.Text))  Then
  Begin
    fMensagem('AVISO','Operador não encontrado.', ['&O K']);
    edtCodOpe.Clear;
    pSetFocus(edtCodOpe);
  End;

end;

procedure TfrmRelFatLogLib.edtCodOpeKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqOperador(Self, edtCodOpe, edtDesOpe, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatLogLib.edtOpeLibExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtOpeLib.Text) Then
    edtDesOpeLib.Text := 'TODOS'
  Else
    edtDesOpeLib.Text := fRetNomVendRep(edtOpeLib.Text);

  If fEmptyStr(edtDesOpeLib.Text) And (Not fEmptyStr(edtOpeLib.Text))  Then
  Begin
    fMensagem('AVISO','Operador não encontrado.', ['&O K']);
    edtOpeLib.Clear;
    pSetFocus(edtOpeLib);
  End;

end;

procedure TfrmRelFatLogLib.edtOpeLibKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqOperador(Self, edtOpeLib, edtDesOpeLib, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatLogLib.btnImprimirClick(Sender: TObject);
Var
  strSQL : String;
  strSQL1: String;
  strSQL2: String;
begin

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin

    QryRel := fCriaQuery;

    With QryRel Do
    Begin
      Close;
      SQL.Clear;

      strSQL := '';
      strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  L.*, ';
      strSQL := strSQL + '  CONCAT(LOG_CODOPE, " - " ,O.OPE_NOMOPE) AS OPEEXL, ';
      strSQL := strSQL + '  CONCAT(LOG_CODVEN, " - " ,V.OPE_NOMOPE) AS VENEXL, ';

      strSQL := strSQL + '  (  ';

      strSQL1 := '';
      strSQL1 := strSQL1 + '   SELECT SQL_NO_CACHE CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS CLIENTE ';
      strSQL1 := strSQL1 + '   FROM MOVGER, CADCLI ';
      strSQL1 := strSQL1 + '   WHERE GER_CODCLI = CLI_CODCLI AND ';
      strSQL1 := strSQL1 + '   L.LOG_CODEMP = GER_CODEMP AND ';
      strSQL1 := strSQL1 + '   GER_NUMDOC = L.LOG_NUMDOC AND ';
      strSQL1 := strSQL1 + '   GER_ESPDOC = L.LOG_ESPDOC ';

      strSQL  := strSQL + strSQL1;

      strSQL := strSQL + '   UNION ALL ';
      strSQL := strSQL + '   SELECT SQL_NO_CACHE CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS CLIENTE ';
      strSQL := strSQL + '   FROM FATGOR, CADCLI ';
      strSQL := strSQL + '   WHERE FGO_CODCLI = CLI_CODCLI AND ';
      strSQL := strSQL + '   L.LOG_CODEMP = FGO_CODEMP AND ';
      strSQL := strSQL + '   FGO_NUMDOC = L.LOG_NUMDOC AND ';
      strSQL := strSQL + '   FGO_ESPDOC = L.LOG_ESPDOC ';

      strSQL := strSQL + '  LIMIT 1) AS LOG_NOMCLI ';


      strSQL := strSQL + 'FROM       ';
      strSQL := strSQL + '  LOGLIB L ';

      strSQL := strSQL + ' LEFT JOIN CADOPE O ON ';
      strSQL := strSQL + ' O.OPE_CODOPE = LOG_CODOPE ';

      strSQL := strSQL + ' LEFT JOIN CADOPE V ON ';
      strSQL := strSQL + ' V.OPE_CODOPE = LOG_CODVEN ';


      strSQL := strSQL + 'WHERE      ';

      If (mskDtaIni.Enabled) Then
      Begin
        strSQL := strSQL + '  L.LOG_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

        If (Not fEmptyStr(edtEspecie.Text)) Then
          strSQL := strSQL + ' AND  L.LOG_ESPDOC = :ESPDOC ';

        If (Not fEmptyStr(edtNumDoc.Text)) Then
          strSQL := strSQL + '  AND L.LOG_NUMDOC = :NUMDOC ';

        If Not fEmptyStr(edtOpeLib.Text) Then
          strSQL := strSQL + ' AND L.LOG_CODOPE = :CODOPE ';

        If Not fEmptyStr(edtCodOpe.Text) Then
          strSQL := strSQL + ' AND L.LOG_CODVEN = :CODVEN ';

      End
      Else
      Begin
        strSQL := strSQL + '  1 = 1 ';

        If (Not fEmptyStr(edtNumDoc.Text)) Then
          strSQL := strSQL + '  AND LOG_NUMDOC = :NUMDOC ';

        If (Not fEmptyStr(edtEspecie.Text)) Then
          strSQL := strSQL + '  AND LOG_ESPDOC = :ESPDOC ';

      End;

      If Not fEmptyStr(edtCodEmp.Text) Then
        strSQL := strSQL + ' AND L.LOG_CODEMP = :CODEMP ';

      If Not fEmptyStr(edtMotLib.Text) Then
      Begin
        strSQL := strSQL + '  AND (LOCATE(UPPER(:OBSERV),UPPER(LOG_OBSERV)) > 0) ';
      End;

      SQL.Add(strSQL);

      If (mskDtaIni.Enabled) Then
      Begin

        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

        If Not fEmptyStr(edtOpeLib.Text) Then
          ParamByName('CODOPE').AsString := edtOpeLib.Text;

        If Not fEmptyStr(edtCodOpe.Text) Then
          ParamByName('CODVEN').AsString := edtCodOpe.Text;

        If (Not fEmptyStr(edtNumDoc.Text)) Then
          ParamByName('NUMDOC').AsString := edtNumDoc.Text;

        If (Not fEmptyStr(edtEspecie.Text)) Then
          ParamByName('ESPDOC').AsString := edtEspecie.Text;

      End
      Else
      Begin
        If (Not fEmptyStr(edtNumDoc.Text)) Then
          ParamByName('NUMDOC').AsString := edtNumDoc.Text;

        If (Not fEmptyStr(edtEspecie.Text)) Then
          ParamByName('ESPDOC').AsString := edtEspecie.Text;

      End;

      If (Not fEmptyStr(edtCodEmp.Text)) Then
        ParamByName('CODEMP').AsString := edtCodEmp.Text;

      If Not fEmptyStr(edtMotLib.Text) Then
        ParamByName('OBSERV').AsString := edtMotLib.Text;

      Open;
    End;

    If Not QryRel.IsEmpty Then
    Begin
      Try
        If edtDestino.Text = 'E' Then
          pGeraExcel
        Else
        Begin
          pCriarFormularios(TfrmQckFatLogLib,frmQckFatLogLib);

          If strTipImp = 'M' Then
            frmQckFatLogLib.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckFatLogLib.qckPagina.DefaultFilter := Nil;

          If Not fEmptyDate(mskDtaIni.Text) Then
            frmQckFatLogLib.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          If Not fEmptyStr(edtCodOpe.Text) Then
            frmQckFatLogLib.rllOperadorHea.Caption := 'OPERADOR: ' + edtCodOpe.Text + '-' + edtDesOpe.Text
          Else
            frmQckFatLogLib.rllOperadorHea.Caption := 'OPERADOR: TODOS ';

          If Not fEmptyStr(edtOpeLib.Text) Then
            frmQckFatLogLib.rllOpeLibHea.Caption := 'OPERADOR LIBERACAO: ' + edtOpeLib.Text + '-' + edtDesOpeLib.Text
          Else
            frmQckFatLogLib.rllOpeLibHea.Caption := 'OPERADOR LIBERACAO: TODOS ';

          If Not fEmptyStr(edtCodEmp.Text) Then
            frmQckFatLogLib.rllEmpresa.Caption := 'EMPRESA: ' + edtCodEmp.Text + '-' + edtDesEmp.Text
          Else
            frmQckFatLogLib.rllEmpresa.Caption := 'EMPRESA: TODAS ';

          frmQckFatLogLib.dtsRelatorio.dataset := QryRel;

          If edtDestino.Text = 'V' Then
            frmQckFatLogLib.qckPagina.PreviewModal
          Else
            frmQckFatLogLib.qckPagina.Print;
        End;    

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckFatLogLib);
    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;

  If (edtNumDoc.Enabled) Then
    pSetFocus(edtNumDoc)
  Else
    pSetFocus(mskDtaIni);

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

  if (QryRel <> Nil) then
    FreeAndNil(QryRel);
end;

function TfrmRelFatLogLib.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  {*********************}
  {* VALIDA DATAS      *}
  {******************LU*}
  If ((Sender = mskDtaIni) Or (Sender = mskDtaFin)) And mskDtaIni.Enabled Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
      Result := False;
      If (Sender = mskDtaFin) Then
        Sender := mskDtaIni;
    End

    Else
    Begin
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End;
        End;
      End
    End;
  End
  Else If (Sender = edtCodEmp) Then
  Begin
    If fEmptyStr(edtCodEmp.Text) Then
      edtDesEmp.Text := 'TODAS'
    Else
    Begin
      pCarregaEmpresa(edtCodEmp.Text);
      If (qryCadEmp.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!','Essa empresa não está cadastrada!',['&O K']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelFatLogLib.pCarregaEmpresa(strCodEmp: String);
begin
  pPesquisaCadEmp(Nil, qryCadEmp, edtCodEmp.Text);
  edtDesEmp.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmRelFatLogLib.pGeraExcel;
  Var
    objGeraExcel: TGeraExcel;
begin
  Try
    objGeraExcel := TGeraExcel.Create(QryRel , pgbProgresso);

    With objGeraExcel Do
    Begin
      strNomRel := 'RELATÓRIO DE LOG DE LIBERAÇÃO REMOTA (LIBERADOS)';

      If Not fEmptyDate(mskDtaIni.Text) Then
        AddFiltro('REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);

      If Not fEmptyStr(edtCodOpe.Text) Then
        AddFiltro('OPERADOR: ' + edtCodOpe.Text + '-' + edtDesOpe.Text)
      Else
        AddFiltro('OPERADOR: TODOS ');

      If Not fEmptyStr(edtOpeLib.Text) Then
        AddFiltro('OPERADOR LIBERACAO: ' + edtOpeLib.Text + '-' + edtDesOpeLib.Text)
      Else
        AddFiltro('OPERADOR LIBERACAO: TODOS ');

      If Not fEmptyStr(edtCodEmp.Text) Then
        AddFiltro('EMPRESA: ' + edtCodEmp.Text + '-' + edtDesEmp.Text)
      Else
        AddFiltro('EMPRESA: TODAS ');


      AddCampo('LOG_NUMDOC', 'DOCUMENTO');
      AddCampo('LOG_CODEMP', 'EMP');
      AddCampo('LOG_DTACAD', 'DTA.CAD.');
      AddCampo('LOG_HRACAD', 'HRA.CAD.');
      AddCampo('VENEXL'    , 'OPERADOR');
      AddCampo('OPEEXL'    , 'OPERADOR LIBERACAO');
      AddCampo('LOG_NOMCLI', 'CLIENTE');
      AddCampo('LOG_OBSERV', 'MOTIVO');

      If fGerarRelatorio Then
        fMensagem('', 'Arquivo gerado com sucesso!', ['&OK']);

    End;
    FreeAndNil(objGeraExcel);

  Except
    On E : Exception Do
    Begin
      FreeAndNil(objGeraExcel);
      pMensagensErro(E.Message, '[frmRelFatLogLib.pGeraExcel]');

    End;

  End;

end;

procedure TfrmRelFatLogLib.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
end;

procedure TfrmRelFatLogLib.FormCreate(Sender: TObject);
begin
  inherited;
  blnExcel := True;
end;

procedure TfrmRelFatLogLib.FormShow(Sender: TObject);
begin
  inherited;

  qryCadEmp := fCriaQuery(Self);

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;
end;

procedure TfrmRelFatLogLib.edtEspecieExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtEspecie.Text)) Then
  Begin
    mskDtaIni.Enabled := False;
    mskDtaFin.Enabled := False;
    edtCodOpe.Enabled := False;
    edtOpeLib.Enabled := False;
    //edtCodEmp.Enabled := False;

    mskDtaIni.Clear;
    mskDtaFin.Clear;
    edtCodOpe.Clear;
    edtDesOpe.Clear;
    edtOpeLib.Clear;
    edtDesOpeLib.Clear;
    //edtCodEmp.Clear;

    If (Sender = edtEspecie) Then
      pSetFocus(edtCodEmp);

  End
  Else
  Begin
//    mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
//    mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
    mskDtaIni.Enabled := True;
    mskDtaFin.Enabled := True;
    edtCodOpe.Enabled := True;
    edtOpeLib.Enabled := True;
    //edtCodEmp.Enabled := True;

    If (Sender = edtEspecie) Then
      pSetFocus(mskDtaIni);

  End;
end;

procedure TfrmRelFatLogLib.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatLogLib.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmp.Text) Then
    edtDesEmp.Text := 'TODAS'
  Else
    edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

  If fEmptyStr(edtDesEmp.Text) And (Not fEmptyStr(edtCodEmp.Text))  Then
  Begin
    fMensagem('AVISO','Empresa não encontrada.', ['&O K']);
    edtCodEmp.Clear;
    pSetFocus(edtCodEmp);
  End;
end;

end.