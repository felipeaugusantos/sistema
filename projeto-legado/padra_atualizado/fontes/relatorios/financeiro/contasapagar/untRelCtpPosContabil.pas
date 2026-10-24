unit untRelCtpPosContabil;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils, Uni,
  QColorLabel, Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  AppEvnts, RLXLSFilter, ComObj, untFuncoesFactory, DB, BitBtnLockedIncrem,
  frxExportCSVTestabilidade, untTypesSistema, untIFuncoes, Vcl.ComCtrls;

type
  TfrmRelCtpPosContabil = class(TfrmPaiRelatorio)
    Label10: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label12: TLabel;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    gpbBoleto: TGroupBox;
    edtBoleto: TEditFocus;
    ColorLabel2: TColorLabel;
    edtDesEmpresa: TEditFocus;
    GroupBox1: TGroupBox;
    ColorLabel3: TColorLabel;
    edtTipo: TEditFocus;
    Label1: TLabel;
    edtCodAtividade: TEditFocus;
    edtDesAtividade: TEditFocus;
    gpbPrevis: TGroupBox;
    ColorLabel4: TColorLabel;
    edtPrevis: TEditFocus;
    svdExcel: TSaveDialog;
    gpbOrdem: TGroupBox;
    lbl1: TColorLabel;
    lbl2: TColorLabel;
    edtOrdem: TEditFocus;
    gpbOpSint: TGroupBox;
    edtOpcao: TEditFocus;
    lblOpc1: TColorLabel;
    lblOpc2: TColorLabel;
    edtCodFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    Label2: TLabel;
    edtDesPortador: TEditFocus;
    Label3: TLabel;
    edtCodPortador: TEditFocus;
    mskVenIni: TMaskEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    mskVenFin: TMaskEditFocus;
    Label6: TLabel;
    Label7: TLabel;
    ColorLabel5: TColorLabel;
    mskCompet: TMaskEditFocus;
    Label8: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodAtividadeKeyPress(Sender: TObject; var Key: Char);
    procedure pGeraExcel;
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPortadorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure edtCodAtividadeExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtTipoChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    strTipoRel   : String;
    strAtividade : String;
    strPortador  : String;
    strFornecedor: String;
    qryResumo: TUniQuery;

    qryRelatorio: TUniQuery;

    function fGetSqlAnalit: String;

    procedure pGeraResumo(strSelect: String);

    procedure pCriaQryRelatorio;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    arrAtividade,
    arrEmp,
    arrFor,
    arrPor  : TConsultasArray;

    strEmp : String;
  end;

var
  frmRelCtpPosContabil: TfrmRelCtpPosContabil;

implementation

uses untQckCtpPosContabil, untExcel;

{$R *.dfm}

procedure TfrmRelCtpPosContabil.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  inherited;
end;

procedure TfrmRelCtpPosContabil.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelCtpPosContabil.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpPosContabil.edtCodFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFornecedor, edtDesFornecedor, arrFor, fRetNomFornecedor, Nil, 'do fornecedor');

end;

