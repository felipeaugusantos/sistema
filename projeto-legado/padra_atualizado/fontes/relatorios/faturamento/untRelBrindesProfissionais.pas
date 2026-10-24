unit untRelBrindesProfissionais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDMPClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  RLFilters, RLDraftFilter, Menus, StdCtrls, EditFocus, QColorLabel, ExtCtrls,
  Buttons, Mask, MaskEditFocus, Uni, AppEvnts, StrUtils, BitBtnLockedIncrem,
  frxExportCSVTestabilidade;

type
  TfrmRelBrindesProfissionais = class(TfrmPaiRelatorio)
    frxPaginaM: TfrxReport;
    Label3: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbTipRel: TGroupBox;
    ColorLabel2: TColorLabel;
    edtTipRel: TEditFocus;
    rdgOpcao: TRadioGroup;
    frxPaginaJ: TfrxReport;
    frxSaldo: TfrxDBDataset;
    Label5: TLabel;
    edtNomVendedor: TEditFocus;
    edtCodVendedor: TEditFocus;
    rdgAssoci: TRadioGroup;
    gpb1: TGroupBox;
    ColorLabel3: TColorLabel;
    edtCreDeb: TEditFocus;
    ColorLabel4: TColorLabel;
    ColorLabel5: TColorLabel;
    ColorLabel6: TColorLabel;
    rdgEmpresa: TRadioGroup;
    Label14: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    Panel1: TPanel;
    Label2: TLabel;
    lblDtaIni: TLabel;
    lblDtaFin: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodProfissional: TEditFocus;
    edtNomProfissional: TEditFocus;
    pnlCodPar: TPanel;
    Label6: TLabel;
    edtCodPar: TEditFocus;
    edtNomPar: TEditFocus;
    pnlTipBri: TPanel;
    rdgAgrPor: TRadioGroup;
    gpbTipBri: TGroupBox;
    clbTipBri: TColorLabel;
    edtTipBri: TEditFocus;
    edtCodMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    Label7: TLabel;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodProfissionalKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodProfissionalExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodParExit(Sender: TObject);
    procedure edtCodParKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarcaExit(Sender: TObject);
  private
    { Private declarations }
    arrProfis,
    arrParceiro,
    arrCliente,
    arrRede,
    arrEmpresa,
    arrVendedor,
    arrMar : TConsultasArray;

    strProfis,
    strParceiro,
    strCliente,
    strRede,
    strEmpresa,
    strVendedor,
    strMar : String;

  public
    { Public declarations }
    intOpCalc : Integer;
        
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelBrindesProfissionais: TfrmRelBrindesProfissionais;

implementation

uses untFuncoesFactory, untIFuncoes, untConstantes, Data.DB, untClassPanelCx;

{$R *.dfm}

function TfrmRelBrindesProfissionais.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  {*********************}
  {* VALIDA DATAS      *}
  {******************LU*}
  If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
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

  {*****************************************}
  {* VALIDA O CÓDIGO DA ATIVIDADE          *}
  {**************************************MV*}
  Else If (Sender = edtCodVendedor) Then
  Begin

  End

  {**************************************}
  {* VALIDA TIPO DO RELATORIO           *}
  {***********************************AF*}
  Else If (Sender = edtTipRel) Then
  Begin

    If Pos(edtTipRel.Text,'A_S_') <= 0 Then
    Begin
      fMensagem('','O campo tipo do relatorio deve ser A ou S!', ['&OK']);
      Result := False;
    End;

  End

  Else If (Sender = edtCodEmpresa) Then
  Begin

    If (Not fEmptyStr(edtCodEmpresa.Text)) and (edtCodEmpresa.Text <> '000') Then
    Begin
      If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtTipBri) Then
  Begin
    If (Pos(edtTipBri.Text, 'G_C_R_M_T_') <= 0) Then
    Begin
      fMensagem('','O Tipo de Brinde deve ser G, C, R , M ou T!', ['&Ok']);
      Result := False;
    end;
  End

  Else If (Sender = edtCreDeb) Then
  Begin
    If fEmptyStr(edtCreDeb.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Filtro "Crédito/Débito" deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If Pos(edtCreDeb.Text, 'C_D_T_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo "Crédito/Débito" deve ser (C)redito, (D)ébito ou (T)odos!', ['&O k']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelBrindesProfissionais.edtCodClienteKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelBrindesProfissionais.edtCodClienteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCliente,edtDesCliente,arrCliente,nil,fRetNomCliente,'do cliente');

  If Not fEmptyStr(edtCodCliente.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
    pSetFocus(edtCodEmpresa);
  End Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;
end;

procedure TfrmRelBrindesProfissionais.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelBrindesProfissionais.edtCodMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMarca,edtDesMarca,arrMar,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmRelBrindesProfissionais.edtCodMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtCodMarca, edtDesMarca, Nil, Key, arrMar, False) Then
  Begin
    If fValidaCampos(edtCodMarca, True) Then
       SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelBrindesProfissionais.edtCodEmpresaExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, Nil,fRetNomeEmpresaSelec,'da empresa');
end;

procedure TfrmRelBrindesProfissionais.edtCodProfissionalKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE DIVERSOS *}
  {**************************DP*}
  If fPesqDiversos(Self, edtCodProfissional, edtNomProfissional, Nil, Key, arrProfis, False) Then
  Begin
    If fValidaCampos(edtCodProfissional, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelBrindesProfissionais.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
end;

procedure TfrmRelBrindesProfissionais.edtCodRedeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRede, edtDesRede, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelBrindesProfissionais.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelBrindesProfissionais.btnImprimirClick(Sender: TObject);
Const
  INT_QTDSER = 30;
Var
  strSQL,
  strSQLSer,
  strSQLTmp: String;
  qryRelat : TUniQuery;
  qckRelatorio: TfrxReport;

  function fGetObjRel(strNomeObjeto: String): TfrxComponent;
  begin
    Result := qckRelatorio.FindObject(strNomeObjeto) As TfrxComponent;
  end;

  function fGetSQLCampoServico(strCampo: String): String;
    Var
      intSer: Integer;
  begin
    Result := '';
    Result := Result + '  CASE ';

    For intSer := 1 To INT_QTDSER Do
      Result := Result + '    WHEN IDESER = "'  + fStrZero(intToStr(intSer), 2) + '" ' +
                         '    THEN GER_' + strCampo + fStrZero(intToStr(intSer), 2);

    Result := Result + '  END ';
  end;

  function fGetTmpServicosID: String;
    Var
      intSer: Integer;
  begin
    Result := '';
    Result := Result + ' ( ';

    For intSer := 1 To INT_QTDSER Do
    Begin
      Result := Result + ' SELECT '  + intToStr(intSer) + ' AS IDESER ';

      If intSer < INT_QTDSER Then
        Result := Result + ' UNION ';
    End;

    Result := Result + ' ) ';
  end;

begin
  inherited;

  qryRelat := fCriaQuery;

  If blnImprime Then
  Begin
    pnlInfo.Caption := 'Gerando Relatório...';
    pnlInfo.Repaint;
    Application.ProcessMessages;

    Try
      {*******************************}
      {* MONTA O SELECT DOS PRODUTOS *}
      {****************************JC*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  IF(DET_CODDIV IS NULL,"00000000",     DET_CODDIV) AS DET_CODDIV, ';
      strSQL := strSQL + '  IF(DET_CODDIV IS NULL,"NÃO INFORMADO",DIV_NOMDIV) AS DIV_NOMDIV, ';
      strSQL := strSQL + '  IF(PAR_CODPAR IS NULL,"00000",        PAR_CODPAR) AS PAR_CODPAR, ';
      strSQL := strSQL + '  IF(PAR_NOMPAR IS NULL,"NÃO INFORMADO",PAR_NOMPAR) AS PAR_NOMPAR, ';
      strSQL := strSQL + '  DET_DTAENT, ';
      strSQL := strSQL + '  DET_NUMDOC, ';
      strSQL := strSQL + '  DET_ESPDOC, ';
      strSQL := strSQL + '  DET_CODEMP, ';
      strSQL := strSQL + '  DET_CODCLI, ';
      strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI',' IF(IFNULL(MOVGER.GER_NOMCON, "") = "", " ", MOVGER.GER_NOMCON) ', ' CLI_NOMCLI ') + ' AS CLI_NOMCLI, ';
      strSQL := strSQL + '  DET_CODITE, ';
      strSQL := strSQL + '  DET_DESCRI, ';
      strSQL := strSQL + '  DET_REFERE, ';
      strSQL := strSQL + '  UNI_SIGUNI, ';
      strSQL := strSQL + '  DET_QTDITE, ';
      strSQL := strSQL + '  DET_CLAFIS, ';
      strSQL := strSQL + '  DET_NUM_PD, ';
      strSQL := strSQL + '  DET_ESP_PD, ';
      strSQL := strSQL + '  DET_EMP_PD, ';


      If rdgOpcao.ItemIndex = 0 Then
      Begin
        strSQL := strSQL + '  DET_TOTITE AS DET_TOTDET, ';
        strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, DET_TOTITE, 0) AS DET_TOTCRE, ';
        strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, 0, DET_TOTITE) AS DET_TOTDEB ';
      End
      Else
      Begin
        strSQL := strSQL + '  DET_TOTCUS AS DET_TOTDET, ';
        strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, DET_TOTCUS, 0) AS DET_TOTCRE, ';
        strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, 0, DET_TOTCUS) AS DET_TOTDEB ';
      End;

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  MOVDET ';
      strSQL := strSQL + '    INNER JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';
      strSQL := strSQL + '    LEFT JOIN BRIDET ON BRI_SEQDET = MOVDET.AUTOINCREM ';
      strSQL := strSQL + '    LEFT JOIN CADPAR ON BRI_CODPAR = PAR_CODPAR ';
      strSQL := strSQL + '    LEFT JOIN CADDIV ON DIV_CODDIV = DET_CODDIV ';
      strSQL := strSQL + '    LEFT JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD ';
      strSQL := strSQL + '    LEFT JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
      strSQL := strSQL + '    LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
      strSQL := strSQL + '    LEFT JOIN CADITE ON ITE_CODITE = MOVDET.DET_CODITE ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') OR ((DET_ESPDOC = "NF" OR DET_ESPDOC = "EL") AND RIGHT(DET_CLAFIS,3)="910") ) AND ';
      strSQL := strSQL + '  DET_CODITE <> "' + fCfgSis('ITESER') + '" AND ';
      strSQL := strSQL + '  DET_CODITE <> "' + fCfgSis('SERTER') + '" AND ';
      strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

      strSQL := strSQL + fStrLocate(edtCodPar,arrParceiro,'PAR_CODPAR','CODPAR');
      strSQL := strSQL + fStrLocate(edtCodProfissional,arrProfis,'DET_CODDIV','CODDIV');
      strSQL := strSQL + fStrLocate(edtCodVendedor,arrVendedor,'DET_CODVEN','CODVEN');
      strSQL := strSQL + fStrLocate(edtCodCliente,arrCliente,'DET_CODCLI','CODCLI');
      strSQL := strSQL + fStrLocate(edtCodRede,arrRede,'CLI_CODRED','CODRED');
      strSQL := strSQL + fStrLocate(edtCodMarca,arrMar,'ITE_CODMAR','CODMAR');

      {**********************************************}
      {* EMPRESA DE FATURAMENTO / EMRPESA DE ORIGEM *}
      {*******************************************DP*}
      Case rdgEmpresa.ItemIndex Of
        0: strSQL := strSQL + fStrLocateEmpresa(edtCodEmpresa, arrEmpresa, 'DET_CODEMP', 'CODEMP');
        1: strSQL := strSQL + fStrLocateEmpresa(edtCodEmpresa, arrEmpresa, 'MOVTRI.DET_EMPORI', 'CODEMP');
      End;

      If edtCreDeb.Text = 'C' Then
        strSQL := strSQL + '  AND LEFT(DET_CLAFIS, 1) < 5 '
      Else If edtCreDeb.Text = 'D' Then
        strSQL := strSQL + '  AND LEFT(DET_CLAFIS, 1) >= 5 ';

      Case rdgAssoci.ItemIndex Of
           1: strSQL := strSQL + ' AND DET_CODDIV IS NOT NULL ';
           2: strSQL := strSQL + ' AND DET_CODDIV IS NULL ';
      End;

      If edtTipBri.Text <> 'T' Then
        strSQL := strSQL + '  AND BRI_TIPBRI = "' + edtTipBri.Text + '" ';

      {*******************************}
      {* MONTA O SELECT DOS SERVICOS *}
      {****************************JC*}
      strSQLSer := '';
      strSQLSer := strSQLSer + 'SELECT ';
      strSQLSer := strSQLSer + '  IF(DET_CODDIV IS NULL,"00000000",     DET_CODDIV) AS DET_CODDIV, ';
      strSQLSer := strSQLSer + '  IF(DET_CODDIV IS NULL,"NÃO INFORMADO",DIV_NOMDIV) AS DIV_NOMDIV, ';
      strSQLSer := strSQLSer + '  IF(PAR_CODPAR IS NULL,"00000",        PAR_CODPAR) AS PAR_CODPAR, ';
      strSQLSer := strSQLSer + '  IF(PAR_NOMPAR IS NULL,"NÃO INFORMADO",PAR_NOMPAR) AS PAR_NOMPAR, ';
      strSQLSer := strSQLSer + '  DET_DTAENT, ';
      strSQLSer := strSQLSer + '  DET_NUMDOC, ';
      strSQLSer := strSQLSer + '  DET_ESPDOC, ';
      strSQLSer := strSQLSer + '  DET_CODEMP, ';
      strSQLSer := strSQLSer + '  DET_CODCLI, ';
      strSQLSer := strSQLSer + fSQLIFClienteConsumidor('CLI_NOMCLI',' IF(IFNULL(MOVGER.GER_NOMCON, "") = "", " ", MOVGER.GER_NOMCON) ', ' CLI_NOMCLI ') + ' AS CLI_NOMCLI, ';
      strSQLSer := strSQLSer + fGetSQLCampoServico('CODS') + ' AS DET_CODITE, ';
      strSQLSer := strSQLSer + fGetSQLCampoServico('DESS') + ' AS DET_DESCRI, ';
      strSQLSer := strSQLSer + '  " " AS DET_REFERE,  ';
      strSQLSer := strSQLSer + '  " " AS UNI_SIGUNI, ';
      strSQLSer := strSQLSer + fGetSQLCampoServico('QTDS') + ' AS DET_QTDITE, ';
      strSQLSer := strSQLSer + '  DET_CLAFIS, ';
      strSQLSer := strSQLSer + '  DET_NUM_PD, ';
      strSQLSer := strSQLSer + '  DET_ESP_PD, ';
      strSQLSer := strSQLSer + '  DET_EMP_PD, ';

      If rdgOpcao.ItemIndex = 0 Then
      Begin
        strSQLSer := strSQLSer + fGetSQLCampoServico('VALS') + ' AS DET_TOTDET, ';
        strSQLSer := strSQLSer + '  IF(LEFT(DET_CLAFIS, 1) < 5, ' + fGetSQLCampoServico('VALS') + ', 0) AS DET_TOTCRE, ';
        strSQLSer := strSQLSer + '  IF(LEFT(DET_CLAFIS, 1) < 5, 0, ' + fGetSQLCampoServico('VALS') + ') AS DET_TOTDEB  ';
      End
      Else
      Begin
        strSQLSer := strSQLSer + '  (' + fGetSQLCampoServico('CUSS') + ' * ' + fGetSQLCampoServico('QTDS') + ') AS DET_TOTDET, ';
        strSQLSer := strSQLSer + '  IF(LEFT(DET_CLAFIS, 1) < 5,    (' + fGetSQLCampoServico('CUSS') + ' * ' + fGetSQLCampoServico('QTDS') + '), 0) AS DET_TOTCRE, ';
        strSQLSer := strSQLSer + '  IF(LEFT(DET_CLAFIS, 1) < 5, 0, (' + fGetSQLCampoServico('CUSS') + ' * ' + fGetSQLCampoServico('QTDS') + ')   ) AS DET_TOTDEB  ';
      End;

      strSQLSer := strSQLSer + 'FROM ';
      strSQLSer := strSQLSer + '  MOVDET ';
      strSQLSer := strSQLSer + '  INNER JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';
      strSQLSer := strSQLSer + '  INNER JOIN SERMOV ON MOVGER.AUTOINCREM = SERMOV.GER_SEQGER ';
      strSQLSer := strSQLSer + '  LEFT  JOIN ' + fGetTmpServicosID + ' T ON TRUE ';
      strSQLSer := strSQLSer + '  LEFT JOIN CADSER ON SER_CODSER = ' + fGetSQLCampoServico('CODS');
      strSQLSer := strSQLSer + '  LEFT JOIN CADPAR ON PAR_CODPAR = ' + fGetSQLCampoServico('PARS');
      strSQLSer := strSQLSer + '  LEFT JOIN CADDIV ON DIV_CODDIV = DET_CODDIV ';
      strSQLSer := strSQLSer + '  LEFT JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
      strSQLSer := strSQLSer + '  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
      strSQLSer := strSQLSer + '  LEFT JOIN CADITE ON ITE_CODITE = MOVDET.DET_CODITE ';
      strSQLSer := strSQLSer + 'WHERE ';
      strSQLSer := strSQLSer + '  ((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') OR ((DET_ESPDOC = "NF" OR DET_ESPDOC = "EL") AND RIGHT(DET_CLAFIS,3)="910") ) AND ';
      strSQLSer := strSQLSer + '  DET_CODITE IN ("' + fCfgSis('ITESER') + '", "' + fCfgSis('SERTER') + '") AND ';
      strSQLSer := strSQLSer + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

      strSQLSer := strSQLSer + fStrLocate(edtCodPar,arrParceiro,'PAR_CODPAR','CODPAR');
      strSQLSer := strSQLSer + fStrLocate(edtCodProfissional,arrProfis,'DET_CODDIV','CODDIV');
      strSQLSer := strSQLSer + fStrLocate(edtCodVendedor,arrVendedor,fGetSQLCampoServico('VENS'),'CODVEN');
      strSQLSer := strSQLSer + fStrLocate(edtCodCliente,arrCliente,'DET_CODCLI','CODCLI');
      strSQLSer := strSQLSer + fStrLocate(edtCodMarca,arrMar,'ITE_CODMAR','CODMAR');
      strSQLSer := strSQLSer + fStrLocate(edtCodRede,arrRede,'CLI_CODRED','CODRED');

      {**********************************************}
      {* EMPRESA DE FATURAMENTO / EMRPESA DE ORIGEM *}
      {*******************************************DP*}
      Case rdgEmpresa.ItemIndex Of
        0: strSQLSer := strSQLSer + fStrLocateEmpresa(edtCodEmpresa, arrEmpresa, 'DET_CODEMP', 'CODEMP');
        1: strSQLSer := strSQLSer + fStrLocateEmpresa(edtCodEmpresa, arrEmpresa, 'MOVTRI.DET_EMPORI', 'CODEMP');
      End;

      If edtCreDeb.Text = 'C' Then
        strSQLSer := strSQLSer + '  AND LEFT(DET_CLAFIS, 1) < 5 '
      Else If edtCreDeb.Text = 'D' Then
        strSQLSer := strSQLSer + '  AND LEFT(DET_CLAFIS, 1) >= 5 ';

      Case rdgAssoci.ItemIndex Of
           1: strSQLSer := strSQLSer + ' AND DET_CODDIV IS NOT NULL ';
           2: strSQLSer := strSQLSer + ' AND DET_CODDIV IS NULL ';
      End;

      If edtTipBri.Text <> 'T' Then
        strSQLSer := strSQLSer + ' AND ' + fGetSQLCampoServico('TBRS') + ' = "' + edtTipBri.Text + '" ';

      strSQLSer := strSQLSer + ' GROUP BY DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI, IDESER '; //Remover duplicidade quando documento possuir mais de um item de servico (CFG_ITESER E CFG_SERTER)

      strSQLSer := strSQLSer + ' HAVING IFNULL(DET_CODITE,"") <> "" '; //Código do servico nao vazio

      {***************************************}
      {* MONTA O SELECT FINAL DO RELATORIO   *}
      {************************************JC*}
      strSQLTmp := '';
      strSQLTmp := strSQLTmp + 'SELECT SQL_NO_CACHE ';
      strSQLTmp := strSQLTmp + '  IF(DET_CODDIV IS NULL,"00000000",     DET_CODDIV) AS DET_CODDIV, ';
      strSQLTmp := strSQLTmp + '  IF(DET_CODDIV IS NULL,"NÃO INFORMADO",DIV_NOMDIV) AS DIV_NOMDIV, ';
      strSQLTmp := strSQLTmp + '  IF(PAR_CODPAR IS NULL,"00000",        PAR_CODPAR) AS PAR_CODPAR, ';
      strSQLTmp := strSQLTmp + '  IF(PAR_NOMPAR IS NULL,"NÃO INFORMADO",PAR_NOMPAR) AS PAR_NOMPAR, ';
      strSQLTmp := strSQLTmp + '  DET_DTAENT, ';
      strSQLTmp := strSQLTmp + '  DET_NUMDOC, ';
      strSQLTmp := strSQLTmp + '  DET_ESPDOC, ';
      strSQLTmp := strSQLTmp + '  DET_CODEMP, ';
      strSQLTmp := strSQLTmp + '  DET_CODCLI, ';
      strSQLTmp := strSQLTmp + '  CLI_NOMCLI, ';
      strSQLTmp := strSQLTmp + '  DET_CODITE, ';
      strSQLTmp := strSQLTmp + '  DET_DESCRI, ';
      strSQLTmp := strSQLTmp + '  DET_REFERE, ';
      strSQLTmp := strSQLTmp + '  UNI_SIGUNI, ';
      strSQLTmp := strSQLTmp + '  DET_QTDITE, ';
      strSQLTmp := strSQLTmp + '  DET_CLAFIS, ';
      strSQLTmp := strSQLTmp + '  DET_NUM_PD, ';
      strSQLTmp := strSQLTmp + '  DET_ESP_PD, ';
      strSQLTmp := strSQLTmp + '  DET_EMP_PD, ';

      If edtTipRel.Text = 'A' Then
      Begin
        strSQLTmp := strSQLTmp + '  DET_TOTDET, ';
        strSQLTmp := strSQLTmp + '  DET_TOTDEB, ';
        strSQLTmp := strSQLTmp + '  DET_TOTCRE ';
      End
      Else
      Begin
        strSQLTmp := strSQLTmp + '  SUM(DET_TOTDET) AS DET_TOTDET, ';
        strSQLTmp := strSQLTmp + '  SUM(DET_TOTDEB) AS DET_TOTDEB, ';
        strSQLTmp := strSQLTmp + '  SUM(DET_TOTCRE) AS DET_TOTCRE ';
      End;

      strSQLTmp := strSQLTmp + 'FROM (' + strSQL + ' UNION ALL ' + strSQLSer + ') AS TBL ';

      strSQL := strSQLTmp;

      If edtTipRel.Text = 'S' Then
      Begin
        strSQL := strSQL + ' GROUP BY ';

        Case rdgAgrPor.ItemIndex Of
          0: strSQL := strSQL + ' DET_CODDIV ';
          1: strSQL := strSQL + ' PAR_CODPAR ';
        End;
      End;

      strSQL := strSQL + ' ORDER BY ';

      Case rdgAgrPor.ItemIndex Of
        0: strSQL := strSQL + '   DET_CODDIV, DET_DTAENT, DET_CODCLI, DET_CODITE ';
        1: strSQL := strSQL + '   PAR_CODPAR, DET_DTAENT, DET_CODCLI, DET_CODITE ';
      End;

      With qryRelat Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

        pSetaParam(edtCodPar.Text, arrParceiro, strParceiro, 'CODPAR', qryRelat);
        pSetaParam(edtCodProfissional.Text, arrProfis, strProfis, 'CODDIV', qryRelat);
        pSetaParam(edtCodVendedor.Text, arrVendedor, strVendedor, 'CODVEN', qryRelat);
        pSetaParam(edtCodCliente.Text, arrCliente, strCliente, 'CODCLI', qryRelat);
        pSetaParam(edtCodMarca.Text, arrMar, strMar, 'CODMAR', qryRelat);
        pSetaParam(edtCodRede.Text, arrRede, strRede, 'CODRED', qryRelat);
        pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryRelat);

        Open;
      End;

      If Not qryRelat.IsEmpty Then
      Begin

        frxRelatorio.DataSet := qryRelat;

        {******************************************************}
        {* DEFINE SE O RELATORIO É MATRICIAL OU JATO DE TINTA *}
        {***************************************************LU*}
        If strTipImp = 'M' Then Begin
          qckRelatorio := frxPaginaM;
        End Else Begin
          qckRelatorio := frxPaginaJ;
          TfrxMemoView(qckRelatorio.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
        End;

        qckRelatorio.Script.Variables['CODPAR'] := fStrTitulo(edtCodPar.Text, edtNomPar, arrParceiro, strParceiro, 'PARCEIRO');
        qckRelatorio.Script.Variables['CODPRO'] := fStrTitulo(edtCodProfissional.Text, edtNomProfissional, arrProfis, strProfis, 'PROFISSIONAL');
        qckRelatorio.Script.Variables['CODVEN'] := fStrTitulo(edtCodVendedor.Text, edtNomVendedor, arrVendedor, strVendedor, 'VENDEDOR');
        qckRelatorio.Script.Variables['CODCLI'] := fStrTitulo(edtCodCliente.Text, edtDesCliente, arrCliente, strCliente, 'CLIENTE');
        qckRelatorio.Script.Variables['CODMAR'] := fStrTitulo(edtCodMarca.Text, edtDesMarca, arrMar, strMar, 'MARCA');

        {*****************}
        {* REDE DE LOJAS *}
        {**************DP*}
        qckRelatorio.Script.Variables['REDLOJ'] := fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strRede, 'REDE DE LOJAS', True);
        qckRelatorio.Script.Variables['CODEMP'] := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA '+IfThen(rdgEmpresa.ItemIndex = 0,'(FATURAMENTO)','(ORIGEM)'), True);

        Case edtTipBri.Text[1] Of
          'G': qckRelatorio.Script.Variables['TIPBRI'] := 'TIPO DE BRINDE: GARANTIA';
          'C': qckRelatorio.Script.Variables['TIPBRI'] := 'TIPO DE BRINDE: CORTESIA';
          'R': qckRelatorio.Script.Variables['TIPBRI'] := 'TIPO DE BRINDE: REVISAO';
          'M': qckRelatorio.Script.Variables['TIPBRI'] := 'TIPO DE BRINDE: MONTAGEM';
          'T': qckRelatorio.Script.Variables['TIPBRI'] := 'TIPO DE BRINDE: TODOS';
        End;

        qckRelatorio.Script.Variables['PERIOD'] := 'PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

        Case rdgOpcao.ItemIndex Of
             0: qckRelatorio.Script.Variables['VTOTAL'] := 'TOTAL: VALOR DE VENDA';
             1: qckRelatorio.Script.Variables['VTOTAL'] := 'TOTAL: VALOR DE CUSTO';
        End;

        TfrxMemoView(qckRelatorio.FindObject('rllFiltros')).Lines.Clear;
        TfrxMemoView(qckRelatorio.FindObject('rllFiltros')).Lines.Add('[CODPRO]');
        TfrxMemoView(qckRelatorio.FindObject('rllFiltros')).Lines.Add('[CODVEN]');
        TfrxMemoView(qckRelatorio.FindObject('rllFiltros')).Lines.Add('[CODCLI]');
        TfrxMemoView(qckRelatorio.FindObject('rllFiltros')).Lines.Add('[CODEMP]');
        TfrxMemoView(qckRelatorio.FindObject('rllFiltros')).Lines.Add('[VTOTAL]');
        TfrxMemoView(qckRelatorio.FindObject('rllFiltros')).Lines.Add('[REDLOJ]');

        If pnlCodPar.Visible Then
          TfrxMemoView(qckRelatorio.FindObject('rllFiltros')).Lines.Add('[CODPAR]');

        If pnlTipBri.Visible Then
          TfrxMemoView(qckRelatorio.FindObject('rllFiltros')).Lines.Add('[TIPBRI]');

        TfrxMemoView(qckRelatorio.FindObject('rllFiltros')).Lines.Add('[PERIOD]');

        fGetObjRel('rllTitValDeb').Visible    := edtCreDeb.Text <> 'C';
        fGetObjRel('rllTitValDeb').Visible    := edtCreDeb.Text <> 'C';
        fGetObjRel('rllValDeb').Visible       := edtCreDeb.Text <> 'C';
        fGetObjRel('rllTotDeb').Visible       := edtCreDeb.Text <> 'C';
        fGetObjRel('rllTitValDebSin').Visible := edtCreDeb.Text <> 'C';
        fGetObjRel('rllValDebSin').Visible    := edtCreDeb.Text <> 'C';

        fGetObjRel('rllTitTotalSin').Visible  := edtCreDeb.Text = 'T';
        fGetObjRel('rllTotalSin').Visible     := edtCreDeb.Text = 'T';
        fGetObjRel('rllTotal').Visible        := edtCreDeb.Text = 'T';

        If edtCreDeb.Text = 'T' Then
          fGetObjRel('rlbSumarioGrupo').Height := fGetObjRel('rllTotal').Top + fGetObjRel('rllTotal').Height
        Else
          fGetObjRel('rlbSumarioGrupo').Height := fGetObjRel('rllTotal').Top;

        fGetObjRel('LineSumGru').Top := fGetObjRel('rlbSumarioGrupo').Height;

        fGetObjRel('rllTitValCre').Visible    := edtCreDeb.Text <> 'D';
        fGetObjRel('rllValCre').Visible       := edtCreDeb.Text <> 'D';
        fGetObjRel('rllTotCre').Visible       := edtCreDeb.Text <> 'D';
        fGetObjRel('rllTitValCreSin').Visible := edtCreDeb.Text <> 'D';
        fGetObjRel('rllValCreSin').Visible    := edtCreDeb.Text <> 'D';

        If edtCreDeb.Text = 'T' Then
        Begin
          fGetObjRel('rllTitValCre').Left    := fGetObjRel('rllTitValDeb').Left    - fGetObjRel('rllTitValCre').Width;
          fGetObjRel('rllValCre').Left       := fGetObjRel('rllValDeb').Left       - fGetObjRel('rllValCre').Width;
          fGetObjRel('rllTotCre').Left       := fGetObjRel('rllTotDeb').Left       - fGetObjRel('rllTotCre').Width;
          fGetObjRel('rllTitValDebSin').Left := fGetObjRel('rllTitTotalSin').Left  - fGetObjRel('rllTitValDebSin').Width;
          fGetObjRel('rllValDebSin').Left    := fGetObjRel('rllTotalSin').Left     - fGetObjRel('rllValDebSin').Width;
          fGetObjRel('rllTitValCreSin').Left := fGetObjRel('rllTitValDebSin').Left - fGetObjRel('rllTitValCreSin').Width;
          fGetObjRel('rllValCreSin').Left    := fGetObjRel('rllValDebSin').Left    - fGetObjRel('rllValCreSin').Width;
        End
        Else If edtCreDeb.Text = 'C' Then
        Begin
          fGetObjRel('rllTitValCre').Left    := fGetObjRel('rllTitValDeb').Left;
          fGetObjRel('rllValCre').Left       := fGetObjRel('rllValDeb').Left;
          fGetObjRel('rllTotCre').Left       := fGetObjRel('rllTotDeb').Left;
          fGetObjRel('rllTitValCreSin').Left := fGetObjRel('rllTitTotalSin').Left;
          fGetObjRel('rllValCreSin').Left    := fGetObjRel('rllTotalSin').Left;
        End
        Else If edtCreDeb.Text = 'D' Then
        Begin
          fGetObjRel('rllTitValDebSin').Left := fGetObjRel('rllTitTotalSin').Left;
          fGetObjRel('rllValDebSin').Left    := fGetObjRel('rllTotalSin').Left;
        End;

        If edtTipRel.Text = 'A' Then
        Begin
          qckRelatorio.Script.Variables['NOMREL'] := 'RELATORIO DE BRINDES POR ' + IfThen(rdgAgrPor.ItemIndex = 0, 'PROFISSIONAL', 'PARCEIRO') + ' - ANALITICO';

          fGetObjRel('rlbTituloSint').Visible   := False;
          fGetObjRel('rlbDetalheSint').Visible  := False;
          fGetObjRel('rlbSumarioSint').Visible  := False;

          fGetObjRel('rlbTitulo').Visible       := True;
          fGetObjRel('rlbTituloGrupo').Visible  := True;
          fGetObjRel('rlbDetalhes').Visible     := True;
          fGetObjRel('rlbSumarioGrupo').Visible := True;
          fGetObjRel('rlbSumario').Visible      := True;

          Case rdgAgrPor.ItemIndex Of
            0: Begin
                TfrxGroupHeader(qckRelatorio.FindObject('rlbTituloGrupo')).Condition := 'frxRelatorio."DET_CODDIV"';
                TfrxMemoView(qckRelatorio.FindObject('rllTituloGrupo')).Text         := 'PROFISSIONAL: [frxRelatorio."DET_CODDIV"] - [frxRelatorio."DIV_NOMDIV"]';
                TfrxMemoView(qckRelatorio.FindObject('rllTotalGrupo')).Text          := 'TOTAL DO PROFISSIONAL:';
               End;
            1: Begin
                TfrxGroupHeader(qckRelatorio.FindObject('rlbTituloGrupo')).Condition := 'frxRelatorio."PAR_CODPAR"';
                TfrxMemoView(qckRelatorio.FindObject('rllTituloGrupo')).Text         := 'PARCEIRO: [frxRelatorio."PAR_CODPAR"] - [frxRelatorio."PAR_NOMPAR"]';
                TfrxMemoView(qckRelatorio.FindObject('rllTotalGrupo')).Text          := 'TOTAL DO PARCEIRO:';
               End;
          end;

        End
        Else
        Begin
          qckRelatorio.Script.Variables['NOMREL'] := 'RELATORIO DE BRINDES POR ' + IfThen(rdgAgrPor.ItemIndex = 0, 'PROFISSIONAL', 'PARCEIRO') + ' - SINTETICO';
          fGetObjRel('rlbTituloSint').Visible   := True;
          fGetObjRel('rlbDetalheSint').Visible  := True;
          fGetObjRel('rlbSumarioSint').Visible  := True;

          fGetObjRel('rlbTitulo').Visible       := False;
          fGetObjRel('rlbTituloGrupo').Visible  := False;
          fGetObjRel('rlbDetalhes').Visible     := False;
          fGetObjRel('rlbSumarioGrupo').Visible := False;
          fGetObjRel('rlbSumario').Visible      := False;

          Case rdgAgrPor.ItemIndex Of
            0: Begin
                TfrxMemoView(qckRelatorio.FindObject('rllTitDetSintetico')).Text := 'CODIGO / NOME DO PROFISSIONAL';
                TfrxMemoView(qckRelatorio.FindObject('rllDetSintetico')).Text := '[frxRelatorio."DET_CODDIV"] - [frxRelatorio."DIV_NOMDIV"]';
               End;
            1: Begin
                TfrxMemoView(qckRelatorio.FindObject('rllTitDetSintetico')).Text := 'CODIGO / NOME DO PARCEIRO';
                TfrxMemoView(qckRelatorio.FindObject('rllDetSintetico')).Text := '[frxRelatorio."PAR_CODPAR"] - [frxRelatorio."PAR_NOMPAR"]';
               End;
          end;
        End;

        If (Not fEmptyStr(strNomImp)) Then Begin
          qckRelatorio.PrintOptions.Printer    := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
          qckRelatorio.PrintOptions.ShowDialog := False;
        End;

        If qckRelatorio.PrepareReport Then Begin
          If edtDestino.Text = 'V' Then
            qckRelatorio.ShowReport
          Else
            qckRelatorio.Print;
        End;
      End
      Else
        pTabelaVazia;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmRelBrindesProfissionais.btnImprimirClick]');
      End;
    End;

    pSetFocus(mskDtaIni);

    FreeAndNil(qryRelat);    
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';