procedure TfrmRelCtpPosContabil.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrFor, False) Then
  Begin
    If fValidaCampos(edtCodFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpPosContabil.edtCodPortadorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPortador, edtDesPortador, Nil, Key, arrPor, False) Then
  Begin
    If fValidaCampos(edtCodPortador, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelCtpPosContabil.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
  Var
    intCorre : Integer;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {**************************}
    {* VALIDA DATA VENCIMENTO *}
    {***********************MO*}
    If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data de cadastro deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text, 0) <= 0) Then
        Begin
         fMensagem('', 'A data de cadastro informada é inválida! Necessário correção.', ['&O k']);
         Result := False;
        End;
       End;
    End
    else

    {**************************}
    {* VALIDA DATA VENCIMENTO *}
    {***********************MO*}
    If (Sender = mskVenFin) Then
    Begin
      If mskVenFin.Enabled And
         fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text)) And
         (Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text))) Then
      Begin
        fMensagem('', 'O campo data final de vencimento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text))) And (StrToDateDef(mskVenFin.Text, 0) <= 0) Then
        Begin
          fMensagem('', 'A data final de vencimento informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End
        Else
        If (Not fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text))) Then
        Begin
          If StrToDate(mskVenIni.Text) > StrToDate(mskVenFin.Text) Then
          Begin
            fMensagem('','A data inicial de vencimento deve ser menor que a data final de vencimento!',['&O K']);
            Sender := mskVenIni;
            Result := False;
          End;
        End;
      End;
    End
    Else
    If (Sender = mskVenIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text))) and (StrToDateDef(mskVenIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A data inicial de vencimento informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskVenIni;
      End;
    End
    Else If (Sender = edtBoleto) Then
    Begin
      {****************************}
      {* VERIFICA CAMPO DO BOLETO *}
      {*************************AF*}
      If fEmptyStr(edtBoleto.Text) then
      Begin
        fMensagem('ATENÇÃO','O campo boleto deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If Pos(edtBoleto.Text, 'TNS') <= 0 Then
      Begin
        fMensagem('','O campo boleto deve conter somente T, S ou N!',['&O K']);
        Result := False;
      End;
    End
    Else If (Sender = edtTipo) Then
    Begin
     {*******************************************}
     {* VERIFICA TIPO RELATORIO - ANALITICO OU  *}
     {* SINTETICO                               *}
     {****************************************AC*}
      If fEmptyStr(edtTipo.Text) then
      Begin
        fMensagem('ATENÇÃO','O campo tipo deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If Pos(edtTipo.Text, 'AS') <= 0 Then
      Begin
        fMensagem('','O campo tipo deve conter somente A ou S!',['&O K']);
        Result := False;
      End;
    End
    Else
    if (Sender = mskCompet) then
    Begin

      if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
      begin

        If not fValidaDataStr('01/'+ mskCompet.Text) Then
        Begin
          pMensagemOk('Data informada na Competência não é válida!');
          Result := False;
        End;

      end;

    End
    Else
    If (Sender = edtOrdem) Then
    Begin
      If fEmptyStr(edtOrdem.Text) then
      Begin
        fMensagem('ATENÇÃO','O campo ordem analítico deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If Pos(edtOrdem.Text, 'CDN') <= 0 Then
      Begin
        fMensagem('', 'O campo ordem analítico deve ser C, D ou N!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtOpcao) Then
    Begin
      If fEmptyStr(edtOpcao.Text) then
      Begin
        fMensagem('ATENÇÃO','O campo ordem sintético deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If Pos(edtOpcao.Text, '1_2') <= 0 Then
      Begin
        fMensagem('', 'O campo Ordem Analítico deve ser 1 ou 2!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    If (Sender = edtDestino) Then
    Begin
      If fEmptyStr(edtDestino.Text) Then
      Begin
        fMensagem('','O campo ''Destino'' deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtDestino.Text, 'V_I_E') <= 0 Then
        Begin
          fMensagem('', 'O campo ''Destino'' deve ser V, I ou E!', ['&O k']);
          Result := False;
        End;
      End;
    End
    else
    If (Sender = edtPrevis) Then
    Begin
      If fEmptyStr(edtPrevis.Text) then
      Begin
        fMensagem('ATENÇÃO','O campo previsão deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If Pos(edtPrevis.Text, 'SNT') <= 0 Then
      Begin
        fMensagem('', 'O campo previsão deve ser S, N ou T!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodEmpresa) Then
    Begin

      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        pDesmarcaLista(edtCodEmpresa, arrEmp);
        If (Length(arrEmp) > 1) Then
        Begin
          For intCorre := 0 to Length(arrEmp)-1 Do
          Begin
            If Pos(arrEmp[intCorre].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
              Result := False;
            End;
          End;

        End
        Else
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If Sender = edtCodPortador Then
    Begin
      If Not fEmptyStr(edtCodPortador.Text) And (edtCodPortador.Text <> '00000') Then
      Begin

        edtDesPortador.Text := fRetNomPortador(edtCodPortador.Text);

        If fEmptyStr(edtDesPortador.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPortador.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;

      End
      Else
        edtDesPortador.Text := 'TODOS';
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmRelCtpPosContabil.fGetSqlAnalit: String;
  Var strSQL : String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  P.*, ';
  strSQL := strSQL + '  SUM(IF(CTP_DTAPAG IS NULL, (CTP_VALDUP - IFNULL(CTP_DESSUJ,0) + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_VENDOR,0)), (CTP_VALPAG - IFNULL(CTP_VALJUR,0) + IFNULL(CTP_VALDES,0) ))) AS VALGER, ';
  strSQL := strSQL + '  CONCAT(F.FOR_CODATI,"-",A.ATI_DESATI) AS FOR_ATIVID, ';
  strSQL := strSQL + '  CONCAT(CTP_CODCTA,"-",CTA_DESCTA) AS CENTRO_CUSTO, ';
  strSQL := strSQL + '  F.FOR_NOMFOR, ';
  strSQL := strSQL + '  F.FOR_C_G_C_ ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPAG P ';
  If fCfgSis('CTPOBP', varBoolean) Then
    strSQL := strSQL + '  JOIN CADPOR ON POR_CODPOR = CTP_CODPOR ';
  strSQL := strSQL + '  JOIN CADFOR F ON CTP_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '  LEFT JOIN CADATI A ON FOR_CODATI = ATI_CODATI ';
  strSQL := strSQL + '  LEFT JOIN CADCTA ON CTP_CODCTA = CTA_CODCTA ';
  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + fComplementoWhereSQLPosContabilPagar(edtCodEmpresa, arrEmp, (Not fEmptyStr(edtCodPortador.Text)), edtCodPortador, arrPor);

  {**************************}
  {* FILTRO POR COMPETÊNCIA *}
  {************************BB}
  if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
    strSQL := strSQL + '  AND P.CTP_COMPET = :COMPET ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
    strSQL := strSQL + ' AND CTP_DTAVEN BETWEEN :VENINI AND :VENFIN ';

  strSQL := strSQL + fStrLocate(edtCodAtividade,  arrAtividade,  'FOR_CODATI', 'CODATI');

  If (edtBoleto.Text = 'S') Then
    strSQL := strSQL + '  AND CTP_VEIOBO = ' + QuotedStr('S')
  Else If (edtBoleto.Text = 'N') Then
    strSQL := strSQL + '  AND CTP_VEIOBO = ' + QuotedStr('N');

  If (edtPrevis.Text = 'S') Then
    strSQL := strSQL + '  AND CTP_PREVIS = ' + QuotedStr('S')
  Else If (edtPrevis.Text = 'N') Then
    strSQL := strSQL + '  AND CTP_PREVIS = ' + QuotedStr('N');

  strSQL := strSQL + fStrLocate(edtCodFornecedor,  arrFor,  'CTP_CODFOR', 'CODFOR');

  If Not fEmptyStr(edtCodPortador.Text) Then
    strSQL := strSQL + fStrLocate(edtCodPortador  ,  arrPor,  'CTP_CODPOR', 'CODPOR')
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CTP_CODPOR, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  If fCfgSis('CTPOBP', varBoolean) Then
    strSQL := strSQL + '  AND POR_ENTPCO = "S" ';

  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + '   CTP_NUMDUP, CTP_PARCEL, CTP_CODFOR, CTP_CODEMP ';

  strSQL := 'SELECT SUM(T.VALGER) AS CTP_VALGER, T.* FROM (' + strSQL + ') AS T ';

  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + '   CTP_NUMDUP, CTP_PARCEL, CTP_CODFOR, CTP_CODEMP ';
  strSQL := strSQL + ' ORDER BY ';
  If (edtOrdem.Text = 'C') Then
    strSQL := strSQL + '   CTP_CODFOR, CTP_DTAVEN, CTP_NUMDUP, CTP_PARCEL, CTP_CODEMP '
  Else
  If (edtOrdem.Text = 'D') Then
    strSQL := strSQL + '   CTP_DTAVEN, CTP_CODFOR, CTP_NUMDUP, CTP_PARCEL, CTP_CODEMP '
  Else
    strSQL := strSQL + '   FOR_NOMFOR, CTP_DTAVEN, CTP_NUMDUP, CTP_PARCEL, CTP_CODEMP ';

  Result := strSQL;
end;

procedure TfrmRelCtpPosContabil.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    strRes: String;
begin
  if (edtDestino.Text <> 'E') then
    inherited;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  If (blnImprime) or (edtDestino.Text = 'E') Then
  Begin

    strTipoRel := edtTipo.Text;
    strRes     := fGetSqlAnalit;

    If (edtTipo.Text = 'A') Then //Analitico
    Begin
      strSQL := strRes;
    End
    Else
    Begin

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  P.CTP_CODFOR, ';
      strSQL := strSQL + '  P.CTP_CODCTA, ';
      strSQL := strSQL + '  F.FOR_NOMFOR, ';
      strSQL := strSQL + '  F.FOR_C_G_C_, ';
      strSQL := strSQL + '  CONCAT(F.FOR_CODATI,"-",A.ATI_DESATI) AS FOR_ATIVID, ';
      strSQL := strSQL + '  CTA_DESCTA, ';

      If edtOpcao.Text = '2' Then
        strSQL := strSQL + '  P.CTP_DTAVEN, ';

      strSQL := strSQL + '  P.CTP_CODEMP, ';
      strSQL := strSQL + '  SUM(IF(CTP_DTAPAG IS NULL, (CTP_VALDUP - IFNULL(CTP_DESSUJ,0) + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_VENDOR,0)), (CTP_VALPAG - IFNULL(CTP_VALJUR,0) + IFNULL(CTP_VALDES,0) ))) AS CTP_VALGER ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADPAG P ';
      If fCfgSis('CTPOBP', varBoolean) Then
        strSQL := strSQL + '  JOIN CADPOR ON POR_CODPOR = CTP_CODPOR ';
      strSQL := strSQL + '  JOIN CADFOR F ON CTP_CODFOR = FOR_CODFOR ';
      strSQL := strSQL + '  LEFT JOIN CADATI A ON FOR_CODATI = ATI_CODATI ';
      strSQL := strSQL + '  LEFT JOIN CADCTA ON CTP_CODCTA = CTA_CODCTA ';
      strSQL := strSQL + 'WHERE ';

      strSQL := strSQL + fComplementoWhereSQLPosContabilPagar(edtCodEmpresa, arrEmp, (Not fEmptyStr(edtCodPortador.Text)), edtCodPortador, arrPor);

      If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
        strSQL := strSQL + ' AND CTP_DTAVEN BETWEEN :VENINI AND :VENFIN ';

      strSQL := strSQL + fStrLocate(edtCodAtividade,  arrAtividade,  'FOR_CODATI', 'CODATI');

      If (edtBoleto.Text = 'S') Then
        strSQL := strSQL + '  AND CTP_VEIOBO = ' + QuotedStr('S')
      Else If (edtBoleto.Text = 'N') Then
        strSQL := strSQL + '  AND CTP_VEIOBO = ' + QuotedStr('N');

      {**************************}
      {* FILTRO POR COMPETÊNCIA *}
      {************************BB}
      if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
        strSQL := strSQL + '  AND P.CTP_COMPET = :COMPET ';

      If (edtPrevis.Text = 'S') Then
        strSQL := strSQL + '  AND CTP_PREVIS = ' + QuotedStr('S')
      Else If (edtPrevis.Text = 'N') Then
        strSQL := strSQL + '  AND CTP_PREVIS = ' + QuotedStr('N');

      strSQL := strSQL + fStrLocate(edtCodFornecedor,  arrFor,  'CTP_CODFOR', 'CODFOR');

      If Not fEmptyStr(edtCodPortador.Text) Then
        strSQL := strSQL + fStrLocate(edtCodPortador  ,  arrPor,  'CTP_CODPOR', 'CODPOR')
      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        strSQL := strSQL + ' AND (IFNULL(CTP_CODPOR, "") = "" ';
        strSQL := strSQL + ' OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      End;

      If fCfgSis('CTPOBP', varBoolean) Then
        strSQL := strSQL + '  AND POR_ENTPCO = "S" ';

      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '   CTP_CODFOR, FOR_NOMFOR, CTP_CODEMP ';

      If edtOpcao.Text = '2' Then
        strSQL := strSQL + ', CTP_DTAVEN ';

      strSQL := ' SELECT SQL_NO_CACHE CTP_CODFOR, CTP_CODCTA, FOR_NOMFOR, FOR_C_G_C_, FOR_ATIVID, CONCAT(T.CTP_CODCTA,"-",T.CTA_DESCTA) AS CENTRO_CUSTO,  ' +
                ifthen(edtOpcao.Text = '2',' CTP_DTAVEN, ','') +
                '        CTP_CODEMP, SUM(CTP_VALGER) AS CTP_VALGER FROM (' + strSQL + ') AS T ';

      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '   CTP_CODFOR, FOR_NOMFOR, CTP_CODEMP ';

      If edtOpcao.Text = '2' Then
        strSQL := strSQL + ', CTP_DTAVEN ';

      strSQL := strSQL + ' ORDER BY ';
      strSQL := strSQL + '   CTP_CODFOR, FOR_NOMFOR, CTP_CODEMP ';

      If edtOpcao.Text = '2' Then
        strSQL := strSQL + ', CTP_DTAVEN ';


    End;

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pSetaParam(edtCodEmpresa.Text, arrEmp, strEmp, 'CODEMP', qryRelatorio);
//        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
        ParamByName('COMPET').AsString := mskCompet.Text;

      If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      Begin
        ParamByName('VENINI').AsDate := StrToDate(mskVenIni.Text);
        ParamByName('VENFIN').AsDate := StrToDate(mskVenFin.Text);
      End;        

      pSetaParam(edtCodAtividade.Text, arrAtividade, strAtividade, 'CODATI', qryRelatorio);

      If Not fEmptyStr(edtCodPortador.Text) Then
        pSetaParam(edtCodPortador.Text, arrPor, strPortador, 'CODPOR', qryRelatorio);

      pSetaParam(edtCodFornecedor.Text, arrFor, strFornecedor, 'CODFOR', qryRelatorio);

      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin

      Try
        pGeraResumo(strRes);

        pCriarFormularios(TfrmQckCtpPosContabil,frmQckCtpPosContabil);

        frmQckCtpPosContabil.dtsRelatorio.DataSet := qryRelatorio;

        frmQckCtpPosContabil.dtsResumo.DataSet := qryResumo;

        frmQckCtpPosContabil.strTipoRel := strTipoRel;

        If edtTipo.Text = 'S' Then
             frmQckCtpPosContabil.strOpcSint := edtOpcao.Text
        Else frmQckCtpPosContabil.strOpcSint := '';

        If strTipImp = 'M' Then
          frmQckCtpPosContabil.rllNomeRelatorio.Caption := 'RELATORIO DA POSICAO CONTABIL ( CONTAS A PAGAR ) '
        Else
          frmQckCtpPosContabil.rllNomeRelatorio.Caption := 'RELATÓRIO DA POSIÇÃO CONTÁBIL ( CONTAS A PAGAR ) ';

        If strTipImp = 'M' Then
          frmQckCtpPosContabil.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckCtpPosContabil.qckPagina.DefaultFilter := Nil;

        frmQckCtpPosContabil.strOrdem := 'DATA FINAL: ' + mskDtaFin.Text;

        If edtCodEmpresa.Text = '' Then
        Begin
          frmQckCtpPosContabil.rllEmpresa.Caption := 'EMPRESA: TODAS';
          frmQckCtpPosContabil.rllEmpresa1.Caption := 'EMPRESA: TODAS';
        End
        Else
        Begin
          frmQckCtpPosContabil.rllEmpresa.Caption :=  fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA');
          frmQckCtpPosContabil.rllEmpresa1.Caption := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA');
        End;

        If edtCodFornecedor.Text = '' Then
        Begin
          frmQckCtpPosContabil.rllFornecedor.Caption  := 'FORNECEDOR: TODOS';
          frmQckCtpPosContabil.rllFornecedor1.Caption := 'FORNECEDOR: TODOS';
        End
        Else
        Begin
          frmQckCtpPosContabil.rllFornecedor.Caption  := 'FORNECEDOR: ' + edtDesFornecedor.Text;
          frmQckCtpPosContabil.rllFornecedor1.Caption := 'FORNECEDOR: ' + edtDesFornecedor.Text;
        End;

        If edtCodPortador.Text = '' Then
        Begin
          frmQckCtpPosContabil.rllPortador.Caption  := 'PORTADOR: TODOS';
          frmQckCtpPosContabil.rllPortador1.Caption := 'PORTADOR: TODOS';
        End
        Else
        Begin
          frmQckCtpPosContabil.rllPortador.Caption  := 'PORTADOR: ' + edtDesPortador.Text;
          frmQckCtpPosContabil.rllPortador1.Caption := 'PORTADOR: ' + edtDesPortador.Text;
        End;

        If edtCodAtividade.Text = '' Then
        Begin
          frmQckCtpPosContabil.rllAtividade.Caption := 'ATIVIDADE: TODAS';
          frmQckCtpPosContabil.rllAtividade1.Caption := 'ATIVIDADE: TODAS';
        End
        Else
        Begin
          frmQckCtpPosContabil.rllAtividade.Caption := 'ATIVIDADE: ' + edtDesAtividade.Text;
          frmQckCtpPosContabil.rllAtividade1.Caption := 'ATIVIDADE: ' + edtDesAtividade.Text;
        End;

        If edtBoleto.Text = 'S' Then
        Begin
          frmQckCtpPosContabil.rllBoleto.Caption := 'VEIO BOL?: SIM';
          frmQckCtpPosContabil.rllBoleto1.Caption := 'VEIO BOL?: SIM';
        End
        Else If edtBoleto.Text = 'N' Then
        Begin
          If strTipImp = 'M' Then
          Begin
            frmQckCtpPosContabil.rllBoleto.Caption := 'VEIO BOL?: NAO';
            frmQckCtpPosContabil.rllBoleto1.Caption := 'VEIO BOL?: NAO';
          end
          Else
          begin
            frmQckCtpPosContabil.rllBoleto.Caption := 'VEIO BOL?: NÃO';
            frmQckCtpPosContabil.rllBoleto1.Caption := 'VEIO BOL?: NÃO';
          end;
        End
        Else
        Begin
          frmQckCtpPosContabil.rllBoleto.Caption := 'VEIO BOL?: TODOS';
          frmQckCtpPosContabil.rllBoleto1.Caption := 'VEIO BOL?: TODOS';
        End;

        If edtPrevis.Text = 'S' Then
        Begin
          If strTipImp = 'M' Then
          Begin
            frmQckCtpPosContabil.rllPrevisao.Caption := 'PREVISAO?: SIM';
            frmQckCtpPosContabil.rllPrevisao1.Caption := 'PREVISAO?: SIM';
          end
          Else
          begin
            frmQckCtpPosContabil.rllPrevisao.Caption := 'PREVISÃO?: SIM';
            frmQckCtpPosContabil.rllPrevisao1.Caption := 'PREVISÃO?: SIM';
          end;
        End
        Else If edtPrevis.Text = 'N' Then
        Begin
          If strTipImp = 'M' Then
          Begin
            frmQckCtpPosContabil.rllPrevisao.Caption := 'PREVISAO?: NAO';
            frmQckCtpPosContabil.rllPrevisao1.Caption := 'PREVISAO?: NAO';
          end
          Else
          begin
            frmQckCtpPosContabil.rllPrevisao.Caption := 'PREVISÃO?: NÃO';
            frmQckCtpPosContabil.rllPrevisao1.Caption := 'PREVISÃO?: NÃO';
          end;
        End
        Else
        Begin
          If strTipImp = 'M' Then
          Begin
            frmQckCtpPosContabil.rllPrevisao.Caption := 'PREVISAO?: TODOS';
            frmQckCtpPosContabil.rllPrevisao1.Caption := 'PREVISAO?: TODOS';
          end
          Else
          begin
            frmQckCtpPosContabil.rllPrevisao.Caption := 'PREVISÃO?: TODOS';
            frmQckCtpPosContabil.rllPrevisao1.Caption := 'PREVISÃO?: TODOS';
          end;
        End;

        If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
        Begin
          If strTipImp = 'M' Then
          Begin
            frmQckCtpPosContabil.rllPerVen.Caption := 'PERIODO DE VENCIMENTO: ' + mskVenIni.Text + ' A ' + mskVenFin.Text;
            frmQckCtpPosContabil.rllPerVen1.Caption := 'PERIODO DE VENCIMENTO: ' + mskVenIni.Text + ' A ' + mskVenFin.Text;
          end
          Else
          begin
            frmQckCtpPosContabil.rllPerVen.Caption := 'PERÍODO DE VENCIMENTO: ' + mskVenIni.Text + ' A ' + mskVenFin.Text;
            frmQckCtpPosContabil.rllPerVen1.Caption := 'PERÍODO DE VENCIMENTO: ' + mskVenIni.Text + ' A ' + mskVenFin.Text;
          end;
        End
        Else
        Begin
          If strTipImp = 'M' Then
          Begin
            frmQckCtpPosContabil.rllPerVen.Caption := 'PERIODO DE VENCIMENTO: TODOS';
            frmQckCtpPosContabil.rllPerVen1.Caption := 'PERIODO DE VENCIMENTO: TODOS';
          end
          Else
          begin
            frmQckCtpPosContabil.rllPerVen.Caption := 'PERÍODO DE VENCIMENTO: TODOS';
            frmQckCtpPosContabil.rllPerVen1.Caption := 'PERÍODO DE VENCIMENTO: TODOS';
          end;
        End;

        If (edtOrdem.Text = 'C') Or
           (edtOrdem.Text = 'N') Then
          frmQckCtpPosContabil.RLLabel13.Caption := 'Total do Fornecedor:'
        Else
          frmQckCtpPosContabil.RLLabel13.Caption := 'Total Parcial do Fornecedor:';

        If edtDestino.Text = 'V' Then
          frmQckCtpPosContabil.qckPagina.PreviewModal
        Else if edtDestino.Text = 'I' Then
          frmQckCtpPosContabil.qckPagina.Print
        Else if edtDestino.Text = 'E' Then
          pGeraExcel;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckCtpPosContabil);
    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';
  pSetFocus(mskDtaFin);
end;

procedure TfrmRelCtpPosContabil.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaFin); 
end;

procedure TfrmRelCtpPosContabil.FormCreate(Sender: TObject);
begin
  inherited;
  qryResumo := fCriaQuery;
end;

procedure TfrmRelCtpPosContabil.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryResumo);
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelCtpPosContabil.edtCodAtividadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAtividade, edtDesAtividade, arrAtividade, Nil, fRetNomAtividade, 'da atividade');

end;

procedure TfrmRelCtpPosContabil.edtCodAtividadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAtividade, edtDesAtividade, Nil, Key, arrAtividade, False) Then
	Begin
		fValidaCampos(edtCodAtividade, False);
		Self.SelectNext(ActiveControl, True, True);
	End;
end;

procedure TfrmRelCtpPosContabil.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelCtpPosContabil.pGeraExcel;
  Var
    objExcel    : TExcel;
    strCodigoFor: String;
    curValor1,curValorTotal1: Currency;

begin
  Screen.Cursor := crSQLWait;

  curValor1 := 0;
  curValorTotal1 := 0;

  {*******************************************}
  {* CRIA UM OBJETO DO TIPO "EXCEL" E TORNA  *}
  {* A APLICAÇÃO INVISÍVEL                   *}
  {************************************** AM *}
  objExcel := TExcel.fCriarExcel(Self);

  If Not objExcel.CriarArquivo Then
  Begin
    FreeAndNil(objExcel);
    Exit;
  End;

  With objExcel Do
  Begin
    LinhaAtual := 01;
    {**********************************}
    {* EMPRESA PADRAO DO SISTEMA      *}
    {***************************** AM *}
    Escrever(ProximaLinha, 01, fRetNomeEmpresaSelec(VS_strCodEmp));

    {*******************************************}
    {* TITULO DO RELATORIO                     *}
    {************************************** AM *}
    If (strTipoRel = 'S') Then
    Begin
      Escrever(ProximaLinha, 01, 'RELATÓRIO DA POSIÇÃO CONTÁBIL ( CONTAS A PAGAR ) -  SINTÉTICO ');
      If (edtOpcao.Text = '1') Then
        Escrever(ProximaLinha, 01, 'POR FORNECEDOR / EMPRESA')
      Else
        Escrever(ProximaLinha, 01, 'POR FORNECEDOR / EMPRESA / VENCIMENTO');
    End
    Else If (strTipoRel = 'A') Then
    Begin
      Escrever(ProximaLinha, 01, 'RELATÓRIO DA POSIÇÃO CONTÁBIL ( CONTAS A PAGAR ) -  ANALÍTICO ');
      ProximaLinha;
    End;

    If edtCodEmpresa.Text = '' Then
      Escrever(ProximaLinha, 01, 'EMPRESA: TODAS')
    Else
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA'));

    If edtCodFornecedor.Text = '' Then
      Escrever(ProximaLinha, 01, 'FORNECEDOR: TODOS')
    Else
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodFornecedor.Text, edtDesFornecedor, arrFor, strFornecedor, 'FORNECEDOR'));

    if edtBoleto.Text = 'T' Then
    begin
      Escrever(ProximaLinha, 01, 'BOLETO?: TODOS');
    end
    else
    if edtBoleto.Text = 'S' Then
    begin
      Escrever(ProximaLinha, 01, 'BOLETO?: SIM');
    end
    else
    begin
      Escrever(ProximaLinha, 01, 'BOLETO?: NÃO');
    end;

    If edtCodAtividade.Text = '' Then
      Escrever(ProximaLinha, 01, 'ATIVIDADE: TODAS')
    Else
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodAtividade.Text, edtDesAtividade, arrAtividade, strAtividade, 'ATIVIDADE'));

    If edtCodPortador.Text = '' Then
      Escrever(ProximaLinha, 01, 'PORTADOR: TODOS')
    Else
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodPortador.Text, edtDesPortador, arrPor, strPortador, 'PORTADOR'));

    If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) And Not fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text)) Then
       Escrever(ProximaLinha, 01, 'VENCIMENTO DE ' + mskVenIni.Text + ' E ' + mskVenFin.Text);

    {*******************************************}
    {* OUTROS DADOS DO RELATÓRIO               *}
    {************************************** AM *}
    Escrever(ProximaLinha, 01, 'CADASTRO: ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaFin.Text)));
    ProximaLinha;

    If (strTipoRel = 'A') Then
    Begin
      Mesclar('A1', 'L1');
      Mesclar('A2', 'L2');
      Mesclar('A3', 'L3');
      Alinhamento('A1', 'L3', Centro);
      Negrito('A1', 'L3', True);

      Mesclar('A4', 'L4');
      Mesclar('A5', 'L5');
      Mesclar('A6', 'L6');
      Mesclar('A7', 'L7');
      Mesclar('A8', 'L8');
      Mesclar('A9', 'L9');
      Mesclar('A10', 'L10');
      Mesclar('A11', 'L11');
      Mesclar('A12', 'L12');

      Alinhamento('A4' ,'L11', Centro);
      Negrito('A4','L13', True);

      {*************************************}
      {* COLORI O FUNDO DA CELULA P/ CINZA *}
      {******************************** AM *}
      Excel.Range['A2','L2'].Interior.ColorIndex := 15;
      Excel.Range['A3','L3'].Interior.ColorIndex := 15;
      Excel.Range['A4','L4'].Interior.ColorIndex := 15;
      Excel.Range['A5','L5'].Interior.ColorIndex := 15;
      Excel.Range['A6','L6'].Interior.ColorIndex := 15;
      Excel.Range['A7','L7'].Interior.ColorIndex := 15;
      Excel.Range['A8','L8'].Interior.ColorIndex := 15;
      Excel.Range['A9','L9'].Interior.ColorIndex := 15;
      Excel.Range['A10','L10'].Interior.ColorIndex := 15;
      Excel.Range['A11','L11'].Interior.ColorIndex := 15;
      Excel.Range['A13','L13'].Interior.ColorIndex := 15;
    end
    else
    If (strTipoRel = 'S') Then
    Begin
      Mesclar('A1', 'H1');
      Mesclar('A2', 'H2');
      Mesclar('A3', 'H3');
      Alinhamento('A1', 'H3', Centro);
      Negrito('A1', 'H3', True);

      Mesclar('A4', 'H4');
      Mesclar('A5', 'H5');
      Mesclar('A6', 'H6');
      Mesclar('A7', 'H7');
      Mesclar('A8', 'H8');
      Mesclar('A9', 'H9');
      Mesclar('A10', 'H10');
      Mesclar('A11', 'H11');
      Mesclar('A12', 'H12');

      Alinhamento('A4' ,'H11', Centro);
      Negrito('A4','H13', True);

      {*************************************}
      {* COLORI O FUNDO DA CELULA P/ CINZA *}
      {******************************** AM *}
      Excel.Range['A2','H2'].Interior.ColorIndex := 15;
      Excel.Range['A3','H3'].Interior.ColorIndex := 15;
      Excel.Range['A4','H4'].Interior.ColorIndex := 15;
      Excel.Range['A5','H5'].Interior.ColorIndex := 15;
      Excel.Range['A6','H6'].Interior.ColorIndex := 15;
      Excel.Range['A7','H7'].Interior.ColorIndex := 15;
      Excel.Range['A8','H8'].Interior.ColorIndex := 15;
      Excel.Range['A9','H9'].Interior.ColorIndex := 15;
      Excel.Range['A10','H10'].Interior.ColorIndex := 15;
      Excel.Range['A11','H11'].Interior.ColorIndex := 15;
      Excel.Range['A13','H13'].Interior.ColorIndex := 15;
    end;

    ProximaLinha;

    If (strTipoRel = 'A') Then
    Begin
      {*******************************************}
      {* COLUNAS                                 *}
      {************************************** AM *}
      Escrever(LinhaAtual, 01, 'CÓDIGO');
      Escrever(LinhaAtual, 02, 'FORNECEDOR');
      Escrever(LinhaAtual, 03, '');
      Escrever(LinhaAtual, 04, 'ATIVIDADE');
      Escrever(LinhaAtual, 05, 'CNPJ/CPF');
      Escrever(LinhaAtual, 06, 'PLANO DE CONTAS');
      Escrever(LinhaAtual, 07, 'BOLETO?');
      Escrever(LinhaAtual, 08, 'DUPLICATA');
      Escrever(LinhaAtual, 09, 'LOJA');
      Escrever(LinhaAtual, 10, 'CADASTRO');
      Escrever(LinhaAtual, 11, 'VENCIMENTO');
      Escrever(LinhaAtual, 12, 'VALOR');
      Alinhamento(LinhaAtual, 12, Direita);

      {*******************************************}
      {* COLOCA NEGRITO NAS COLUNAS              *}
      {****************************************LU*}
      Negrito('A' + IntToStr(LinhaAtual), 'L' + IntToStr(LinhaAtual), True);

      {********************************}
      {* INSERE BORDAS NA CELULA      *}
      {*****************************LU*}
      Bordas('A2', 'L11');
      Bordas('A12', 'L13');

    End
    Else If (strTipoRel = 'S') Then
    Begin
      {*******************************************}
      {* COLUNAS                                 *}
      {************************************** AM *}
      Escrever(LinhaAtual, 01, 'CÓDIGO');
      Escrever(LinhaAtual, 02, 'FORNECEDOR');
      Escrever(LinhaAtual, 03, 'ATIVIDADE');
      Escrever(LinhaAtual, 04, 'CNPJ/CPF');
      Escrever(LinhaAtual, 05, 'PLANO DE CONTAS');
      Escrever(LinhaAtual, 06, 'LOJA');
      Escrever(LinhaAtual, 07, '');

      If edtOpcao.Text = '2' Then
        Escrever(LinhaAtual, 07, 'VENCIMENTO');

      Escrever(LinhaAtual, 08, 'VALOR');
      Alinhamento(LinhaAtual, 08, Direita);

      {*******************************************}
      {* COLOCA NEGRITO NAS COLUNAS              *}
      {****************************************LU*}
      Negrito('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), True);

      {********************************}
      {* INSERE BORDAS NA CELULA      *}
      {*****************************LU*}
      Bordas('A2', 'H12');
      Bordas('A12', 'H13');
    End;

    ProximaLinha;

    With qryRelatorio Do
    Begin
      First;
      strCodigoFor := FieldByName('CTP_CODFOR').AsString;

      {***************************************************}
      {* VERSÃO: SINTÉTICO                               *}
      {********************************************* AM **}
      If (strTipoRel = 'S') Then
      Begin
        If Not Eof Then
        Begin
          Escrever(LinhaAtual, 01, '''' + FieldByName('CTP_CODFOR').AsString);
          Escrever(LinhaAtual, 02, '''' + FieldByName('FOR_NOMFOR').AsString);
          Escrever(LinhaAtual, 06, '''' + FieldByName('CTP_CODEMP').AsString);
        End;

        While (Not Eof) Do
        Begin
          Escrever(LinhaAtual, 03, '''' + FieldByName('FOR_ATIVID').AsString);
          Escrever(LinhaAtual, 04, '''' + FieldByName('FOR_C_G_C_').AsString);
          Escrever(LinhaAtual, 05, '''' + FieldByName('CENTRO_CUSTO').AsString);

          If FieldByName('CTP_CODFOR').AsString <> strCodigoFor Then
          Begin
            Escrever(LinhaAtual, 07, 'Valor Parcial do Fornecedor: ');
            Escrever(LinhaAtual, 08, '''' + FloatToStrF(curValor1, ffFixed, 12, 2));
            Alinhamento(LinhaAtual, 08, Direita);
            ProximaLinha;
          End;

          Application.ProcessMessages;

          {***************************************************}
          {* se for sintético agrupa lançamentos do cliente  *}
          {********************************************* AM **}

          If FieldByName('CTP_CODFOR').AsString = strCodigoFor Then
          Begin
            {******************************************************************************}
            {* usa as variáveis seguintes para calculo dos valores parciais e Finais      *}
            {******************************************************************* AM *******}
            curValor1      := curValor1 + FieldByName('CTP_VALGER').AsCurrency;
            curValorTotal1 := curValorTotal1 + FieldByName('CTP_VALGER').AsCurrency;
            {******************************************************************** AM ******}
            If Not Eof Then
            Begin
              Escrever(LinhaAtual, 06, '''' + FieldByName('CTP_CODEMP').AsString);

              If edtOpcao.Text = '2' Then
                Escrever(LinhaAtual, 07, '''' + FormatDateTime('dd/MM/yyyy', FieldByName('CTP_DTAVEN').AsDateTime));

              Escrever(LinhaAtual, 08, '''' + FloatToStrF(FieldByName('CTP_VALGER').AsCurrency, ffFixed, 12, 2));
              Alinhamento(LinhaAtual, 08, Direita);
            End;
          End
          Else
          Begin
            {************************************************************************}
            {* QUANDO (SINTÉTICO) O CÓDIGO DO CLIENTE É DIFERENTE DO ANTERIOR ZERA, *}
            {* SOMA E GERA A LINHA                                                  *}
            {****************************************************************** AM **}
            curValor1      := 0;
            curValor1      := curValor1 + FieldByName('CTP_VALGER').AsCurrency;
            curValorTotal1 := curValorTotal1 + FieldByName('CTP_VALGER').AsCurrency;

            Escrever(LinhaAtual, 01, '''' + FieldByName('CTP_CODFOR').AsString);
            Escrever(LinhaAtual, 02, '''' + FieldByName('FOR_NOMFOR').AsString);
            Escrever(LinhaAtual, 06, '''' + FieldByName('CTP_CODEMP').AsString);

            If edtOpcao.Text = '2' Then
              Escrever(LinhaAtual, 07, '''' + FormatDateTime('dd/MM/yyyy', FieldByName('CTP_DTAVEN').AsDateTime));

            Escrever(LinhaAtual, 08, '''' + FloatToStrF(FieldByName('CTP_VALGER').AsCurrency, ffFixed, 12, 2));
            Alinhamento(LinhaAtual, 08, Direita);
            strCodigoFor := FieldByName('CTP_CODFOR').AsString;
          End;

          Next;
          ProximaLinha;
        End;
        If FieldByName('CTP_CODFOR').AsString = strCodigoFor Then
        Begin
          Escrever(LinhaAtual, 07, 'Valor Parcial do Fornecedor: ');
          Escrever(LinhaAtual, 08, '''' + FloatToStrF(curValor1, ffFixed, 12, 2));
          Alinhamento(LinhaAtual, 08, Direita);
          ProximaLinha;
        End;

        Escrever(LinhaAtual, 07, 'Total Geral:');
        Escrever(LinhaAtual, 08, FloatToStrF(curValorTotal1, ffFixed, 12, 2));
        Alinhamento(LinhaAtual, 08, Direita);
        Mesclar('A'+ IntToStr(LinhaAtual) , 'G' + IntToStr(LinhaAtual));
        Bordas('A'+ IntToStr(LinhaAtual) , 'H' + IntToStr(LinhaAtual));
        Alinhamento('A'+ IntToStr(LinhaAtual) , 'H' + IntToStr(LinhaAtual), Direita);
        Negrito('A' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), True);
      End
      {***************************************************}
      {* VERSÃO: ANALÍTICO                               *}
      {********************************************* AM **}

      Else If (strTipoRel = 'A') Then
      Begin
        While (Not Eof) Do
        Begin
          Application.ProcessMessages;

          {*****************************************************}
          {* se for analítico gera cada lançamento do cliente  *}
          {*********************************************** AM **}

          If FieldByName('CTP_CODFOR').AsString = strCodigoFor Then
          Begin
            {**************************************************************************************************}
            {* usa as variáveis seguintes para calculo dos valores parciais e Finais                          *}
            {*************************************************************************************** AM *******}
            curValor1      := curValor1 + qryRelatorio.FieldByName('CTP_VALGER').AsCurrency;
            curValorTotal1 := curValorTotal1 + qryRelatorio.FieldByName('CTP_VALGER').AsCurrency;
            {*************************************************************************************** AM ******}
            Escrever(LinhaAtual, 01, '''' + FieldByName('CTP_CODFOR').AsString);
            Escrever(LinhaAtual, 02, '''' + FieldByName('FOR_NOMFOR').AsString);

            Escrever(LinhaAtual, 04, '''' + FieldByName('FOR_ATIVID').AsString);
            Escrever(LinhaAtual, 05, '''' + FieldByName('FOR_C_G_C_').AsString);
            Escrever(LinhaAtual, 06, '''' + FieldByName('CENTRO_CUSTO').AsString);

            Escrever(LinhaAtual, 07, '''' + FieldByName('CTP_VEIOBO').AsString);
            Escrever(LinhaAtual, 08, '''' + FieldByName('CTP_NUMDUP').AsString);
            Escrever(LinhaAtual, 09, '''' + FieldByName('CTP_CODEMP').AsString);
            Escrever(LinhaAtual, 10, '''' + FormatDateTime('dd/MM/yyyy', FieldByName('CTP_DTACAD').AsDateTime));
            Escrever(LinhaAtual, 11, '''' + FormatDateTime('dd/MM/yyyy', FieldByName('CTP_DTAVEN').AsDateTime));
            Escrever(LinhaAtual, 12, '''' + FloatToStrF(FieldByName('CTP_VALGER').AsCurrency, ffFixed, 12, 2));
            Alinhamento(LinhaAtual, 12, Direita);

          End
          Else
          Begin
            {************************************************************************}
            {* QUANDO (ANALÍTICO) O CÓDIGO DO CLIENTE É DIFERENTE DO ANTERIOR ZERA, *}
            {* SOMA E GERA A LINHA                                                  *}
            {****************************************************************** AM **}
            {************************************************************************}
            {* ESSA LINHA SERVE COMO BARRA DE TOTALIZAÇÃO DE CADA CLIENTE           *}
            {************************************************************************}
            If (edtOrdem.Text = 'C') Or
               (edtOrdem.Text = 'N') Then
              Escrever(LinhaAtual, 11, 'Total do Fornecedor: ')
            Else
              Escrever(LinhaAtual, 11, 'Valor Parcial do Fornecedor: ');
            Escrever(LinhaAtual, 12, FloatToStrF(curValor1, ffFixed, 12, 2));
            Alinhamento(LinhaAtual, 12, Direita);
            curValor1      := 0;
            curValor1      := curValor1 + FieldByName('CTP_VALGER').AsCurrency;
            curValorTotal1 := curValorTotal1 + FieldByName('CTP_VALGER').AsCurrency;
            strCodigoFor := FieldByName('CTP_CODFOR').AsString;
            ProximaLinha;
            Escrever(LinhaAtual, 01, '''' + FieldByName('CTP_CODFOR').AsString);
            Escrever(LinhaAtual, 02, '''' + FieldByName('FOR_NOMFOR').AsString);

            Escrever(LinhaAtual, 04, '''' + FieldByName('FOR_ATIVID').AsString);
            Escrever(LinhaAtual, 05, '''' + FieldByName('FOR_C_G_C_').AsString);
            Escrever(LinhaAtual, 06, '''' + FieldByName('CENTRO_CUSTO').AsString);

            Escrever(LinhaAtual, 07, '''' + FieldByName('CTP_VEIOBO').AsString);
            Escrever(LinhaAtual, 08, '''' + FieldByName('CTP_NUMDUP').AsString);
            Escrever(LinhaAtual, 09, '''' + FieldByName('CTP_CODEMP').AsString);
            Escrever(LinhaAtual, 10, '''' + FormatDateTime('dd/MM/yyyy', FieldByName('CTP_DTACAD').AsDateTime));
            Escrever(LinhaAtual, 11, '''' + FormatDateTime('dd/MM/yyyy', FieldByName('CTP_DTAVEN').AsDateTime));
            Escrever(LinhaAtual, 12, '''' + FloatToStrF(FieldByName('CTP_VALGER').AsCurrency, ffFixed, 12, 2));
            Alinhamento(LinhaAtual, 12, Direita);
          End;

          Next;
          ProximaLinha;
        End;
        If FieldByName('CTP_CODFOR').AsString = strCodigoFor Then
        Begin
          If (edtOrdem.Text = 'C') Or
             (edtOrdem.Text = 'N') Then
            Escrever(LinhaAtual, 11, 'Total do Fornecedor: ')
          Else
            Escrever(LinhaAtual, 11, 'Valor Parcial do Fornecedor: ');
          Escrever(LinhaAtual, 12, FloatToStrF(curValor1, ffFixed, 12, 2));
          Alinhamento(LinhaAtual, 12, Direita);
          ProximaLinha;
        End;

        Escrever(LinhaAtual, 11, 'Total Geral:');
        Escrever(LinhaAtual, 12, FloatToStrF(curValorTotal1, ffFixed, 12, 2));
        Alinhamento(LinhaAtual, 12, Direita);
        Mesclar('A'+ IntToStr(LinhaAtual) , 'K' + IntToStr(LinhaAtual));
        Bordas('A'+ IntToStr(LinhaAtual) , 'L' + IntToStr(LinhaAtual));
        Alinhamento('A'+ IntToStr(LinhaAtual) , 'L' + IntToStr(LinhaAtual), Direita);
        Negrito('A' + IntToStr(LinhaAtual), 'L' + IntToStr(LinhaAtual), True);
      End;
    End;

    CongelarPaines('A14');
    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;
  End;
  FreeAndNil(objExcel);

  Screen.Cursor := crDefault;

  fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
End;

procedure TfrmRelCtpPosContabil.edtTipoChange(Sender: TObject);
begin
  inherited;

  If edtTipo.Text = 'A' Then
  Begin
    edtOpcao.Enabled := False;
    edtOrdem.Enabled := True;
  End
  Else
  Begin
    edtOrdem.Enabled := False;
    edtOpcao.Enabled := True;
  End;

end;

procedure TfrmRelCtpPosContabil.pGeraResumo(strSelect: String);
  Var
    strSQL: String;
begin

  Try
    strSQL := '';

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "VENCIDOS" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("ULTIMOS 30 DIAS (",DATE_FORMAT(ADDDATE(:DTAFIN,-30),"%d/%m/%Y")," A ",DATE_FORMAT(:DTAFIN,"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTP_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTP_DTAVEN BETWEEN ADDDATE(:DTAFIN, -30) AND :DTAFIN ';

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "VENCIDOS" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("ENTRE 31 E 180 DIAS (",DATE_FORMAT(ADDDATE(:DTAFIN,-180),"%d/%m/%Y")," A ",DATE_FORMAT(ADDDATE(:DTAFIN,-31),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTP_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTP_DTAVEN BETWEEN ADDDATE(:DTAFIN, -180) AND ADDDATE(:DTAFIN, -31) ';

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "VENCIDOS" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("ENTRE 181 E 360 DIAS (",DATE_FORMAT(ADDDATE(:DTAFIN,-360),"%d/%m/%Y")," A ",DATE_FORMAT(ADDDATE(:DTAFIN,-181),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTP_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTP_DTAVEN BETWEEN ADDDATE(:DTAFIN, -360) AND ADDDATE(:DTAFIN, -181) ';

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "VENCIDOS" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("A 361 DIAS OU MAIS (MAIOR QUE ",DATE_FORMAT(ADDDATE(:DTAFIN,-361),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTP_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTP_DTAVEN <= ADDDATE(:DTAFIN, -361) ';

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "A VENCER" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("PROXIMOS 30 DIAS (",DATE_FORMAT(ADDDATE(:DTAFIN,1),"%d/%m/%Y")," A ",DATE_FORMAT(ADDDATE(:DTAFIN,30),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTP_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTP_DTAVEN BETWEEN ADDDATE(:DTAFIN, 1) AND ADDDATE(:DTAFIN, 30) ';

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "A VENCER" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("ENTRE 31 E 180 DIAS (",DATE_FORMAT(ADDDATE(:DTAFIN,31),"%d/%m/%Y")," A ",DATE_FORMAT(ADDDATE(:DTAFIN,180),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTP_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTP_DTAVEN BETWEEN ADDDATE(:DTAFIN, 31) AND ADDDATE(:DTAFIN, 180) ';

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "A VENCER" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("ENTRE 181 E 360 DIAS (",DATE_FORMAT(ADDDATE(:DTAFIN,181),"%d/%m/%Y")," A ",DATE_FORMAT(ADDDATE(:DTAFIN,360),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTP_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTP_DTAVEN BETWEEN ADDDATE(:DTAFIN, 181) AND ADDDATE(:DTAFIN, 360) ';

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "A VENCER" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("EM 361 DIAS OU MAIS (MAIOR QUE ",DATE_FORMAT(ADDDATE(:DTAFIN,361),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTP_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTP_DTAVEN >= ADDDATE(:DTAFIN, 361) ';

    With qryResumo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      Begin
        ParamByName('VENINI').AsDate := StrToDate(mskVenIni.Text);
        ParamByName('VENFIN').AsDate := StrToDate(mskVenFin.Text);
      End;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pSetaParam(edtCodEmpresa.Text, arrEmp, strEmp, 'CODEMP', qryResumo);
//        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

//      If Not fEmptyStr(edtCodAtividade.Text) Then
//        ParamByName('CODATI').AsString := edtCodAtividade.Text;

      pSetaParam(edtCodAtividade.Text, arrAtividade, strAtividade, 'CODATI', qryResumo);

      If Not fEmptyStr(edtCodPortador.Text) Then
        pSetaParam(edtCodPortador.Text, arrPor, strPortador, 'CODPOR', qryResumo);

      pSetaParam(edtCodFornecedor.Text, arrFor, strFornecedor, 'CODFOR', qryResumo);

      Open;

      TFloatField(FieldByName('VTOTAL')).DisplayFormat := '#,##0.00';
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

end.