end;

procedure TfrmRelBrindesProfissionais.edtCodParExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPar, edtNomPar, arrParceiro, nil, fRetNomeParceiro, 'do parceiro');
end;

procedure TfrmRelBrindesProfissionais.edtCodParKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqParceiro(Self, edtCodPar, edtNomPar, Nil, Key, arrParceiro, False) Then
  Begin
    If fValidaCampos(edtCodPar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelBrindesProfissionais.edtCodProfissionalExit(
  Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodProfissional, edtNomProfissional, arrProfis, nil, fRetNomeProfissional, 'do profissional');
end;

procedure TfrmRelBrindesProfissionais.FormShow(Sender: TObject);
begin
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

  shpMultSel.Visible:=True;

  pnlCodPar.Visible := fCfgSis('USAPAR', VarBoolean);
  pnlTipBri.Visible := fCfgSis('USAPAR', VarBoolean);

  If Not pnlCodPar.Visible Then
    Self.ClientHeight := Self.ClientHeight - pnlCodPar.Height;

  If Not pnlTipBri.Visible Then
    Self.ClientHeight := Self.ClientHeight - pnlTipBri.Height;

  inherited;
end;

procedure TfrmRelBrindesProfissionais.edtCodVendedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVendedor, edtNomVendedor, arrVendedor, fRetNomVendRep, nil, 'do vendedor');
end;

procedure TfrmRelBrindesProfissionais.edtCodVendedorKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodVendedor, edtNomVendedor, nil, Key, arrVendedor, False) Then
  Begin
    If fValidaCampos(edtCodVendedor,False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

End.
