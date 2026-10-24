unit untImpEtiDespacho;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, untConsultas, cxProgressBar,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, untTypesSistema, TypesRel,
  untFuncoesEtiquetas, Uni, frxClass, frxDBSet, UniClientDataSet, untFuncoesSimples, BitBtnLockedIncrem,
  frxExportCSVTestabilidade, Data.DB, Datasnap.DBClient, untFuncoes;

type
  TfrmImpEtiDespacho = class(TfrmPai)
    pnlFundo: TPanel;
    frxEtiDespacho: TfrxReport;
    frxDados: TfrxDBDataset;
    btnConfirma: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    edtCodEmp: TEditFocus;
    lblEmpresa: TLabel;
    edtNomEmp: TEditFocus;
    pnlCliente: TPanel;
    Label4: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    pnlDocumento: TPanel;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    edtQtdVol: TEditFocus;
    edtEtqInicial: TEditFocus;
    lblEtqInicial: TLabel;
    rdgTpDestinatario: TRadioGroup;
    pnlTipoEtiq: TPanel;
    rdgTipoEtiq: TRadioGroup;
    cdsCaixas: TUniClientDataSet;
    cdsCaixasFGC_IMPRIM: TBooleanField;
    cdsCaixasFGC_CAI_ID: TStringField;
    cdsCaixasFGO_NUMDOC: TStringField;
    cdsCaixasFGO_ESPDOC: TStringField;
    cdsCaixasFGO_CODEMP: TStringField;
    cdsCaixasFGC_NUMFAT: TStringField;
    cdsCaixasFGC_TIPFAT: TStringField;
    cdsCaixasFGC_EMPFAT: TStringField;
    cdsCaixasCLI_BAIRRO: TStringField;
    cdsCaixasCLI_C_E_P_: TStringField;
    cdsCaixasCLI_CODCLI: TStringField;
    cdsCaixasCLI_ENDERE: TStringField;
    cdsCaixasCLI_ENDNUM: TStringField;
    cdsCaixasCLI_ENDCOM: TStringField;
    cdsCaixasCLI_CODCID: TStringField;
    cdsCaixasCLI_FANSOB: TStringField;
    cdsCaixasFGO_DTAENT: TDateField;
    cdsCaixasFDO_CODVEN: TStringField;
    cdsCaixasFDO_CODVE2: TStringField;
    cdsCaixasFDO_NUMCMP: TStringField;
    cdsCaixasFGO_SEPEXP: TStringField;
    cdsCaixasFGO_OPEEXP: TStringField;
    cdsCaixasREG_DESREG: TStringField;
    cdsCaixasTRA_NOMTRA: TStringField;
    cdsEtiCaixa: TUniClientDataSet;
    fldEtiCaixaid: TStringField;
    fldEtiCaixapedido: TStringField;
    fldEtiCaixacodigo: TStringField;
    strngfldEtiCaixadescricao: TStringField;
    cdsEtiCaixaquantidade: TFloatField;
    fldEtiCaixaunidade: TStringField;
    cdsEtiCaixapeso: TFloatField;
    cdsEtiCaixaSeqCx: TSmallintField;
    cdsEtiCaixacodfab: TStringField;
    cdsEtiCaixafgoinc: TStringField;
    cdsEtiCaixafdoinc: TStringField;
    cdsEtiCaixapestot: TAggregateField;
    cdsCaixasFGC_FDOINC: TStringField;
    cdsCaixasFDO_TOTPES: TFloatField;
    chkImpAut: TCheckBox;
    pnlVolumeSepExc: TPanel;
    lblQtdVolSepExc: TLabel;
    edtQtdVolSepExc: TEditFocus;
    lblQtdVolSepNExc: TLabel;
    edtQtdVolSepNExc: TEditFocus;
    cdsEtiCaixaCodBar: TStringField;
    cdsEtiCaixaDtaRot: TStringField;
    cdsCaixasFGO_PESBRU: TFloatField;
    cdsCaixasFGO_CODROT: TStringField;
    cdsEtiCaixaseqCxId: TStringField;
    cdsCaixasREG_CODREG: TStringField;
    cdsAmbiente: TUniClientDataSet;
    cdsAmbienteAMBIENTE: TStringField;
    cdsAmbienteVOLUME: TIntegerField;
    cdsCaixasENDENT: TStringField;
    cdsCaixasCEPENT: TStringField;
    cdsCaixasCIDENT: TStringField;
    cdsCaixasESTENT: TStringField;
    cdsCaixasBAIENT: TStringField;
    edtChave: TEditFocus;
    lblTituloNF: TLabel;
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure rdgTpDestinatarioClick(Sender: TObject);
    procedure edtChaveChange(Sender: TObject);
  private
    { Private declarations }
    strUltimaFilaUtilizada: String;
    strNomImp: String;
    strNomPro: string;
    strDesPro: string;
    strTip_fc: String;
    cdsEtiquetas: TUniClientDataSet;
    FComponenteFoco: TWinControl;
    function fQuantidadeDeVolumes: Integer;
    function fDigitouQuantidadeDeVolumes: Boolean;
    function fConfirmar(pgbProgresso: TcxProgressBar = nil): Boolean;
    procedure pCriaClientEtiquetas;
    function fVerificaDocExiste: Boolean;
    procedure pLimpar(const blnLimarEdtChave: Boolean=True);
    procedure pProcessaClientDataSet(qryEtique: TUniQuery; intQtdVol: Integer; blnSepExclusiva: Boolean = False);
    function fImpEtiquetasLaserArgox(strImprimeEtiquetaVolumeComposto: String = ''; blnSepExclusiva: Boolean = False; cdsDespachoPorAmbiente: TUniClientdataset = nil): Boolean;
    function fImpEtiquetasMatricial(blnSepExclusiva: Boolean = False): Boolean;
    procedure pImpRegistro(var strErro: string);
    procedure pImpArrLinhasEti;
    function fNomeTabela: String;
    function fIncluiAtualizaVolumesCorreios(pgbProgresso: TcxProgressBar): Boolean;
    procedure pDisableEdit(edt: TEditFocus);
    function fGetCodigoDaTransportadora : String;
    function fGetDataDocumento : String;
    function fGetIntegrarComMandae : Boolean;
    function fGetIntegrarComJadlog : Boolean;
    function fGetIntegrarComIntelipost : Boolean;
    function fClienteInformadoEhDoDocumento: Boolean;
    function fEhTransportadoraMercadoLivre(strNumDoc, strEspDoc, strCodEmp, strCodCli: string): Boolean;
    function fEhTransportadoraMagalu(strNumDoc, strEspDoc, strCodEmp, strCodCli: string): Boolean;
    function fEhTransportadoraShopee(strNumDoc, strEspDoc, strCodEmp, strCodCli: string): Boolean;
    function fEhTransportadoraViaVarejo(strNumDoc, strEspDoc, strCodEmp, strCodCli: string): Boolean;
    function fEhTransportadoraOlist(strNumDoc, strEspDoc, strCodEmp, strCodCli: string): Boolean;
    function fEhTransportadoraAmazon(strNumDoc, strEspDoc, strCodEmp, strCodCli: string): Boolean;
    function fEhTransportadoraTikTok(strNumDoc, strEspDoc, strCodEmp, strCodCli: string): Boolean;
    function fGetEtiDesTransportadoraDoc(strNumDoc, strEspDoc, strCodEmp, strCodCli: string): string;
    function fValidaClienteParaEtiqueta: Boolean;

    function fImpEtiquetasDespachoProdutoArgox: Boolean;
    function fImpEtiquetasMontagemCaixaPackList: Boolean;
    function fImpEtiquetasMontagemCaixaCodBarras: Boolean;
    function fSelecaoTipoDeImpressao: string;
    function fTemRegistroSelecionado: boolean;
    procedure pBuscaItensDasCaixasSelecionadas(
      cdsSelecaoCaixas: TUniClientDataSet);
    procedure pEtiquetaGerado;

    procedure pChaveAcessoToDocumento(AChaAce : String;
      blnPesquisarPorEdtChave: Boolean=False);
    procedure pValidaImpressaoAutomatica;
    function fEtiquetaDeDespachoDiferenteParaFaturamentoDePedido: boolean;
    function fValidaModeloEtiquetaDespacho: boolean;
    function fBuscaPorCodCliente: Boolean;
    procedure pCarregaVolumesSepExclusiva(Const strTabPri: String; Const strTabAux: String = '');
    function fImprimeEtiquetaDespachoOuVolumeComposto: Boolean;

    function fRetAutIncDet(strNumDoc, strEspDoc, strCodEmp: String) : String;
    function fTotCaixaSelec: Integer;
    procedure pExibeFrmExpDigVolumesCompostos();
    procedure pRetCdsAmbientes(strNumDoc, strEspDoc, strCodEmp, strQtdVol: String;
      var blnImprimir: Boolean; cdsDespachoAmbiente: TUniClientdataset);
    function fRetornaCodCliente(out strCodCli: String): Boolean;

    Const
      TIPO_ETIQUETA_MONTAGEM_COD_BARRAS: String = '165';
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    cpuCampos: TCamposUso;
    intColAtu: Integer;
    blnImpEti: Boolean;
    strCodCli: String;
    strVolume: String;
    blnUSigep: Boolean;
    strEspPLP: String;
    strSerCor: String;
    blnExpedi: Boolean;
    strCfgTipEti: String;
    strNomFil: string;
    blnImpAut: Boolean;
    blnApenasGerarEtiqueta: Boolean;
    strPathEtiqueta: String;
    strMarketplaceEtiqueta: String;
    strRetornoEnvioNFeMarketplace: String;
    intMarketplaceTimeout: Integer;
    {*****************************************}
    {* MATRIZ QUE REPRESENTARÁ 1 LINHA DE    *}
    {* ETIQUETAS. Ex: EM UMA IMPRESSÃO DE 2  *}
    {* COLUNAS, A MATRIZ CONTERÁ 2 ETIQUETAS *}
    {**************************************MV*}
    arrLinhasEti: Array Of String;
    blnImprimindoEtiquetas : Boolean;
    strBotaoAcionado: string;
    strMultPed: String;
    blnExibeTelaDigVolumesCompostos: Boolean;
    blnImprimiu: Boolean;
    tpeResultadoUnificacao: TResultadoEtiquetaUnificada;

    procedure pOnShow;

    function fCarregaVolume: String;
    function fValidarTodosCampos: Boolean;
  end;

var
  frmImpEtiDespacho: TfrmImpEtiDespacho;

implementation

uses StrUtils, untCadConfRelatorios, untFuncoesConsulta,
     untFuncMacro, untCfgRel, untFuncoesRel, untSIGEPWebFuncoes,
     Mandae.Classes, untWS_SkyHub, untModulo, untJadlog, untMarketPlace,
     untImpEtiDespachoSelecaoCaixas, untMontagemCaixas,
     untExpDigVolumesCompostos, untImpEtiDespachoPorAmbiente,
     untCorreiosMain, untIntelipost.ShipmentOrder, untIntelipost.ShipmentOrder.GetLabel,
     untMsgGridGenerica;

{$R *.dfm}

procedure TfrmImpEtiDespacho.pRetCdsAmbientes(strNumDoc, strEspDoc,
  strCodEmp, strQtdVol: String; var blnImprimir: Boolean; cdsDespachoAmbiente: TUniClientdataset);
Var
  qryAmbiente : TUniQuery;
begin
  qryAmbiente := fCriaQuery;
  blnImprimir := False;
  Try
    qryAmbiente.Close;
    qryAmbiente.SQL.Clear;

    If Pos(strEspDoc, 'PD_OR_') > 0 Then
    Begin
      qryAmbiente.SQL.Add(' SELECT FD.FDO_COMPLE AS COMPLE');
      qryAmbiente.SQL.Add(' FROM FATDOR FD ');
      qryAmbiente.SQL.Add(' LEFT JOIN FATGOR F ON F.AUTOINCREM = FD.FDO_SEQGER ');
      qryAmbiente.SQL.Add(' WHERE FDO_NUMDOC = :NUMDOC ');
      qryAmbiente.SQL.Add('   AND FDO_ESPDOC = :ESPDOC ');
      qryAmbiente.SQL.Add('   AND FDO_CODEMP = :CODEMP ');
      qryAmbiente.SQL.Add(' GROUP BY FD.FDO_COMPLE     ');
    End
    Else If Pos(edtEspDoc.Text, 'NF_EL_IF_IV_D1_MI_FF_TE_TR_BR_UC') > 0 Then
    Begin
      qryAmbiente.SQL.Add(' SELECT MT.DET_COMPLE AS COMPLE');
      qryAmbiente.SQL.Add('   FROM MOVDET MD ');
      qryAmbiente.SQL.Add(' LEFT JOIN MOVTRI MT ON MT.DET_SEQGER = MD.AUTOINCREM ');
      qryAmbiente.SQL.Add(' WHERE MD.DET_NUMDOC = :NUMDOC ');
      qryAmbiente.SQL.Add('   AND MD.DET_ESPDOC = :ESPDOC ');
      qryAmbiente.SQL.Add('   AND MD.DET_CODEMP = :CODEMP ');
      qryAmbiente.SQL.Add('   AND MD.DET_ORIDOC = "V"     ');
      qryAmbiente.SQL.Add('   AND MD.DET_TIP_FC = "C"     ');
      qryAmbiente.SQL.Add(' GROUP BY MT.DET_COMPLE     ');
    End;

    qryAmbiente.ParamByName('NUMDOC').asString := strNumDoc;
    qryAmbiente.ParamByName('ESPDOC').asString := strEspDoc;
    qryAmbiente.ParamByName('CODEMP').asString := strCodEmp;

    qryAmbiente.Open;

    pCriarFormularios(TfrmEtiDespachoPorAmbiente, frmEtiDespachoPorAmbiente);
    frmEtiDespachoPorAmbiente.pnlInfo.Caption := 'Total de volumes informados: ' + strQtdVol;
    frmEtiDespachoPorAmbiente.strQtdVol := strQtdVol;
    try
      frmEtiDespachoPorAmbiente.cdsDespachoAmbiente.CreateDataset;
      While Not qryAmbiente.Eof Do
      Begin
        frmEtiDespachoPorAmbiente.cdsDespachoAmbiente.Insert;
        frmEtiDespachoPorAmbiente.cdsDespachoAmbiente.FieldByName('AMBIENTE').asString := qryAmbiente.FieldByName('COMPLE').asString;
        frmEtiDespachoPorAmbiente.cdsDespachoAmbiente.FieldByName('VOLUME').asInteger := 1;
        frmEtiDespachoPorAmbiente.cdsDespachoAmbiente.Post;
        qryAmbiente.Next;
      End;
      frmEtiDespachoPorAmbiente.cdsDespachoAmbiente.First;
      frmEtiDespachoPorAmbiente.ShowModal;
      blnImprimir := frmEtiDespachoPorAmbiente.blnImprimir;
      cdsDespachoAmbiente.Data:=frmEtiDespachoPorAmbiente.cdsDespachoAmbiente.Data;
    finally
      FreeAndNil(frmEtiDespachoPorAmbiente);
    end;

  Finally
    FreeAndNil(qryAmbiente);
  End;

end;

function TfrmImpEtiDespacho.fRetAutIncDet(strNumDoc, strEspDoc,
  strCodEmp: String): String;
Var
  qryAutInc : TUniQuery;
begin
  Result := '';
  qryAutInc := fCriaQuery;
  Try
    qryAutInc.Close;
    qryAutInc.SQL.Clear;

    If Pos(strEspDoc, 'PD_OR_') > 0 Then
    Begin
      qryAutInc.SQL.Add(' SELECT FD.AUTOINCREM AS AUTOINC');
      qryAutInc.SQL.Add(' FROM FATDOR FD ');
      qryAutInc.SQL.Add(' LEFT JOIN FATGOR F ON F.AUTOINCREM = FD.FDO_SEQGER ');
      qryAutInc.SQL.Add(' WHERE FDO_NUMDOC = :NUMDOC ');
      qryAutInc.SQL.Add('   AND FDO_ESPDOC = :ESPDOC ');
      qryAutInc.SQL.Add('   AND FDO_CODEMP = :CODEMP ');
    End
    Else If Pos(edtEspDoc.Text, 'NF_EL_IF_IV_D1_MI_FF_TE_TR_BR_UC') > 0 Then
    Begin
      qryAutInc.SQL.Add(' SELECT AUTOINCREM AS AUTOINC');
      qryAutInc.SQL.Add('   FROM MOVDET ');
      qryAutInc.SQL.Add(' WHERE DET_NUMDOC = :NUMDOC ');
      qryAutInc.SQL.Add('   AND DET_ESPDOC = :ESPDOC ');
      qryAutInc.SQL.Add('   AND DET_CODEMP = :CODEMP ');
      qryAutInc.SQL.Add('   AND DET_ORIDOC = "V"     ');
      qryAutInc.SQL.Add('   AND DET_TIP_FC = "C"     ');
    End;

    qryAutInc.ParamByName('NUMDOC').asString := strNumDoc;
    qryAutInc.ParamByName('ESPDOC').asString := strEspDoc;
    qryAutInc.ParamByName('CODEMP').asString := strCodEmp;

    qryAutInc.Open;

    qryAutInc.First;
    While Not qryAutInc.Eof Do
    Begin
      Result := Result + IIF(Result.IsEmpty,'',', ') + '"' + qryAutInc.FieldByName('AUTOINC').AsString + '"';

      qryAutInc.Next;
    End;
  Finally
    FreeAndNil(qryAutInc);
  End;
end;

function TfrmImpEtiDespacho.fSelecaoTipoDeImpressao: string;
var
  ArrNomEti : TStringArray;
  intTipoEtiqDesp : integer;
begin
  result := fCfgSis('ETIDES');
  If (result='S') Then
  Begin
    SetLength(ArrNomEti, 0);
    pAddDados(ArrNomEti, 'Matricial');
    pAddDados(ArrNomEti, 'Laser');
    pAddDados(ArrNomEti, 'Argox');
    intTipoEtiqDesp := fGetMenu('Escolha o Modelo:', ArrNomEti, 1, True);
    Case intTipoEtiqDesp Of
      1: result := 'M';
      2: result := 'L';
      3: result := 'A';
    Else
      Exit;
    End;
  end;
end;

function TfrmImpEtiDespacho.fQuantidadeDeVolumes: Integer;
begin
  Result := 0;

  If (Not fDigitouQuantidadeDeVolumes) Then
    Exit;

  Result := StrToIntDef(edtQtdVol.Text, 0);
end;

function TfrmImpEtiDespacho.fDigitouQuantidadeDeVolumes: Boolean;
begin
  Result := False;

  If (Not pnlDocumento.Visible) Then
    Exit;

  If (Not pnlDocumento.Enabled) Then
    Exit;

  If (Not edtQtdVol.Visible) Then
    Exit;

  If (Not edtQtdVol.Enabled) Then
    Exit;

  If (fEmptyStr(edtQtdVol.Text)) Then
    Exit;

  If (edtQtdVol.Text = '0') Then
    Exit;

  Result := True;
end;

function TfrmImpEtiDespacho.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  var
    LObjMandaeRepositorio : TMandaeRepositorio;
    LintVolumes : Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin

      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar o Número do Documento!', ['&Ok']);
        Result := False;
      End;

      If (Length(edtNumDoc.Text) < 12) Then
        edtNumDoc.Text := fStrZero(edtNumDoc.Text, 12);

      If (Length(edtNumDoc.Text) > 12) Then
      Begin
        pChaveAcessoToDocumento(edtNumDoc.Text);
        Exit;
      End;

      If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtCodEmp.Text)) And (edtEspDoc.Text = 'NF') And (fValidaClienteParaEtiqueta) Then
      Begin
        If (fEhTransportadoraMercadoLivre(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
        Begin
          If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_MERCADO_LIVRE) Then
            Result := False;
        End

        Else If (fEhTransportadoraMagalu(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
        Begin
          If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_MAGALU) Then
            Result := False;
        End

        Else If (fEhTransportadoraShopee(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
        Begin
          If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_SHOPEE) Then
            Result := False;
        End

        Else If (fEhTransportadoraViaVarejo(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
        Begin
          If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_VIAVAREJO) Then
            Result := False;
        End

        Else If (fEhTransportadoraOlist(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
        Begin
          If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_OLIST) Then
            Result := False;
        End

        Else If (fEhTransportadoraTikTok(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
        Begin
          If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_TIKTOK) Then
            Result := False;
        End

        Else If (fEhTransportadoraAmazon(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
        Begin
          If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_AMAZON) Then
            Result := False;
        End;

      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin

      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar a Espécie do Documento!', ['&Ok']);
        Result := False;
      End
      Else If fEmptyStr(fNomeTabela) Then
      Begin
        fMensagem('ATENÇÃO!', 'Espécie do Documento inválida!', ['&Ok']);
        Result := False;
      End
      Else If Not fVerificaDocExiste Then
      Begin
        fMensagem('ATENÇÃO!', 'Documento não encontrado!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        edtQtdVol.Text := fCarregaVolume;
        If StrToFloat(edtQtdVol.Text) > 0 Then
          edtQtdVol.Enabled := (Not fUsaJadLog(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text));
      End;

      if fBuscaPorCodCliente then
      begin
        if not fClienteInformadoEhDoDocumento then
        Begin
          fMensagem('ATENÇÃO!', 'Cliente informado não é desse documento!', ['&Ok']);
          Result := False;
        End;
      end;

      If Not fEmptyStr(edtNumDoc.Text) And Not fEmptyStr(edtEspDoc.Text) Then
        pValidaImpressaoAutomatica;

    End

    Else If (Sender = edtQtdVol) Then
    Begin
      If fEmptyStr(edtQtdVol.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar a Quantidade de Volumes!', ['&Ok']);
        Result := False;
      End;

      if fGetIntegrarComMandae then
      begin
        if not fEmptyStr(edtNumDoc.Text) and not fEmptyStr(edtCodEmp.Text) and not fEmptyStr(edtEspDoc.Text) then
        Begin
          LObjMandaeRepositorio := TMandaeRepositorio.Create;
          Try
            LintVolumes := LObjMandaeRepositorio.fNumeroDeVolumesIntegradoComMandae(edtNumDoc.Text,
                                                                                    edtEspDoc.Text,
                                                                                    edtCodEmp.Text);
            if (LintVolumes <> 0) and (LintVolumes <> StrToInt(edtQtdVol.Text)) then
            begin
              fMensagem('ATENÇÃO!', 'Este documento já teve etiqueta impressa com uma quantidade de volume '+
              'diferente da informada. O volume correto a ser informado é "'+IntToStr(LintVolumes)+'".', ['&Ok']);
              Result := False;
            end;

          Finally
            FreeAndNil(LObjMandaeRepositorio);
          End;
        End;
      end;

      If pnlVolumeSepExc.Visible Then
      Begin
        edtQtdVolSepNExc.Text := FloatToStrF(fStrToFloat(edtQtdVol.Text) - fStrToFloat(edtQtdVolSepExc.Text), ffFixed, 12, 0);

        If fStrToFloat(edtQtdVolSepNExc.Text) < 0.0 Then
        Begin
          pMensagemOk('O campo "Volume dos itens de Separação não Exclusiva" não pode ficar negativo. '+
            'Ajuste o Volume para poder continuar (ele deve ser maior ou igual ao volume dos itens '+
            'de separação exclusiva) ou revise as configurações de cálculo de volume, pois o volume '+
            'dos itens de separação exclusiva devem seguir as configurações de cálculo de volume do Sistema.');
          Result := False;
        End;

        If fStrToFloat(edtQtdVol.Text) <> (fStrToFloat(edtQtdVolSepExc.Text) + fStrToFloat(edtQtdVolSepNExc.Text)) Then
        Begin
          pMensagemOk('O Volume deve ser igual à soma dos campos "Volume dos itens de Separação Exclusiva" e '+
            '"Volume dos itens de Separação Não Exclusiva". Realize o ajuste do campo do volume para poder continuar.');
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtEtqInicial) Then
    Begin
      if fEmptyStr(edtEtqInicial.Text) then
      begin
        fMensagem('ATENÇÃO!', 'É necessário informar a Etiqueta Inicial!', ['&Ok']);
        Result := False;
      end

      else if StrToIntDef(edtEtqInicial.Text, 0) > StrToIntDef(edtQtdVol.Text, 0) then
      Begin
        fMensagem('ATENÇÃO!', 'A etiqueta inicial deve ser menor ou igual a Quantidade de Volume!', ['&Ok']);
        Result := False;
      End

      else if StrToIntDef(edtEtqInicial.Text, 0) = 0 then
      begin
        fMensagem('ATENÇÃO!', 'A etiqueta inicial deve ser maior que zero!', ['&Ok']);
        Result := False;
      end;
    End
   {*****************************************}
   {* VALIDA O CÓDIGO DA EMPRESA            *}
   {**************************************MV*}
    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) And Not blnApenasGerarEtiqueta Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
      End;
    end
    else if (Sender = edtCodCli) and fBuscaPorCodCliente then
    begin

      if fEmptyStr(edtCodCli.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O código do cliente deve ser preenchido!', ['&O k']);
        Result := False;
      end

      else

      begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        if fEmptyStr(edtNomCli.Text) And (Not fEmptyStr(edtCodCli.Text))  then
        begin
          fMensagem('AVISO','Código do cliente não encontrado.', ['&O K']);
          edtCodCli.Clear;
          pSetFocus(edtCodCli);
        end;
      end;

    end
    else if (Sender = edtChave) then
    begin
      if not fEmptyStr(edtChave.Text) then
      begin
        pChaveAcessoToDocumento(edtChave.Text, True);
        if fEmptyStr(edtNumDoc.Text) then
        begin
          fMensagem('AVISO','Chave de Acesso da NFe não encontrada.', ['&O K']);
          edtChave.Clear;
          Result := False;
        end;

        If Result Then
        Begin
          If pnlCliente.Visible Then
            pnlCliente.Enabled := False;

          If pnlDocumento.Visible Then
          Begin
            edtNumDoc.Enabled     := False;
            edtEspDoc.Enabled     := False;
            edtEtqInicial.Enabled := False;
          End;

          If pnlVolumeSepExc.Visible Then
            pnlVolumeSepExc.Enabled := False;

          FComponenteFoco := edtChave;
        End;
      end
      Else
      Begin
        If pnlCliente.Visible Then
          pnlCliente.Enabled := True;

        If pnlDocumento.Visible Then
        Begin
          edtNumDoc.Enabled     := True;
          edtEspDoc.Enabled     := True;
          edtEtqInicial.Enabled := True;
        End;

        If pnlVolumeSepExc.Visible Then
          pnlVolumeSepExc.Enabled := True;

        FComponenteFoco := rdgTpDestinatario;
      End;
    end;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmImpEtiDespacho.fValidaClienteParaEtiqueta: Boolean;
begin
  Result := True;

  if (fCfgSis('CLETDS', varBoolean)) and (fEmptyStr(edtCodCli.Text)) then
    Result := False;
end;

function TfrmImpEtiDespacho.fValidarTodosCampos: Boolean;
begin
  Result := fVerificaCampos;
end;

procedure TfrmImpEtiDespacho.btnConfigurarClick(Sender: TObject);
begin
  inherited;

  If (Not fVerificaAcessoSistema('frmCadConfRelatorios', strLoginUsuarioLogado)) Then
  Begin
    pMensagemOk('Usuário sem direito de acesso a esta opção!');
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);
    frmCadConfRelatorios.strNomeForm   := Self.Name;
    frmCadConfRelatorios.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmImpEtiDespacho.btnConfigurarClick]');
    End;
  End;

  pFreeAndNil(frmCadConfRelatorios);

end;

procedure TfrmImpEtiDespacho.btnConfirmaClick(Sender: TObject);
begin
  blnImprimindoEtiquetas := True;
  Try
    fChamaTelaGravando(fConfirmar, 'Aguarde, Imprimindo Etiqueta(s) ...');
  Finally
    blnImprimindoEtiquetas := False;
  End;
end;

function TfrmImpEtiDespacho.fConfirmar(pgbProgresso: TcxProgressBar = nil): Boolean;
var
  LObjMandaeBuilder : TMandaeBuilder;
  LMensagem         : String;
  WS_SkyHub         : TWS_SkyHub;
  Pedido            : untWS_SkyHub.TDocumento;
  strMsgErroMarketPlace : string;
  qryFgoCai : TUniQuery;

  frmImpEtiDespachoSelecaoCaixas: TfrmImpEtiDespachoSelecaoCaixas;

  LErroGerarPLP : String;
  strAmbEti : String;
  blnImprimeEtiqAmbiente: Boolean;
  cdsDespachoAmbiente: TUniClientDataSet;
begin

  inherited;

  Result := False;
  blnImprimiu := False;
  tpeResultadoUnificacao := reuNaoAplicavel;
  pInfoStatusGravacao(pgbProgresso, 'Aguarde, Validando Documento ...');
  strAmbEti := fCfgSis('AMBETI');

  if fImprimeEtiquetaDespachoOuVolumeComposto then
  begin

    If fVerificaCampos Then
    Begin
      intColAtu := 1;

      if blnExibeTelaDigVolumesCompostos then
        pExibeFrmExpDigVolumesCompostos();

      if fGetIntegrarComMandae then
      begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde, Gerando Etiqueta(s) MANDAE ...');

        LObjMandaeBuilder := TMandaeBuilder.Create;

        Try
            LObjMandaeBuilder.strNumeroDocumento  := edtNumDoc.Text;
            LObjMandaeBuilder.strEspecieDocumento := edtEspDoc.Text;
            LObjMandaeBuilder.strCodigoEmpresa    := edtCodEmp.Text;
            LObjMandaeBuilder.intNumeroVolumes    := StrToInt(edtQtdVol.Text);
            LObjMandaeBuilder.dtaDocumento        := StrToDateTime(fGetDataDocumento);

            if not LObjMandaeBuilder.fGerarEtiquetas(LMensagem) then
            Begin
              fMensagem('ATENÇÃO!', LMensagem, ['&O k']);
              Exit;
            End;

          Finally
            FreeAndNil(LObjMandaeBuilder);
          End;

        end
      Else If blnUSigep Then
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde, Gerando Etiqueta(s) CORREIOS ...');

        If not fIncluiAtualizaVolumesCorreios(pgbProgresso) Then
          Exit;
      End
      Else If (fUtilizaRotinaDeImpressaoDeEtiquetaDeDespachoB2WEntrega And fTransportadoraRealizaColetaB2WEntrega(fGetCodigoDaTransportadora)) Then
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde, Gerando Etiqueta(s) B2W ...');

        {Verifica se pedido já foi faturado}
          If (fNomeTabela = 'FATGOR') Then
          Begin

            If Not TWS_SkyHub.PedidoJahFaturado(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text) Then
            Begin
              fMensagem('ATENÇÃO!', 'Para gerar etiquetas de despacho B2W Entrega (Direct), é necessário faturar o pedido antes da impressão!', ['&Ok']);
              Exit;
            End;

            Pedido.strNumDoc := edtNumDoc.Text;
            Pedido.strEspDoc := edtEspDoc.Text;
            Pedido.strCodEmp := edtCodEmp.Text;

          End;

          {Identifica pedido de origem do documento de venda}
          If (fNomeTabela = 'MOVGER') Then
          Begin

            Pedido := RetornaPedidoDocumentoVenda(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text);
            If fEmptyStr(Pedido.strNumDoc) Then
            Begin
              fMensagem('ATENÇÃO!', 'Para gerar etiquetas de despacho B2W Entrega (Direct), é necessário que o documento seja de origem de um pedido de venda!', ['&Ok']);
              Exit;
            End;

          End;

          {Gerar PLP B2W}
          WS_SkyHub := TWS_SkyHub.Create(Pedido.strNumDoc, Pedido.strEspDoc, Pedido.strCodEmp);

          Try

            Try
              If Not WS_SkyHub.GerarPLP(LErroGerarPLP) Then
              Begin
                fMensagem('ATENÇÃO!', 'Não foi possível gerar a PLP B2W Entrega (Direct)!' + #13 + #13 + 'Retorno: ' + LErroGerarPLP, ['&Ok']);
                Exit;
              End;
            Except
              On E: Exception Do
              Begin
                fMensagem('ATENÇÃO!', 'Não foi possível gerar a PLP B2W Entrega (Direct)!' + #13 + 'Erro: ' + E.Message, ['&Ok']);
                Exit;
              End;
            End;

          Finally
            FreeAndNil(WS_SkyHub);
          End;

      End
      Else If (edtEspDoc.Text = 'NF') and (fEhTransportadoraMercadoLivre(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde, Gerando Etiqueta(s) MERCADO LIVRE ...');

        If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_MERCADO_LIVRE) Then
          Exit;

        strMsgErroMarketPlace := EmptyStr;
        if not fRetornaEtiquetMarketplaceZPL(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_MERCADO_LIVRE, strMsgErroMarketPlace, strPathEtiqueta, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace, blnApenasGerarEtiqueta, tpeResultadoUnificacao, intMarketplaceTimeout) then
        begin
          strMsgErroMarketPlace := 'Não foi possível gerar a etiqueta do Mercado Livre.' + sLineBreak + strMsgErroMarketPlace;
          fMensagem('ATENÇÃO!', strMsgErroMarketPlace, ['&Ok']);
        end
        else
        begin
          if blnExpedi then
            Self.Close
          else
            pLimpar;
        end;

        Exit;
      End
      Else If (edtEspDoc.Text = 'NF') and (fEhTransportadoraMagalu(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde, Gerando Etiqueta(s) MAGALU ...');

        If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_MAGALU) Then
          Exit;

        strMsgErroMarketPlace := EmptyStr;
        if not fRetornaEtiquetMarketplaceZPL(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_MAGALU, strMsgErroMarketPlace, strPathEtiqueta, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace, blnApenasGerarEtiqueta, tpeResultadoUnificacao, intMarketplaceTimeout) then
        begin
          strMsgErroMarketPlace := 'Não foi possível gerar a etiqueta do Magazine Luiza.' + sLineBreak + strMsgErroMarketPlace;
          fMensagem('ATENÇÃO!', strMsgErroMarketPlace, ['&Ok']);
        end
        else
        begin
          if blnExpedi then
            Self.Close
          else
            pLimpar;
        end;

        Exit;
      End
      Else If (edtEspDoc.Text = 'NF') and (fEhTransportadoraShopee(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde, Gerando Etiqueta(s) SHOPEE ...');

        If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_SHOPEE) Then
          Exit;

        strMsgErroMarketPlace := EmptyStr;
        if not fRetornaEtiquetMarketplaceZPL(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_SHOPEE, strMsgErroMarketPlace, strPathEtiqueta, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace, blnApenasGerarEtiqueta, tpeResultadoUnificacao, intMarketplaceTimeout) then
        begin
          strMsgErroMarketPlace := 'Não foi possível gerar a etiqueta do Shopee.' + sLineBreak + strMsgErroMarketPlace;
          fMensagem('ATENÇÃO!', strMsgErroMarketPlace, ['&Ok']);
        end
        else
        begin
          if blnExpedi then
            Self.Close
          else
            pLimpar;
        end;

        Exit;
      End
      Else If (edtEspDoc.Text = 'NF') and (fEhTransportadoraTikTok(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde, Gerando Etiqueta(s) TIK TOK SHOP ...');

        If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_TIKTOK) Then
          Exit;

        strMsgErroMarketPlace := EmptyStr;
        if not fRetornaEtiquetMarketplaceZPL(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_TIKTOK, strMsgErroMarketPlace, strPathEtiqueta, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace, blnApenasGerarEtiqueta, tpeResultadoUnificacao, intMarketplaceTimeout) then
        begin
          strMsgErroMarketPlace := 'Não foi possível gerar a etiqueta do Tik Tok Shop.' + sLineBreak + strMsgErroMarketPlace;
          fMensagem('ATENÇÃO!', strMsgErroMarketPlace, ['&Ok']);
        end
        else
        begin
          if blnExpedi then
            Self.Close
          else
            pLimpar;
        end;

        Exit;
      End
      Else If (edtEspDoc.Text = 'NF') and (fEhTransportadoraViaVarejo(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde, Gerando Etiqueta(s) Via Varejo ...');

        If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_VIAVAREJO) Then
          Exit;

        strMsgErroMarketPlace := EmptyStr;
        if not fRetornaEtiquetMarketplaceZPL(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_VIAVAREJO, strMsgErroMarketPlace, strPathEtiqueta, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace, blnApenasGerarEtiqueta, tpeResultadoUnificacao, intMarketplaceTimeout) then
        begin
          strMsgErroMarketPlace := 'Não foi possível gerar a etiqueta do Via Varejo.' + sLineBreak + strMsgErroMarketPlace;
          fMensagem('ATENÇÃO!', strMsgErroMarketPlace, ['&Ok']);
        end
        else
        begin
          if blnExpedi then
            Self.Close
          else
            pLimpar;
        end;

        Exit;
      End
      Else If (edtEspDoc.Text = 'NF') and (fEhTransportadoraOlist(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde, Gerando Etiqueta(s) Olist ...');

        If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_OLIST) Then
          Exit;

        strMsgErroMarketPlace := EmptyStr;
        if not fRetornaEtiquetMarketplaceZPL(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_OLIST, strMsgErroMarketPlace, strPathEtiqueta, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace, blnApenasGerarEtiqueta, tpeResultadoUnificacao, intMarketplaceTimeout) then
        begin
          strMsgErroMarketPlace := 'Não foi possível gerar a etiqueta do Olist.' + sLineBreak + strMsgErroMarketPlace;
          fMensagem('ATENÇÃO!', strMsgErroMarketPlace, ['&Ok']);
        end
        else
        begin
          if blnExpedi then
            Self.Close
          else
            pLimpar;
        end;

        Exit;
      End
      Else If (edtEspDoc.Text = 'NF') and (fEhTransportadoraAmazon(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde, Gerando Etiqueta(s) Amazon ...');

        If Not fValidaNotaMarketPlace(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_AMAZON) Then
          Exit;

        strMsgErroMarketPlace := EmptyStr;
        if not fRetornaEtiquetMarketplaceZPL(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, PREFIX_AMAZON, strMsgErroMarketPlace, strPathEtiqueta, strMarketplaceEtiqueta, strRetornoEnvioNFeMarketplace, blnApenasGerarEtiqueta, tpeResultadoUnificacao, intMarketplaceTimeout) then
        begin
          strMsgErroMarketPlace := 'Não foi possível gerar a etiqueta da Amazon.' + sLineBreak + strMsgErroMarketPlace;
          fMensagem('ATENÇÃO!', strMsgErroMarketPlace, ['&Ok']);
        end
        else
        begin
          if blnExpedi then
            Self.Close
          else
            pLimpar;
        end;

        Exit;
      End
      Else If (edtEspDoc.Text = 'NF') and (fUsaJadLog(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text)) Then
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde, Gerando Etiqueta(s) JADLOG ...');

        if not fGerouEtiqueta(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text) then
        begin
          if not fEnviaPedidoJadlog(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, fQuantidadeDeVolumes) then
          begin
            if blnExpedi then
              Self.Close;
            Exit;
          end;
        end;
      End
      Else If fGetIntegrarComIntelipost Then
      Begin
        If Pos(edtEspDoc.Text, 'NF_FF_IF_') > 0 Then
        Begin
          Pedido := RetornaPedidoDocumentoVenda(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text);
          If TWS_SkyHub.PedidoJahFaturado(Pedido.strNumDoc, Pedido.strEspDoc, Pedido.strCodEmp) Then
          Begin
            pInfoStatusGravacao(pgbProgresso, 'Aguarde, Gerando Etiqueta(s) INTELIPOST ...');
            Result := TIntelipostShipmentOrderGetLabel.fImprimeEstiquetaIntelipost(Pedido.strNumDoc,
                                                                                   Pedido.strEspDoc,
                                                                                   Pedido.strCodEmp,
                                                                                   StrToInt(edtEtqInicial.Text));
          End;
        End;

        if blnExpedi then
          Self.Close;

        Exit;
      End;

      If blnApenasGerarEtiqueta Then
        Exit;

      cdsDespachoAmbiente := TUniClientDataset.Create(Self);

      if (strAmbEti='S') then
      begin
        pRetCdsAmbientes(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtQtdVol.Text, blnImprimeEtiqAmbiente, cdsDespachoAmbiente);
        if not blnImprimeEtiqAmbiente then
          Abort;
      end;

      pInfoStatusGravacao(pgbProgresso, 'Aguarde, Imprimindo Etiqueta(s) ...');

      strCfgTipEti := fSelecaoTipoDeImpressao;

      If Pos(strCfgTipEti, 'LA') > 0 Then
      Begin
        If rdgTipoEtiq.ItemIndex = 2 Then
        Begin
          if (fCfgSis('ETCPIN') = 'N') then
            blnImprimiu := fImpEtiquetasLaserArgox('G');

          If (blnImprimiu) or (fCfgSis('ETCPIN') = 'S') Then
            blnImprimiu := fImpEtiquetasLaserArgox('I');
        End
        Else
        Begin
          If pnlVolumeSepExc.Visible Then
            blnImprimiu := fImpEtiquetasLaserArgox('', False) And
                           fImpEtiquetasLaserArgox('', True)
          Else
          begin
            if blnImprimeEtiqAmbiente then
              blnImprimiu := fImpEtiquetasLaserArgox('', False, cdsDespachoAmbiente)
            else
              blnImprimiu := fImpEtiquetasLaserArgox();
          end;
        End;
      End
      Else If Pos(strCfgTipEti, 'M') > 0 Then
      Begin
        If pnlVolumeSepExc.Visible Then
          blnImprimiu := fImpEtiquetasMatricial(False) And
                         fImpEtiquetasMatricial(True)
        Else
          blnImprimiu := fImpEtiquetasMatricial;
      End;

      if blnImprimiu and fCfgSis('IMPEIP', varBoolean) then
      begin
        if blnExpedi or (fMensagem('', 'Deseja imprimir a etiqueta de despacho por produto?', ['&Sim', '&Não']) = 1) then
          fImpEtiquetasDespachoProdutoArgox;
      end;

      if blnImprimiu then
      begin
        if blnExpedi then
          Self.Close
        else
          pLimpar;
      end;

    End;
  end
  else
  begin
    pInfoStatusGravacao(pgbProgresso, 'Aguarde, Imprimindo Etiqueta(s) ...');

    qryFgoCai := fCriaQuery;
    pCriarFormularios(TfrmImpEtiDespachoSelecaoCaixas, frmImpEtiDespachoSelecaoCaixas);
    cdsCaixas.CreateDataSet;
    cdsEtiCaixa.CreateDataSet;
    try

      qryFgoCai.Close;
      qryFgoCai.SQL.Clear;

      qryFgoCai.SQL.Add('SELECT DISTINCT                       ');
      qryFgoCai.SQL.Add('  FC.FGC_FGOINC,                      ');
      qryFgoCai.SQL.Add('  FC.FGC_CAI_ID,                      ');
      qryFgoCai.SQL.Add('  FG.FGO_DTAENT,                      ');
      qryFgoCai.SQL.Add('  FG.FGO_NUMDOC,                      ');
      qryFgoCai.SQL.Add('  FG.FGO_ESPDOC,                      ');
      qryFgoCai.SQL.Add('  FG.FGO_CODEMP,                      ');
      qryFgoCai.SQL.Add('  FC.FGC_NUMFAT,                      ');
      qryFgoCai.SQL.Add('  FC.FGC_TIPFAT,                      ');
      qryFgoCai.SQL.Add('  FC.FGC_EMPFAT,                      ');
      qryFgoCai.SQL.Add('  (SELECT                                             ');
      qryFgoCai.SQL.Add('    F1.FDO_CODVEN                                     ');
      qryFgoCai.SQL.Add('  FROM                                                ');
      qryFgoCai.SQL.Add('    FATDOR F1                                         ');
      qryFgoCai.SQL.Add('  WHERE F1.AUTOINCREM = FC.FGC_FDOINC) AS FDO_CODVEN, ');
      qryFgoCai.SQL.Add('  (SELECT                                             ');
      qryFgoCai.SQL.Add('    F2.FDO_CODVE2                                     ');
      qryFgoCai.SQL.Add('  FROM                                                ');
      qryFgoCai.SQL.Add('    FATDOR F2                                         ');
      qryFgoCai.SQL.Add('  WHERE F2.AUTOINCREM = FC.FGC_FDOINC) AS FDO_CODVE2, ');
      qryFgoCai.SQL.Add('  CL.CLI_BAIRRO,                      ');
      qryFgoCai.SQL.Add('  CL.CLI_C_E_P_,                      ');
      qryFgoCai.SQL.Add('  CL.CLI_CODCLI,                      ');
      qryFgoCai.SQL.Add('  CL.CLI_ENDERE,                      ');
      qryFgoCai.SQL.Add('  CL.CLI_ENDNUM,                      ');
      qryFgoCai.SQL.Add('  CL.CLI_ENDCOM,                      ');
      qryFgoCai.SQL.Add('  CL.CLI_CODCID,                      ');
      qryFgoCai.SQL.Add('  CL.CLI_FANSOB,                      ');
      qryFgoCai.SQL.Add('  EX.FDO_NUMCMP,                      ');
      qryFgoCai.SQL.Add('  EG.FGO_SEPEXP,                      ');
      qryFgoCai.SQL.Add('  EG.FGO_OPEEXP,                      ');
      qryFgoCai.SQL.Add('  CR.REG_DESREG,                      ');
      qryFgoCai.SQL.Add('  CT.TRA_NOMTRA,                      ');
      qryFgoCai.SQL.Add('  FC.FGC_DETINC,                      ');
      qryFgoCai.SQL.Add('  FG.FGO_PESBRU,                      ');
      qryFgoCai.SQL.Add('  EG.FGO_CODROT,                      ');
      qryFgoCai.SQL.Add('  CR.REG_CODREG,                      ');
      qryFgoCai.SQL.Add('  (SELECT                                            ');
      qryFgoCai.SQL.Add('    SUM(F3.FDO_TOTPES)                               ');
      qryFgoCai.SQL.Add('  FROM                                               ');
      qryFgoCai.SQL.Add('    FATDOR F3                                        ');
      qryFgoCai.SQL.Add('  WHERE F3.FDO_SEQGER = FG.AUTOINCREM) AS FDO_TOTPES ');

      qryFgoCai.SQL.Add('    ,IF(FG.FGO_NOMCON IS NULL OR FG.FGO_NOMCON = "",                                  ');
      qryFgoCai.SQL.Add('     IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CL.CLI_ENDERE, EC.ETC_ENDENT),   ');
      qryFgoCai.SQL.Add('     FG.FGO_ENDCON) AS ENDENT                                                         ');

      qryFgoCai.SQL.Add('    ,IF(FG.FGO_NOMCON IS NULL OR FG.FGO_NOMCON = "",                                  ');
      qryFgoCai.SQL.Add('      IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CL.CLI_C_E_P_,EC.ETC_CEPENT),   ');
      qryFgoCai.SQL.Add('      FG.FGO_CEPCON) AS CEPENT                                                        ');

      qryFgoCai.SQL.Add('    ,IF(FG.FGO_NOMCON IS NULL OR FG.FGO_NOMCON = "",                                  ');
      qryFgoCai.SQL.Add('      IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CF.CID_NOMCID,CE.CID_NOMCID),   ');
      qryFgoCai.SQL.Add('      CC.CID_NOMCID) AS CIDENT                                                        ');

      qryFgoCai.SQL.Add('    ,IF(FG.FGO_NOMCON IS NULL OR FG.FGO_NOMCON = "",                                  ');
      qryFgoCai.SQL.Add('     IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CF.CID_ESTADO,CE.CID_ESTADO),    ');
      qryFgoCai.SQL.Add('     CC.CID_ESTADO) AS ESTENT                                                         ');

      qryFgoCai.SQL.Add('    ,IF(FG.FGO_NOMCON IS NULL OR FG.FGO_NOMCON = "",                                  ');
      qryFgoCai.SQL.Add('     IF(EC.ETC_BAIENT IS NULL OR EC.ETC_BAIENT = "", CL.CLI_BAIRRO,EC.ETC_BAIENT),    ');
      qryFgoCai.SQL.Add('     FG.FGO_BAICON) AS BAIENT                                                         ');

      qryFgoCai.SQL.Add('FROM                                  ');
      qryFgoCai.SQL.Add('  FGOCAI FC                           ');
      qryFgoCai.SQL.Add('  LEFT JOIN FATGOR FG                 ');
      qryFgoCai.SQL.Add('    ON FG.AUTOINCREM = FC.FGC_FGOINC  ');
      qryFgoCai.SQL.Add('  LEFT JOIN CADCLI CL                 ');
      qryFgoCai.SQL.Add('    ON CL.CLI_CODCLI = FG.FGO_CODCLI  ');
      qryFgoCai.SQL.Add('  LEFT JOIN FATDOR FD                 ');
      qryFgoCai.SQL.Add('    ON FD.FDO_SEQGER = FG.AUTOINCREM  ');
      qryFgoCai.SQL.Add('  LEFT JOIN EXTGOR EG                 ');
      qryFgoCai.SQL.Add('    ON FG.AUTOINCREM = EG.FGO_SEQFGO  ');
      qryFgoCai.SQL.Add('  LEFT JOIN EXTDOR EX                 ');
      qryFgoCai.SQL.Add('    ON EX.FDO_SEQFDO = FD.AUTOINCREM  ');
      qryFgoCai.SQL.Add('  LEFT JOIN ENTREG ER                 ');
      qryFgoCai.SQL.Add('    ON ER.ENT_CODIGO = EG.FGO_CODROT  ');
      if fCfgSis('ROTEMP', varBoolean) then
      begin
        qryFgoCai.SQL.Add(' AND ER.ENT_CODEMP = FG.FGO_CODEMP ');
      end;
      qryFgoCai.SQL.Add('  LEFT JOIN CADREG CR                ');
      qryFgoCai.SQL.Add('    ON CR.REG_CODREG = IFNULL(ER.ENT_CODREG, CL.CLI_CODREG) ');
      qryFgoCai.SQL.Add('  LEFT JOIN CADTRA CT                ');
      qryFgoCai.SQL.Add('    ON CT.TRA_CODTRA = FG.FGO_CODTRA ');

      qryFgoCai.SQL.Add('  LEFT JOIN CADITE IT                ');
      QryFgoCai.SQL.Add('    ON IT.ITE_CODITE = FD.FDO_CODITE ');


      qryFgoCai.SQL.Add('LEFT JOIN AUXGOR AG ON FG.AUTOINCREM = AG.AUX_SEQGER    ');
      qryFgoCai.SQL.Add('LEFT JOIN ENTCLI EC ON EC.ETC_CODCLI = FG.FGO_CODCLI    ');
      qryFgoCai.SQL.Add('                   AND IF(IFNULL(AG.AUX_ENTGER, "") <> "",                       ');
      qryFgoCai.SQL.Add('                          EC.AUTOINCREM = AG.AUX_ENTGER,                         ');
      qryFgoCai.SQL.Add('                          EC.ETC_SEQIND =(SELECT                                 ');
      qryFgoCai.SQL.Add('                                           MIN(ETC_SEQIND)                       ');
      qryFgoCai.SQL.Add('                                          FROM                                   ');
      qryFgoCai.SQL.Add('                                           ENTCLI                                ');
      qryFgoCai.SQL.Add('                                          WHERE ETC_CODCLI = FG.FGO_CODCLI)) ');
      qryFgoCai.SQL.Add('LEFT JOIN CADCID CC ON CC.CID_CODCID = FG.FGO_CIDCON        ');
      qryFgoCai.SQL.Add('LEFT JOIN CADCID CE ON CE.CID_CODCID = EC.ETC_CIDENT        ');
      qryFgoCai.SQL.Add('LEFT JOIN CADCID CF ON CF.CID_CODCID = CL.CLI_CODCID        ');

      qryFgoCai.SQL.Add(' WHERE TRUE                          ');

      If fCfgSis('IMPCAI', varInteger) = '3' then
      Begin
        If Pos(edtEspDoc.Text, 'PD_OR_') > 0 Then
          qryFgoCai.SQL.Add(' AND FC.FGC_FDOINC IN('+fRetAutIncDet(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text)+')');

        If Pos(edtEspDoc.Text, 'NF_EL_IF_IV_D1_MI_FF_TE_TR_BR_UC') > 0 Then
          qryFgoCai.SQL.Add(' AND FC.FGC_DETINC IN('+fRetAutIncDet(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text)+')');

        qryFgoCai.Sql.Add(' GROUP BY FC.FGC_CAI_ID ');
      End
      Else
        qryFgoCai.SQL.Add(' AND FC.FGC_FGOINC = '+QuotedStr(fRetAutIncPedido(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text)));

      qryFgoCai.SQL.Add(' ORDER BY FC.FGC_CAI_ID;               ');
      qryFgoCai.Open;

      if Not qryFgoCai.IsEmpty then
      begin
        frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixas.DisableControls;
        frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixas.CreateDataSet;
        qryFgoCai.First;
        while not qryFgoCai.Eof do
        begin
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixas.Insert;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFGC_IMPRIM.asBoolean := False;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFGC_CAI_ID.asString := qryFgoCai.FieldByName('FGC_CAI_ID').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFGO_NUMDOC.asString := qryFgoCai.FieldByName('FGO_NUMDOC').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFGO_ESPDOC.asString := qryFgoCai.FieldByName('FGO_ESPDOC').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFGO_CODEMP.asString := qryFgoCai.FieldByName('FGO_CODEMP').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFGC_NUMFAT.asString := qryFgoCai.FieldByName('FGC_NUMFAT').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFGC_TIPFAT.asString := qryFgoCai.FieldByName('FGC_TIPFAT').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFGC_EMPFAT.asString := qryFgoCai.FieldByName('FGC_EMPFAT').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasCLI_BAIRRO.asString := qryFgoCai.FieldByName('CLI_BAIRRO').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasCLI_C_E_P_.asString := qryFgoCai.FieldByName('CLI_C_E_P_').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasCLI_CODCLI.asString := qryFgoCai.FieldByName('CLI_CODCLI').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasCLI_ENDERE.asString := qryFgoCai.FieldByName('CLI_ENDERE').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasCLI_ENDNUM.asString := qryFgoCai.FieldByName('CLI_ENDNUM').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasCLI_ENDCOM.asString := qryFgoCai.FieldByName('CLI_ENDCOM').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasCLI_CODCID.asString := qryFgoCai.FieldByName('CLI_CODCID').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasCLI_FANSOB.asString := qryFgoCai.FieldByName('CLI_FANSOB').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFDO_TOTPES.asFloat  := qryFgoCai.FieldByName('FDO_TOTPES').asFloat;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFGO_SEPEXP.asString := qryFgoCai.FieldByName('FGO_SEPEXP').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFGO_OPEEXP.asString := qryFgoCai.FieldByName('FGO_OPEEXP').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFDO_NUMCMP.asString := qryFgoCai.FieldByName('FDO_NUMCMP').asString;

          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFDO_CODVEN.asString := qryFgoCai.FieldByName('FDO_CODVEN').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFDO_CODVE2.asString := qryFgoCai.FieldByName('FDO_CODVE2').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasTRA_NOMTRA.asString := qryFgoCai.FieldByName('TRA_NOMTRA').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFGO_PESBRU.asFloat  := qryFgoCai.FieldByName('FGO_PESBRU').asFloat;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFGO_CODROT.asString := qryFgoCai.FieldByName('FGO_CODROT').asString;

          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasFGC_DETINC.asString := qryFgoCai.FieldByName('FGC_DETINC').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasREG_CODREG.asString := qryFgoCai.FieldByName('REG_CODREG').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasREG_DESREG.asString := qryFgoCai.FieldByName('REG_DESREG').asString;

          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasENDENT.asString := qryFgoCai.FieldByName('ENDENT').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasCEPENT.asString := qryFgoCai.FieldByName('CEPENT').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasCIDENT.asString := qryFgoCai.FieldByName('CIDENT').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasESTENT.asString := qryFgoCai.FieldByName('ESTENT').asString;
          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixasBAIENT.asString := qryFgoCai.FieldByName('BAIENT').asString;

          frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixas.Post;
          qryFgoCai.Next;
         end;
        frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixas.EnableControls;
        frmImpEtiDespachoSelecaoCaixas.ShowModal;
        cdsCaixas.CloneCursor(frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixas, true);
        if not fTemRegistroSelecionado then
        begin
          fMensagem('Atenção','Não foi selecionada nenhuma caixa para impressão.', ['&Ok']);
        end
        else
        begin
          if not frmImpEtiDespachoSelecaoCaixas.blnFecharComEscape then
          begin
            pBuscaItensDasCaixasSelecionadas( frmImpEtiDespachoSelecaoCaixas.cdsSelecaoCaixas );

            If fCfgSis('IMPCAI', varInteger) = '3' then
              blnImprimiu := fImpEtiquetasMontagemCaixaCodBarras
            Else
              blnImprimiu := fImpEtiquetasMontagemCaixaPackList;

          end;
        end;
      end
      else
      begin
        fMensagem('Atenção','Não existem caixas cadastradas para o documento informado.', ['&Ok']);
      end;

    finally
      cdsCaixas.Close;
      cdsEtiCaixa.Close;
      pFreeAndNil(frmImpEtiDespachoSelecaoCaixas);
    End;

    if blnImprimiu then
      Close;

  End;

  Result := blnImprimiu;
end;

procedure TfrmImpEtiDespacho.edtChaveChange(Sender: TObject);
begin
  inherited;
  pLimpar(False);
end;

procedure TfrmImpEtiDespacho.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpEtiDespacho.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
end;

procedure TfrmImpEtiDespacho.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmImpEtiDespacho.fVerificaDocExiste: Boolean;

  function fPedidoExiste: Boolean;
  begin
    Result := fCampoTabela('COUNT(*) > 0', fNomeTabela,
                          ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                          [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text]);
    If Result Then
      strTip_fc := 'C';
  end;

  function fVendaExiste(strTabela: String): Boolean;
  begin
    strTip_fc := fCampoTabela('GER_TIP_FC', strTabela,
                             ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_ORIDOC'],
                             [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, 'V']);

    Result := Not fEmptyStr(strTip_fc);
  end;

Begin
  If fNomeTabela = 'FATGOR' Then
  Begin
    Result := fPedidoExiste;
  End
  Else
  Begin
    Result := fVendaExiste(fNomeTabela);
    If Not Result Then
      Result := fVendaExiste(AnsiReplaceStr(fNomeTabela, 'MOV', 'NOT'));
  End;
End;

procedure TfrmImpEtiDespacho.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    btnConfirma.Click;
  End
  Else If Key = VK_F6 Then
  Begin
    btnConfigurar.Click;
  End;
end;

procedure TfrmImpEtiDespacho.FormShow(Sender: TObject);
begin
  inherited;
  pOnShow;
end;

procedure TfrmImpEtiDespacho.pOnShow;
var
  blnExecutarFoco: Boolean;
begin
  blnImprimiu := False;
  blnExecutarFoco := True;

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

  FComponenteFoco := edtNumDoc;

  If blnExpedi Then
  Begin
    pDisableEdit(edtNumDoc);
    pDisableEdit(edtEspDoc);
    pDisableEdit(edtCodEmp);
    pDisableEdit(edtCodCli);
    pDisableEdit(edtChave);
    edtQtdVol.Enabled := (not fUsaJadLog(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text));
    pSetFocus(edtQtdVol);
  End;

  if fCfgSis('CLETDS', varBoolean) then
  begin
    blnExecutarFoco := False;
    FComponenteFoco := rdgTpDestinatario;
    pnlCliente.visible := true;

    pSetFocus(edtChave);
    SelectNext(ActiveControl, True, True);
  end
  else
  begin
    pnlCliente.visible := false;
  end;

  If Not pnlCliente.Visible Then
    Self.Height := Self.Height - pnlCliente.Height;

  if ((fCfgSis('MONCAI', varBoolean)) and
     ((fCfgSis('IMPCAI', varInteger) = '4') or (fCfgSis('IMPCAI', varInteger) = '3'))) or
     (fCfgSis('ETIDCE', varBoolean)) then
  begin
    pnlTipoEtiq.visible := true;
    pSetFocus(edtCodCli);

    if not blnImpAut then
    begin
      rdgTipoEtiq.Buttons[1].Visible := ((fCfgSis('MONCAI', varBoolean)) and ((fCfgSis('IMPCAI', varInteger) = '4') or (fCfgSis('IMPCAI', varInteger) = '3')));
      rdgTipoEtiq.Buttons[2].Visible := (fCfgSis('ETIDCE', varBoolean));
    end;
  end
  else
  begin
    pnlTipoEtiq.visible := false;
  end;

  If Not pnlTipoEtiq.Visible Then
    Self.Height := Self.Height - pnlTipoEtiq.Height;

  chkImpAut.Checked := False;

  If Not pnlVolumeSepExc.Visible Then
    Self.Height := Self.Height - pnlVolumeSepExc.Height;

  If blnExecutarFoco Then
    pSetFocus(FComponenteFoco);
end;

procedure TfrmImpEtiDespacho.pDisableEdit(edt:TEditFocus);
Begin
  edt.ReadOnly    := True;
  edt.TabStop     := False;
  edt.Color       := $00FFDFB8;
  edt.FocusColor  := $00FFDFB8;
  edt.NormalColor := $00FFDFB8;
End;

procedure TfrmImpEtiDespacho.pBuscaItensDasCaixasSelecionadas( cdsSelecaoCaixas: TUniClientDataSet );
var
  qryItensCaixa : TUniQuery;
begin

  qryItensCaixa := fCriaQuery;

  try

    cdsSelecaoCaixas.First;
    while not cdsSelecaoCaixas.Eof do
    begin
      if cdsSelecaoCaixas.FieldByName('FGC_IMPRIM').asBoolean = true then
      begin

        qryItensCaixa.Close;
        qryItensCaixa.SQL.Clear;

        qryItensCaixa.SQL.Add('SELECT                               ');
        qryItensCaixa.SQL.Add('  FDO_NUMDOC,                        ');
        qryItensCaixa.SQL.Add('  FDO_CODITE,                        ');
        qryItensCaixa.SQL.Add('  FDO_DESCRI,                        ');
        qryItensCaixa.SQL.Add('  "" AS FDO_QTDVOL,                  ');
        qryItensCaixa.SQL.Add('  UNI_SIGUNI,                        ');
        qryItensCaixa.SQL.Add('  ITE_PESOIT,                        ');
        qryItensCaixa.SQL.Add('  ITE_CODFAB,                        ');
        qryItensCaixa.SQL.Add('  FGC_FGOINC,                        ');
        qryItensCaixa.SQL.Add('  FGC_FDOINC,                        ');
        qryItensCaixa.SQL.Add('  FGC_QUANTD,                        ');

        qryItensCaixa.SQL.Add('  FGC_CODBAR,                        ');

        qryItensCaixa.SQL.Add('  DATE_FORMAT(ENT_DTAENT, "%d/%m") AS DTAROT, ');
        qryItensCaixa.SQL.Add('  (SELECT GROUP_CONCAT(CONCAT("-", BAR_CODBAR, "-")) FROM ');
        qryItensCaixa.SQL.Add('   ITEBAR WHERE IT.ITE_CODITE = BAR_CODITE) AS CODBAR ');

        qryItensCaixa.SQL.Add('FROM                                 ');
        qryItensCaixa.SQL.Add('  FGOCAI FC                          ');
        qryItensCaixa.SQL.Add('  LEFT JOIN FATDOR FD                ');
        qryItensCaixa.SQL.Add('    ON FD.AUTOINCREM = FC.FGC_FDOINC ');
        qryItensCaixa.SQL.Add('  LEFT JOIN FATGOR FG                ');
        qryItensCaixa.SQL.Add('    ON FG.AUTOINCREM = FD.FDO_SEQGER ');
        qryItensCaixa.SQL.Add('  LEFT JOIN CADITE IT                ');
        qryItensCaixa.SQL.Add('    ON IT.ITE_CODITE = FD.FDO_CODITE ');
        qryItensCaixa.SQL.Add('  LEFT JOIN CADUNI UN                ');
        qryItensCaixa.SQL.Add('    ON UN.UNI_CODUNI = FD.FDO_UNIDAD ');

        qryItensCaixa.SQL.Add('  LEFT JOIN EXTGOR EX                ');
        qryItensCaixa.SQL.Add('    ON FG.AUTOINCREM = EX.FGO_SEQFGO ');

        qryItensCaixa.SQL.Add('  LEFT JOIN ENTREG ER                ');
        qryItensCaixa.SQL.Add('    ON ER.ENT_CODIGO = EX.FGO_CODROT ');
        if fCfgSis('ROTEMP', varBoolean) then
        begin
          qryItensCaixa.SQL.Add(' AND ER.ENT_CODEMP = FG.FGO_CODEMP ');
        end;
        qryItensCaixa.SQL.Add('  WHERE FC.FGC_CAI_ID = :CAI_ID      ');

        qryItensCaixa.ParamByName('CAI_ID').asString := cdsSelecaoCaixas.FieldByName('FGC_CAI_ID').asString;
        qryItensCaixa.Open;

        while not qryItensCaixa.Eof do
        begin
          cdsEtiCaixa.Insert;
          cdsEtiCaixaquantidade.asFloat := qryItensCaixa.FieldByName('FGC_QUANTD').AsFloat;
          cdsEtiCaixapeso.asFloat       := qryItensCaixa.FieldByName('ITE_PESOIT').AsFloat;
          cdsEtiCaixacodfab.asString    := qryItensCaixa.FieldByName('ITE_CODFAB').AsString;
          cdsEtiCaixafgoinc.asString    := qryItensCaixa.FieldByName('FGC_FGOINC').AsString;
          cdsEtiCaixafdoinc.asString    := qryItensCaixa.FieldByName('FGC_FDOINC').AsString;

          fldEtiCaixacodigo.asString    := qryItensCaixa.FieldByName('FDO_CODITE').AsString;
          fldEtiCaixaunidade.asString   := qryItensCaixa.FieldByName('UNI_SIGUNI').AsString;
          strngfldEtiCaixadescricao.asString := qryItensCaixa.FieldByName('FDO_DESCRI').AsString;

          cdsEtiCaixaCodBar.asString    := qryItensCaixa.FieldByName('CODBAR').AsString;
          cdsEtiCaixaDtaRot.asString    := qryItensCaixa.FieldByName('DTAROT').AsString;

          cdsEtiCaixaseqCxId.asString  := cdsSelecaoCaixas.FieldByName('FGC_CAI_ID').asString;

          cdsEtiCaixa.Post;
          qryItensCaixa.Next;
        end;

      end;
      cdsSelecaoCaixas.next;
    end;
  finally
    FreeAndNil(qryItensCaixa);
  end;
end;

procedure TfrmImpEtiDespacho.pCarregaVolumesSepExclusiva(Const strTabPri: String; Const strTabAux: String = '');

  function fGetVolume(Const strCampo: String): Double;
  begin
    If fBuscaPorCodCliente Then
      Result := fCampoTabela(strCampo, strTabPri +' M JOIN '+ strTabAux +' A ON A.AUX_SEQGER = M.AUTOINCREM',
                             ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_ORIDOC', 'GER_CODCLI'],
                             [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, 'V', edtCodCli.Text])
    Else
      Result := fCampoTabela(strCampo, strTabPri +' M JOIN '+ strTabAux +' A ON A.AUX_SEQGER = M.AUTOINCREM',
                             ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_ORIDOC'],
                             [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, 'V']);
  end;

begin
  If SameText(strTabPri, 'FATGOR') Then
  Begin
    edtQtdVolSepExc.Text  := fGetVolumeSepExcPDOR(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text).ToString;
    edtQtdVolSepNExc.Text := fGetVolumeSepNaoExcPDOR(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text).ToString;
  End
  Else
  Begin
    edtQtdVolSepExc.Text  := fGetVolume('AUX_VOLEXS').ToString;
    edtQtdVolSepNExc.Text := fGetVolume('AUX_VOLEXN').ToString;
  End;
end;

procedure TfrmImpEtiDespacho.pChaveAcessoToDocumento(AChaAce: String;
  blnPesquisarPorEdtChave: Boolean);
  var
    LAux : TUniQuery;
begin

  If AChaAce.IsEmpty Then
    Exit;

  LAux := fCriaQuery;

  Try

    LAux.Close;
    LAux.SQL.Clear;
    LAux.SQL.Add('SELECT FIS_NUMDOC, FIS_ESPDOC, FIS_TIP_FC, FIS_FORCLI FROM CADFIS ');
    LAux.SQL.Add('WHERE FIS_CODEMP = :CODEMP ');
    LAux.SQL.Add('AND FIS_ACESSO = :ACESSO ');

    If blnPesquisarPorEdtChave Then
      LAux.SQL.Add('AND FIS_ORIDOC = "V" ');

    LAux.ParamByName('ACESSO').AsString := AChaAce;
    LAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    LAux.Open;

    If Not LAux.IsEmpty Then
    Begin
      edtNumDoc.Text := LAux.FieldByName('FIS_NUMDOC').AsString;
      edtEspDoc.Text := LAux.FieldByName('FIS_ESPDOC').AsString;

      If fCfgSis('CLETDS', varBoolean) Then
      Begin

        If LAux.FieldByName('FIS_TIP_FC').AsString.Equals('C') Then
        Begin
          edtCodCli.Text := LAux.FieldByName('FIS_FORCLI').AsString;
          If Not fEmptyStr(edtCodCli.Text) Then
            fValidaCampos(edtCodCli, True);
        End;

        rdgTpDestinatario.ItemIndex := IIF(LAux.FieldByName('FIS_TIP_FC').AsString.Equals('C'), 0, 1);

      End;

      edtQtdVol.Text := fCarregaVolume;
      pValidaImpressaoAutomatica;
    End;

  Finally
    FreeAndNil(LAux);
  End;

end;

procedure TfrmImpEtiDespacho.pCriaClientEtiquetas;
Begin
  cdsEtiquetas := TUniClientDataSet.Create(Self);
  cdsEtiquetas.DisableControls;
  cdsEtiquetas.FetchOnDemand := False;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMDOC';
    DataType := ftString;
    Size := 9;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDVOL';
    DataType := ftString;
    Size := 30;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SEQVOL';
    DataType := ftInteger;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PESBRU';
    DataType := ftFloat;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Size := 03;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMEMP';
    DataType := ftString;
    Size := 50;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ENDEMP';
    DataType := ftString;
    Size := 50;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ENEMP2';
    DataType := ftString;
    Size := 255;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CEPEMP';
    DataType := ftString;
    Size := 10;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CIDEMP';
    DataType := ftString;
    Size := 50;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODCLI';
    DataType := ftString;
    Size := 08;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMCLI';
    DataType := ftString;
    Size := 50;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'FONCLI';
    DataType := ftString;
    Size := 15;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ENDCLI';
    DataType := ftString;
    Size := 50;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BAICLI';
    DataType := ftString;
    Size := 30;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CEPCLI';
    DataType := ftString;
    Size := 10;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CIDCLI';
    DataType := ftString;
    Size := 50;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMCID';
    DataType := ftString;
    Size := 50;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ESTADO';
    DataType := ftString;
    Size := 3;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMTRA';
    DataType := ftString;
    Size := 50;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTAENT';
    DataType := ftString;
    Size := 08;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TIP_FC';
    DataType := ftString;
    Size := 10;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'FONEMP';
    DataType := ftString;
    Size := 20;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PEDVEN';
    DataType := ftString;
    Size := 100;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PEDCOM';
    DataType := ftString;
    Size := 100;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CONFER';
    DataType := ftString;
    Size := 100;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMVEN';
    DataType := ftString;
    Size := 100;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDITE';
    DataType := ftFloat;
  End;


  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESFRE';
    DataType := ftString;
    Size := 100;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTFRE';
    DataType := ftFloat;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESREG';
    DataType := ftString;
    Size := 100;
  End;

  With cdsEtiquetas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'OPELIB';
    DataType := ftString;
    Size := 100;
  End;

  cdsEtiquetas.CreateDataSet;

End;

function TfrmImpEtiDespacho.fImpEtiquetasDespachoProdutoArgox: Boolean;
Var
  prmDllEtq  : TParamDllEtiquetas;
begin
  prmDllEtq := TParamDllEtiquetas.Create;
  try
    prmDllEtq.tpeTipEtq := tpeDespachoProdutoArgox;
    prmDllEtq.strNumDoc := AnsiString(edtNumDoc.Text);
    prmDllEtq.strEspDoc := AnsiString(edtEspDoc.Text);
    prmDllEtq.strCodEmp := AnsiString(edtCodEmp.Text);
    prmDllEtq.blnImpEti := blnImpEti;
    prmDllEtq.blnImpAut := blnImpAut;
    prmDllEtq.strNomFil := strNomFil;
    prmDllEtq.strNomTab := AnsiString(fNomeTabela);
    prmDllEtq.strTipoFC := AnsiString(strTip_fc);
    prmDllEtq.strUltimaFilaUtilizada := strUltimaFilaUtilizada;
    Result := fImprimeEtiqueta(prmDllEtq);
    strUltimaFilaUtilizada := prmDllEtq.strUltimaFilaUtilizada;
  finally
    FreeAndNil(prmDllEtq);
  end;
end;

function TfrmImpEtiDespacho.fImpEtiquetasLaserArgox(strImprimeEtiquetaVolumeComposto: String = ''; blnSepExclusiva: Boolean = False; cdsDespachoPorAmbiente: TUniClientdataset = nil): Boolean;
Var
  prmDllEtq  : TParamDllEtiquetas;
  strNumPok,
  strPedSit,
  strNumPed,
  strEmpPed  : String;
  Pedido     : untWS_SkyHub.TDocumento;
begin

  Result := False;

  strNumPok := '';
  strPedSit := '';

  if (fCfgSis('UTEECO', varBoolean)) then
  begin
    If Pos(edtEspDoc.Text, 'PD_OR_') > 0 Then
    Begin
      strNumPok := fCampoTabela('FGO_NUMPOK', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text]);
      strPedSit := fCampoTabela('FGO_PEDSIT', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text]);
    End
    Else
    Begin
      pRetNumeroPedidoVenda(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, strCodCli, strNumPed, strEmpPed);
      strNumPok := fCampoTabela('FGO_NUMPOK', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [strNumPed, 'PD', strEmpPed]);
      strPedSit := fCampoTabela('FGO_PEDSIT', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [strNumPed, 'PD', strEmpPed]);
    End;
  end;

  prmDllEtq := TParamDllEtiquetas.Create;

  If fEmptyStr(strNumPok) And fEmptyStr(strPedSit) Then
  begin
    If fEmptyStr(strImprimeEtiquetaVolumeComposto) Then
    Begin
      If fEtiquetaDeDespachoDiferenteParaFaturamentoDePedido() Then
        prmDllEtq.tpeTipEtq := IIF(strCfgTipEti = 'L', tpeDespachoFaturarExpedidoLaser, tpeDespachoFaturarExpedidoArgox)
      Else
        prmDllEtq.tpeTipEtq := IIF(strCfgTipEti = 'L', tpeDespachoLaser, tpeDespachoArgox);
    End
    Else If strImprimeEtiquetaVolumeComposto = 'I' Then
      prmDllEtq.tpeTipEtq := IIF(strCfgTipEti = 'L', tpeEtiquetaDespachoVolumeIndividualLaser, tpeEtiquetaDespachoVolumeIndividualArgox)
    Else If strImprimeEtiquetaVolumeComposto = 'G' Then
      prmDllEtq.tpeTipEtq := IIF(strCfgTipEti = 'L', tpeEtiquetaDespachoVolumeGeralLaser, tpeEtiquetaDespachoVolumeGeralArgox);
  end
  Else
  Begin
    prmDllEtq.tpeTipEtq := tpeDespachoLaserECommerce;
    If fCampoTabela('COUNT(*) AS QTD', 'LAYETI', ['LAY_PADRAO', 'LAY_TIPLAY'], ['S', '139']) = 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O modelo da etiqueta de despacho Laser E-Commerce (código 139) não está disponível para a empresa ('+edtCodEmp.Text+')!', ['&OK']);
      Exit;
    End;
  End;

  prmDllEtq.strNumDoc := AnsiString(edtNumDoc.Text);
  prmDllEtq.strEspDoc := AnsiString(edtEspDoc.Text);
  prmDllEtq.strCodEmp := AnsiString(edtCodEmp.Text);
  prmDllEtq.blnImpEti := blnImpEti;
  prmDllEtq.blnImpAut := blnImpAut;
  prmDllEtq.strNomFil := strNomFil;
  prmDllEtq.strNomTab := AnsiString(fNomeTabela);
  prmDllEtq.strTipoFC := AnsiString(strTip_fc);
  prmDllEtq.intEtqInicial := StrToIntDef(edtEtqInicial.Text, 0);
  prmDllEtq.strMultPed := strMultPed;
  prmDllEtq.blnB2W := False;
  prmDllEtq.blnSepExclusiva := blnSepExclusiva;

  if fBuscaPorCodCliente then
    prmDllEtq.strCodCli := edtCodCli.Text
  else
    prmDllEtq.strCodCli := strCodCli;

  If pnlVolumeSepExc.Visible Then
  Begin
    If blnSepExclusiva Then
      prmDllEtq.intQtdVol := StrToInt(edtQtdVolSepExc.Text)
    Else
      prmDllEtq.intQtdVol := StrToInt(edtQtdVolSepNExc.Text);

    If prmDllEtq.intQtdVol = 0 Then
      Exit(True)
  End
  Else
    prmDllEtq.intQtdVol := IIF(rdgTipoEtiq.ItemIndex = 2, 1, StrToInt(edtQtdVol.Text));

  if fGetIntegrarComMandae then
    prmDllEtq.strLayDoc := fCampoTabela('TRA_MANLAY', 'CADTRA', ['TRA_CODTRA'], [fGetCodigoDaTransportadora])
  else if fGetIntegrarComJadlog then
    prmDllEtq.strLayDoc := fCampoTabela('TRA_JADLAY', 'CADTRA', ['TRA_CODTRA'], [fGetCodigoDaTransportadora])
  Else If blnUSigep Then
  Begin
    if (fCfgSis('USIGEP', varString) = 'O') Then
      prmDllEtq.strLayDoc := fCampoTabela('TRA_LAYETQ', 'CADTRA', ['TRA_CODTRA'], [strSerCor])
    Else
      prmDllEtq.strLayDoc := fCampoTabela('CSE_CODLAY', 'CORSER', ['CSE_CODIGO'], [strSerCor]);
  End
  Else If (fUtilizaRotinaDeImpressaoDeEtiquetaDeDespachoB2WEntrega And fTransportadoraRealizaColetaB2WEntrega(fGetCodigoDaTransportadora)) Then
  Begin

    Pedido.strNumDoc := edtNumDoc.Text;
    Pedido.strEspDoc := edtEspDoc.Text;
    Pedido.strCodEmp := edtCodEmp.Text;

    {Identifica pedido de origem do documento de venda}
    If (fNomeTabela = 'MOVGER') Then
      Pedido := RetornaPedidoDocumentoVenda(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text);

    prmDllEtq.blnB2W    := True;
    prmDllEtq.strLayDoc := fRetornaLayoutEtiquetaDespachoB2W(Pedido.strNumDoc, Pedido.strEspDoc, Pedido.strCodEmp);

    If fEmptyStr(prmDllEtq.strLayDoc) Then
    Begin
      fMensagem('ATENÇÃO!', 'O modelo da etiqueta de despacho B2W Entrega (Direct), não foi encontrado!', ['&OK']);
      Exit;
    End;

  End;

  prmDllEtq.strUltimaFilaUtilizada := strUltimaFilaUtilizada;
  prmDllEtq.cdsDespachoPorAmbiente := cdsDespachoPorAmbiente;
  Result := fImprimeEtiqueta(prmDllEtq);
  strUltimaFilaUtilizada := prmDllEtq.strUltimaFilaUtilizada;

  FreeAndNil(prmDllEtq);
end;

procedure TfrmImpEtiDespacho.pProcessaClientDataSet(qryEtique: TUniQuery; intQtdVol: Integer; blnSepExclusiva: Boolean = False);
  Var
    intContador: Integer;
begin
  With qryEtique Do
  Begin
    cdsEtiquetas.EmptyDataSet;

    For intContador := 1 To intQtdVol Do
    Begin
      if intContador < StrToInt(edtEtqInicial.Text) then
        Continue;

      cdsEtiquetas.Append;
      cdsEtiquetas.FieldByName('NUMDOC').AsString := FieldByName('NUMDOC').AsString;
      cdsEtiquetas.FieldByName('SEQVOL').AsInteger := intContador;
      cdsEtiquetas.FieldByName('QTDVOL').AsString := IntToStr(intContador) + '/' + IntToStr(intQtdVol) + IIF(blnSepExclusiva, ' SEP. EXCLUSIVA', '');
      cdsEtiquetas.FieldByName('QTDITE').AsFloat  := FieldByName('QTDITE').AsFloat;
      cdsEtiquetas.FieldByName('CODEMP').AsString := FieldByName('CODEMP').AsString;
      cdsEtiquetas.FieldByName('NOMEMP').AsString := FieldByName('NOMEMP').AsString;
      cdsEtiquetas.FieldByName('ENDEMP').AsString := FieldByName('ENDEMP').AsString;
      cdsEtiquetas.FieldByName('ENEMP2').AsString := FieldByName('ENEMP2').AsString;
      cdsEtiquetas.FieldByName('CEPEMP').AsString := FieldByName('CEPEMP').AsString;
      cdsEtiquetas.FieldByName('CIDEMP').AsString := FieldByName('CIDEMP').AsString;
      cdsEtiquetas.FieldByName('NOMCLI').AsString := FieldByName('NOMCLI').AsString;
      cdsEtiquetas.FieldByName('CODCLI').AsString := FieldByName('CODCLI').AsString;
      cdsEtiquetas.FieldByName('FONCLI').AsString := FieldByName('FONCLI').AsString;
      cdsEtiquetas.FieldByName('FONEMP').AsString := FieldByName('FONEMP').AsString;
      cdsEtiquetas.FieldByName('ENDCLI').AsString := FieldByName('ENDCLI').AsString;
      cdsEtiquetas.FieldByName('BAICLI').AsString := FieldByName('BAICLI').AsString;
      cdsEtiquetas.FieldByName('CEPCLI').AsString := FieldByName('CEPCLI').AsString;
      cdsEtiquetas.FieldByName('NOMCID').AsString := FieldByName('NOMCID').AsString;
      cdsEtiquetas.FieldByName('ESTADO').AsString := FieldByName('ESTADO').AsString;
      cdsEtiquetas.FieldByName('CIDCLI').AsString := FieldByName('CIDCLI').AsString;
      cdsEtiquetas.FieldByName('PESBRU').AsFloat  := FieldByName('PESBRU').AsFloat;
      cdsEtiquetas.FieldByName('NOMTRA').AsString := FieldByName('NOMTRA').AsString;
      cdsEtiquetas.FieldByName('DTAENT').AsString := FormatDateTime('dd/mm/yy', VS_Date);
      cdsEtiquetas.FieldByName('TIP_FC').AsString := FieldByName('TIP_FC').AsString;
      cdsEtiquetas.FieldByName('PEDVEN').AsString := FieldByName('PEDVEN').AsString;
      cdsEtiquetas.FieldByName('PEDCOM').AsString := FieldByName('PEDCOM').AsString;
      cdsEtiquetas.FieldByName('CONFER').AsString := FieldByName('CONFER').AsString;
      cdsEtiquetas.FieldByName('NOMVEN').AsString := FieldByName('NOMVEN').AsString;
      cdsEtiquetas.FieldByName('DESFRE').AsString := FieldByName('DESFRE').AsString;
      cdsEtiquetas.FieldByName('TOTFRE').AsFloat  := FieldByName('TOTFRE').AsFloat;
      cdsEtiquetas.FieldByName('DESREG').AsString := FieldByName('DESREG').AsString;
      cdsEtiquetas.FieldByName('OPELIB').AsString := FieldByName('OPELIB').AsString;
      cdsEtiquetas.Post;
      Application.ProcessMessages;
    End;
  End;
end;

procedure TfrmImpEtiDespacho.pValidaImpressaoAutomatica;
begin

  If blnImprimindoEtiquetas Then
    Exit;

  If chkImpAut.Checked Then
  Begin
    blnMudarFoco := False;
    pSetFocus(btnConfirma);
    btnConfirmaClick(Self);
  End;

end;

procedure TfrmImpEtiDespacho.rdgTpDestinatarioClick(Sender: TObject);
begin
  inherited;

  edtCodCli.Enabled := (rdgTpDestinatario.ItemIndex = 0);
  edtCodCli.TabStop := (rdgTpDestinatario.ItemIndex = 0);
  edtCodCli.Text    := IIF(rdgTpDestinatario.ItemIndex = 0, edtCodCli.Text, '');

  edtNomCli.Enabled := (rdgTpDestinatario.ItemIndex = 0);
  edtNomCli.TabStop := (rdgTpDestinatario.ItemIndex = 0);
  edtNomCli.Text    := IIF(rdgTpDestinatario.ItemIndex = 0, edtNomCli.Text, '');

end;

function TfrmImpEtiDespacho.fImpEtiquetasMatricial(blnSepExclusiva: Boolean = False): Boolean;
  Var
    strSQL: String;
    qryEtique: TUniQuery;
    strErro: string;
begin
  Result := False;
  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  If fNomeTabela = 'FATGOR' Then
    strSQL := strSQL + ' " " AS NUMDOC, '
  Else
    strSQL := strSQL + ' CONCAT(G.GER_NUMDOC, "-", G.GER_ESPDOC) AS NUMDOC, ';

  strSQL := strSQL + '  E.EMP_CODEMP  AS CODEMP, ';
  strSQL := strSQL + '  E.EMP_NOMEMP  AS NOMEMP, ';
  strSQL := strSQL + '  CONCAT(E.EMP_ENDERE, ", ", E.EMP_ENDNUM,IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))) AS ENDEMP, ';
  strSQL := strSQL + '  CONCAT(E.EMP_ENDERE, ", ", E.EMP_ENDNUM,IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))," - ",E.EMP_BAIRRO," - ",C1.CID_NOMCID,"-",C1.CID_ESTADO) AS ENEMP2, ';
  strSQL := strSQL + '  E.EMP_C_E_P_  AS CEPEMP, ';
  strSQL := strSQL + '  CONCAT(C1.CID_NOMCID,"-",C1.CID_ESTADO) AS CIDEMP, ';
  strSQL := strSQL + '  E.EMP_FONE01  AS FONEMP, ';

  If strTip_fc = 'C' Then
  Begin
    strSQL := strSQL + '  C.CLI_CODCLI  AS CODCLI, ';
    strSQL := strSQL + '  C.CLI_NOMCLI  AS NOMCLI, ';
    strSQL := strSQL + '  C.CLI_FONE01  AS FONCLI, ';
    strSQL := strSQL + '  CONCAT(CLI_ENDERE, IF(IFNULL(CLI_ENDNUM, "") = "", "", CONCAT(", ", CLI_ENDNUM)), IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT(", ", CLI_ENDCOM))) AS ENDCLI, ';
    strSQL := strSQL + '  C.CLI_BAIRRO  AS BAICLI, ';
    strSQL := strSQL + '  C.CLI_C_E_P_  AS CEPCLI, ';
    strSQL := strSQL + '  RG.REG_DESREG AS DESREG, ';
  End
  Else
  Begin
    strSQL := strSQL + '  C.FOR_CODFOR  AS CODCLI, ';
    strSQL := strSQL + '  C.FOR_NOMFOR  AS NOMCLI, ';
    strSQL := strSQL + '  C.FOR_FONE01  AS FONCLI, ';
    strSQL := strSQL + '  CONCAT(FOR_ENDERE, IF(IFNULL(FOR_ENDNUM, "") = "", "", CONCAT(", ", FOR_ENDNUM)), IF(IFNULL(FOR_ENDCOM, "") = "", "", CONCAT(", ", FOR_ENDCOM))) AS ENDCLI, ';
    strSQL := strSQL + '  C.FOR_BAIRRO  AS BAICLI, ';
    strSQL := strSQL + '  C.FOR_C_E_P_  AS CEPCLI, ';
    strSQL := strSQL + '  CAST("" AS CHAR(01)) AS DESREG, ';
  End;

  strSQL := strSQL + '  C2.CID_NOMCID AS NOMCID, ';
  strSQL := strSQL + '  C2.CID_ESTADO AS ESTADO, ';
  strSQL := strSQL + '  CONCAT(C2.CID_NOMCID,"-",C2.CID_ESTADO) AS CIDCLI, ';
  strSQL := strSQL + '  G.GER_PESBRU  AS PESBRU, ';
  strSQL := strSQL + '  G.GER_TIP_FC  AS TIP_FC, ';
  strSQL := strSQL + '  T.TRA_NOMTRA  AS NOMTRA, ';

  If fNomeTabela = 'FATGOR' Then
  Begin
    strSQL := strSQL + '  FGO_NUMDOC AS PEDVEN, ';
    strSQL := strSQL + '  (SELECT GROUP_CONCAT(CMP_NUMCMP) FROM NUMCMP WHERE ';
    strSQL := strSQL + '   CMP_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + '  ) PEDCOM, ';

    strSQL := strSQL + ' (SELECT SUM(FDO_QTDITE) FROM FATDOR D WHERE G.AUTOINCREM = D.FDO_SEQGER) AS QTDITE, ';
    strSQL := strSQL + fSQLTipoFrete('FGO_TIPFRE') + ' AS DESFRE, ';
    strSQL := strSQL + ' FGO_TOTFRE AS TOTFRE, ';
    strSQL := strSQL + ' CAST("" AS CHAR(01)) AS CHAACE, ';
  End
  Else
  Begin
    strSQL := strSQL + '  (SELECT GROUP_CONCAT(FGO_NUMDOC) FROM FATGOR WHERE ';
    strSQL := strSQL + '   FGO_NUMFAT = G.GER_NUMDOC AND ';
    strSQL := strSQL + '   FGO_TIPFAT = G.GER_ESPDOC AND ';
    strSQL := strSQL + '   FGO_CODEMP = G.GER_CODEMP     ';
    strSQL := strSQL + '  ) PEDVEN, ';

    strSQL := strSQL + '  " " AS PEDCOM, ';

    strSQL := strSQL + ' (SELECT SUM(DET_QTDITE) FROM MOVDET D WHERE G.AUTOINCREM = D.DET_SEQGER) AS QTDITE, ';
    strSQL := strSQL + fSQLTipoFrete('G.GER_TIPFRE') + ' AS DESFRE, ';
    strSQL := strSQL + ' G.GER_TOTFRE AS TOTFRE, ';
    strSQL := strSQL + '   FIS_ACESSO AS CHAACE, ';
  End;

  strSQL := strSQL + ' (SELECT CF.OPE_NOMOPE FROM CADOPE CF WHERE CF.OPE_CODOPE = GER_OPEEXP) AS CONFER, ';
  strSQL := strSQL + ' (SELECT SP.OPE_NOMOPE FROM CADOPE SP WHERE SP.OPE_CODOPE = GER_SEPEXP) AS SEPARA, ';
  strSQL := strSQL + ' (SELECT VE.OPE_NOMOPE FROM CADOPE VE WHERE VE.OPE_CODOPE = GER_CODVEN) AS NOMVEN, ';
  strSQL := strSQL + ' (SELECT LB.OPE_NOMOPE FROM CADOPE LB WHERE LB.OPE_CODOPE = GER_OPLBEX) AS OPELIB ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + fNomeTabela + ' G ';
  strSQL := strSQL + '        JOIN CADEMP E  ON (G.GER_CODEMP  = E.EMP_CODEMP) ';
  strSQL := strSQL + '   LEFT JOIN CADCID C1 ON (C1.CID_CODCID = E.EMP_CODCID) ';

  If fNomeTabela = 'FATGOR' Then
      strSQL := strSQL + '  LEFT JOIN EXTGOR EX ON G.AUTOINCREM = EX.FGO_SEQFGO '
  Else
  Begin
    strSQL := strSQL + '  LEFT JOIN CADFIS ON FIS_NUMDOC = G.GER_NUMDOC ';
    strSQL := strSQL + '                  AND FIS_ESPDOC = G.GER_ESPDOC ';
    strSQL := strSQL + '                  AND FIS_CODEMP = G.GER_CODEMP ';
    If strTip_fc = 'C' Then
      strSQL := strSQL + '                  AND FIS_FORCLI = G.GER_CODCLI '
    Else
      strSQL := strSQL + '                  AND FIS_FORCLI = G.GER_CODFOR ';
    strSQL := strSQL + '                  AND FIS_TIP_FC = G.GER_TIP_FC ';
  End;

  If strTip_fc = 'C' Then
  Begin
    strSQL := strSQL + '   LEFT JOIN CADCLI C  ON (G.GER_CODCLI  = C.CLI_CODCLI) ';
    strSQL := strSQL + '   LEFT JOIN CADCID C2 ON (C2.CID_CODCID = C.CLI_CODCID) ';
    strSQL := strSQL + '   LEFT JOIN CADREG RG ON (RG.REG_CODREG = C.CLI_CODREG) ';
  End
  Else
  Begin
    strSQL := strSQL + '   LEFT JOIN CADFOR C  ON (G.GER_CODFOR  = C.FOR_CODFOR) ';
    strSQL := strSQL + '   LEFT JOIN CADCID C2 ON (C2.CID_CODCID = C.FOR_CODCID) ';
  End;

  strSQL := strSQL + '   LEFT JOIN CADTRA T  ON (T.TRA_CODTRA  = G.GER_CODTRA) ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   G.GER_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   G.GER_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   G.GER_TIP_FC = "' + strTip_fc + '" AND ';
  strSQL := strSQL + '   G.GER_ORIDOC = "V" AND ';
  strSQL := strSQL + '   G.GER_CODEMP = :CODEMP ';

  If fNomeTabela = 'FATGOR' Then
  Begin
    strSQL := AnsiReplaceStr(strSQL, 'G.GER_TIP_FC', '"C"');
    strSQL := AnsiReplaceStr(strSQL, 'G.GER_ORIDOC', '"V"');
    strSQL := AnsiReplaceStr(strSQL, 'GER_', 'FGO_');
    strSQL := AnsiReplaceStr(strSQL, 'OPLBEX', 'OPEEXP');
  End
  Else
    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(strSQL, 'SEPEXP', 'OPEEXP'),'OPLBEX', 'OPEEXP'),
                                       fNomeTabela, AnsiReplaceStr(fNomeTabela, 'MOV', 'NOT'));

  qryEtique := fCriaQuery(Self);
  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    ParamByName('CODEMP').AsString := edtCodEmp.Text;
    Open;
  End;

  {*******************************************}
  {* PROCESSA O CLIENT INSERINDO REGISTROS   *}
  {* REFERENTE A QTD DE VOLUMES DO DOCUMENTO *}
  {****************************************AN*}
  pCriaClientEtiquetas;

  If pnlVolumeSepExc.Visible Then
  Begin
    If blnSepExclusiva Then
      pProcessaClientDataSet(qryEtique, StrToInt(edtQtdVolSepExc.Text), True)
    Else
      pProcessaClientDataSet(qryEtique, StrToInt(edtQtdVolSepNExc.Text));

    If cdsEtiquetas.IsEmpty Then
      Exit(True);
  End
  Else
    pProcessaClientDataSet(qryEtique, StrToInt(edtQtdVol.Text));

  FreeAndNil(qryEtique);

  If blnSepExclusiva Then
  Begin
    pCarregaConfImpr(qryCfgRel, Self.Name + '_SEP_EXC');

    If fEmptyStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString) Then
      pCarregaConfImpr(qryCfgRel, Self.Name);
  End
  Else
    pCarregaConfImpr(qryCfgRel, Self.Name);

  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
  strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;

  If Not fVerificaImpressora(strNomImp) Then
  Begin
    fMensagem('','Impressora configurada incorretamente!',['&OK']);
    Exit;
  End;

  cpuCampos := TCamposUso.Create;
  cpuCampos.AdicionaCampos(cdsEtiquetas, 'MOVDET');

  With cdsEtiquetas Do
  Begin

    First;
    While Not Eof Do
    Begin
      Application.ProcessMessages;
      pImpRegistro(strErro);
      If strErro<> '' Then
      Begin
        pMensagemOk(strErro);
        Exit;
      End;
      Application.ProcessMessages;
      Next;
    End;
    {**********************************************************************************}
    {* É NECESSARIO CHAMAR ESSA PROCEDURE NESSE PONTO PARA QUE SAIA A ÚLTIMA ETIQUETA *}
    {*******************************************************************************MV*}
    pImpArrLinhasEti;

    cdsEtiquetas.Close;
    cdsEtiquetas.Open;
  End;
  pSetFocus(FComponenteFoco);

  If Assigned(cpuCampos) Then
    FreeAndNil(cpuCampos);
  Result := true;
end;

procedure TfrmImpEtiDespacho.pEtiquetaGerado;
var
  cdsCaixa: TUniClientDataSet;
  blnPreview: boolean;
  intCols: integer;
  intTotCaixa : Integer;
  intContCaixa : Integer;
  intVolumes : Integer;
Begin
  cdsCaixa := TUniClientDataSet.Create(Self);
  try
    TMontarCaixas.pCriarCamposDataSetEtiquetaMontagemCaixas(cdsCaixa);

    intTotCaixa := fTotCaixaSelec;
    intContCaixa := 0;

    cdsCaixas.First;
    intVolumes := cdsEtiCaixa.RecordCount;
    while not cdsCaixas.eof do
    begin
      if cdsCaixas.FieldByName('FGC_IMPRIM').asBoolean = true then
      begin
        cdsCaixa.Append;
        cdsCaixa.FieldByName('BAICLI').AsString := cdsCaixasCLI_BAIRRO.asString;
        cdsCaixa.FieldByName('CEPCLI').AsString := cdsCaixasCLI_C_E_P_.asString;
        cdsCaixa.FieldByName('CIDCLI').AsString := fRetNomCidade(cdsCaixasCLI_CODCID.asString,0);
        cdsCaixa.FieldByName('ENDCLI').AsString := cdsCaixasCLI_ENDERE.asString + ', ' +
                                                   cdsCaixasCLI_ENDNUM.asString + '- ' +
                                                   cdsCaixasCLI_ENDCOM.asString;
        cdsEtiCaixa.First;
        cdsEtiCaixa.Filtered := False;
        cdsEtiCaixa.Filter   := 'SEQCXID = ' + QuotedStr(cdsCaixas.FieldByName('FGC_CAI_ID').AsString);
        cdsEtiCaixa.Filtered := True;
        intCols := 1;
        while not cdsEtiCaixa.Eof do
        begin
          cdsCaixa.FieldByName('LSTFAB').AsString := cdsCaixa.FieldByName('LSTFAB').AsString + ' | ' +
                                                     (FormatFloat('##0', cdsEtiCaixaquantidade.AsFloat) + ' | ' +
                                                      cdsEtiCaixacodfab.asString + IfThen(intCols=1, ' | ', #13) );

          cdsCaixa.FieldByName('LSTITE').AsString := cdsCaixa.FieldByName('LSTITE').AsString +
                                                     fldEtiCaixacodigo.asString + ' - ' + (FormatFloat('#,##0.00', cdsEtiCaixaquantidade.AsFloat)) +
                                                     ' ' + fldEtiCaixaunidade.asString + ' ' + strngfldEtiCaixadescricao.asString + #13;

          cdsEtiCaixa.Next;
          if intCols=1 then
            intCols := 2;
        end;
        cdsEtiCaixa.EnableControls;
        cdsCaixa.FieldByName('FANSOB').AsString := cdsCaixasCLI_FANSOB.asString;
        cdsCaixa.FieldByName('NOMCNF').AsString := cdsCaixasFGO_OPEEXP.AsString +'-'+ fRetNomVendRep(cdsCaixasFGO_OPEEXP.AsString);
        cdsCaixa.FieldByName('NOMSEP').AsString := cdsCaixasFGO_SEPEXP.AsString +'-'+ fRetNomVendRep(cdsCaixasFGO_SEPEXP.AsString);
        cdsCaixa.FieldByName('CAIXA').AsString  := cdsCaixasFGC_CAI_ID.asString;
        cdsCaixa.FieldByName('NUMCMP').AsString := cdsCaixasFDO_NUMCMP.asString;
        cdsCaixa.FieldByName('NUMDOC').AsString := cdsCaixasFGO_NUMDOC.asString;
        cdsCaixa.FieldByName('NOMCLI').AsString := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [cdsCaixasCLI_CODCLI.asString]);
        cdsCaixa.FieldByName('TOTPES').AsString := FormatFloat('#,##0.00 KG', cdsCaixasFDO_TOTPES.asFloat);
        cdsCaixa.FieldByName('ESTCLI').AsString := fRetNomCidade(cdsCaixasCLI_CODCID.asString,1);

        cdsCaixa.FieldByName('CODBAR').AsString := cdsEtiCaixaCodBar.asString;
        cdsCaixa.FieldByName('NOMTRA').AsString := cdsCaixasTRA_NOMTRA.asString;
        cdsCaixa.FieldByName('NUMPED').AsString := cdsCaixasFGO_NUMDOC.asString;
        cdsCaixa.FieldByName('NOMROT').AsString := cdsCaixasREG_DESREG.asString;
        cdsCaixa.FieldByName('NOMVD1').AsString := cdsCaixasFDO_CODVEN.asString + '-' +
                                                   fRetNomVendRep(cdsCaixasFDO_CODVEN.asString);

        cdsCaixa.FieldByName('NOMVD2').AsString := cdsCaixasFDO_CODVE2.asString + '-' +
                                                   fRetNomVendRep(cdsCaixasFDO_CODVE2.asString);

        cdsCaixa.FieldByName('CLICOD').AsString := cdsCaixasCLI_CODCLI.asString;

        cdsCaixa.FieldByName('CODOPE').AsString := untFuncoesSimples.strLoginUsuarioLogado;
        cdsCaixa.FieldByName('NOMOPE').AsString := fRetNomeOperador(untFuncoesSimples.strLoginUsuarioLogado);

        cdsCaixa.FieldByName('DTAROT').AsString := cdsEtiCaixaDtaRot.asString;


        cdsCaixa.FieldByName('NOMCID').AsString := fRetNomCidade(cdsCaixasCLI_CODCID.asString,0)+'-'+
                                                   fRetNomCidade(cdsCaixasCLI_CODCID.asString,1);

        cdsCaixa.FieldByName('PESPED').AsString := FormatFloat('#,##0.00 KG', cdsCaixasFGO_PESBRU.asFloat);
        cdsCaixa.FieldByName('CODROT').AsString := cdsCaixasFGO_CODROT.asString;
        cdsCaixa.FieldByName('CODFAB').AsString := cdsEtiCaixacodfab.asString;

        cdsCaixa.FieldByName('NUMVOL').AsString := FormatFloat('00', intVolumes);
        inc(intContCaixa);
        cdsCaixa.FieldByName('TCAXFE').AsString := fStrZero(intContCaixa, 2) + '/' + fStrZero(intTotCaixa, 2);
        cdsCaixa.FieldByName('CODREG').AsString := cdsCaixasREG_CODREG.asString;
        cdsCaixa.FieldByName('DESREG').AsString := cdsCaixasREG_DESREG.asString;

        cdsCaixa.FieldByName('ENDENT').AsString := cdsCaixasENDENT.AsString;
        cdsCaixa.FieldByName('CEPENT').AsString := cdsCaixasCEPENT.AsString;
        cdsCaixa.FieldByName('CIDENT').AsString := cdsCaixasCIDENT.AsString;
        cdsCaixa.FieldByName('ESTENT').AsString := cdsCaixasESTENT.AsString;
        cdsCaixa.FieldByName('BAIENT').AsString := cdsCaixasBAIENT.AsString;

        cdsCaixa.Post;
      end;
      cdsCaixas.Next;
    end;

    blnPreview := (fMensagem('Etiqueta', 'Selecione a opção desejada:', ['&Imprimir', '&Visualizar']) = 2);

    pGeraEtiquetaMontagemCaixas(cdsCaixa, blnPreview);

  Finally
    FreeAndNil(cdsCaixa);
  End;

End;

procedure TfrmImpEtiDespacho.pExibeFrmExpDigVolumesCompostos();
Var
  frmExpDigVolumesCompostos: TfrmExpDigVolumesCompostos;
  strCodVol: String;
  strProCodVolumeComposto: String;
  qryItens: TUniQuery;
  qryEtiquetaVolumeComposto: TUniQuery;

  strNumDoc: String;
  strEspDoc: String;
  strCodEmp: String;
  strCodCli: String;
begin
  If (rdgTipoEtiq.ItemIndex <> 2) Then
    Exit;

  strNumDoc := edtNumDoc.Text;
  strEspDoc := edtEspDoc.Text;
  strCodEmp := edtCodEmp.Text;
  strCodCli := edtCodCli.Text;

  If fEmptyStr(strNumDoc) Then
    Exit;

  If (strEspDoc <> 'PD') Then
    Exit;

  If fEmptyStr(strCodCli) Then
    strCodCli := fRetornarClienteDocumento(strNumDoc, strEspDoc, strCodEmp);

  If fEmptyStr(strCodCli) Then
    Exit;

  pCriarFormularios(TfrmExpDigVolumesCompostos, frmExpDigVolumesCompostos);

  qryItens := fCriaQuery();

  Try
    qryItens.SQL.Add('  SELECT                                         ');
    qryItens.SQL.Add('    FD.FDO_CODITE CODITE,                        ');
    qryItens.SQL.Add('    FD.FDO_DESCRI DESCRI,                        ');
    qryItens.SQL.Add('    FD.FDO_QTDITE QTDITE,                        ');
    qryItens.SQL.Add('    CU.UNI_SIGUNI UNIDAD                         ');
    qryItens.SQL.Add('  FROM                                           ');
    qryItens.SQL.Add('    FATDOR FD                                    ');
    qryItens.SQL.Add('    LEFT JOIN CADUNI CU                          ');
    qryItens.SQL.Add('      ON FD.FDO_UNIDAD = CU.UNI_CODUNI           ');
    qryItens.SQL.Add('    LEFT JOIN CADITE CI                          ');
    qryItens.SQL.Add('      ON FD.FDO_CODITE = CI.ITE_CODITE           ');
    qryItens.SQL.Add('  WHERE                                          ');
    qryItens.SQL.Add('        FD.FDO_NUMDOC =:NUMDOC                   ');
    qryItens.SQL.Add('    AND FD.FDO_ESPDOC =:ESPDOC                   ');
    qryItens.SQL.Add('    AND FD.FDO_CODEMP =:CODEMP                   ');
    qryItens.SQL.Add('    AND CI.ITE_NECEXP = "S"                      ');

    qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
    qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
    qryItens.ParamByName('CODEMP').AsString := strCodEmp;

    qryItens.Open;

    qryItens.First;
    While (Not qryItens.Eof) Do
    Begin
      frmExpDigVolumesCompostos.pAddProduto(qryItens.FieldByName('CODITE').AsString + '-' + qryItens.FieldByName('DESCRI').AsString,
                                            qryItens.FieldByName('UNIDAD').AsString,
                                            qryItens.FieldByName('QTDITE').AsFloat);
      qryItens.Next;
    End;

    qryEtiquetaVolumeComposto := fCarregaEtiquetaVolumeCompostoPedido(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodVol);

    If (Assigned(qryEtiquetaVolumeComposto)) And (qryEtiquetaVolumeComposto <> Nil) And (Not fEmptyStr(qryEtiquetaVolumeComposto.SQL.Text)) Then
    Begin
      qryEtiquetaVolumeComposto.Open;

      If (Not qryEtiquetaVolumeComposto.IsEmpty) Then
      Begin
        qryEtiquetaVolumeComposto.First;

        While (Not qryEtiquetaVolumeComposto.Eof) Do
        Begin
          frmExpDigVolumesCompostos.pAddEtiquetaVolume(qryEtiquetaVolumeComposto.FieldByName('EVC_DESCRI').AsString,
                                                       qryEtiquetaVolumeComposto.FieldByName('EVC_SIGLA_').AsString,
                                                       qryEtiquetaVolumeComposto.FieldByName('EVC_VOLUME').AsInteger);

          qryEtiquetaVolumeComposto.Next;
        End;
      End;

      FreeAndNil(qryEtiquetaVolumeComposto);
    End;

    frmExpDigVolumesCompostos.ShowModal;

    If (frmExpDigVolumesCompostos.ModalResult = mrOk) Then
    Begin
      If (Not fEmptyStr(strCodVol)) Then
        pExcluiEtiquetaVolumeComposto(strCodVol);

      frmExpDigVolumesCompostos.cdsVolume.First;
      strProCodVolumeComposto := fAtualizaProCod('ETIEVC', 'EVC_CODIGO');

      While (Not frmExpDigVolumesCompostos.cdsVolume.Eof) Do
      Begin
        pInsereEtiquetaVolumeComposto(strProCodVolumeComposto,
                                      frmExpDigVolumesCompostos.cdsVolumeTIPVOL.AsString,
                                      frmExpDigVolumesCompostos.cdsVolumeSIGVOL.AsString,
                                      frmExpDigVolumesCompostos.cdsVolumeQTDVOL.AsInteger);

        frmExpDigVolumesCompostos.cdsVolume.Next;
      End;

      pVinculaEtiquetaVolumeCompostoAoPedido(strNumDoc,
                                             strEspDoc,
                                             strCodEmp,
                                             strCodCli,
                                             strProCodVolumeComposto);
    End;
  Finally
    FreeAndNil(qryItens);
    pFreeAndNil(frmExpDigVolumesCompostos);
  End;
end;

function TfrmImpEtiDespacho.fImpEtiquetasMontagemCaixaCodBarras: Boolean;
var
  strLayout: string;
begin

  result := false;

  If Not fCfgSis('MONCAI', varBoolean) And (Pos(VS_strTipExp, '3_4') > 0) Then
    Exit;

  strLayout := VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYETI', ['LAY_TIPLAY','LAY_CODEMP'], [TIPO_ETIQUETA_MONTAGEM_COD_BARRAS, Vs_strCodEmp]), '');

  if Not fEmptyStr(strLayout) then
     pEtiquetaGerado;

  result := true;
end;

function TfrmImpEtiDespacho.fImpEtiquetasMontagemCaixaPackList: Boolean;
var
  strLayout: string;
begin

  result := false;

  If Not fCfgSis('MONCAI', varBoolean) And (Pos(VS_strTipExp, '3_4') > 0) Then
    Exit;

  strLayout := VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYETI', ['LAY_TIPLAY','LAY_CODEMP'], ['208', Vs_strCodEmp]), '');

  if Not fEmptyStr(strLayout) then
     pEtiquetaGerado;

  result := true;

end;

function TfrmImpEtiDespacho.fImprimeEtiquetaDespachoOuVolumeComposto: Boolean;
begin
  Result := ((rdgTipoEtiq.ItemIndex = 0) or (rdgTipoEtiq.ItemIndex = 2));
end;

procedure TfrmImpEtiDespacho.pImpRegistro(var strErro: string);
  Var
    intQtdCol   : Integer;
    intQtdColOri: Integer;
    intContador : Integer;
    intLinhaAtu : Integer;
    intLinha    : Integer;
    intTamLinAnt: Integer;
    intNumCol   : Integer;
    intQtdEti   : Integer;
    intLinhaEti : Integer;
    strNumCol   : String;
    strLinha    : String;
    strSQL      : String;
    qryCnfEti   : TUniQuery;
begin
  intLinhaAtu := 1;
  intLinha    := 0;
  intLinhaEti := 0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CNFETI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CNF_TIPETI = :TIPETI AND';
  strSQL := strSQL + '  CNF_CODEMP = :CODEMP    ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  CNF_IDENTI, CNF_LINIMP, CNF_COL001 ';

  qryCnfEti := fCriaQuery(Self);
  With qryCnfEti Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('TIPETI').AsString := 'DES';
    ParamByName('CODEMP').AsString := edtCodEmp.Text;
    Open;
    intQtdEti := 1;
    If qryCnfEti.IsEmpty Then
    Begin
      strErro := 'Etiqueta Matricial não esta configurada.';
      Exit;
    End;

    While (intQtdEti > 0) Do
    Begin
      First;

      intQtdColOri := FieldByName('CNF_QTDCOL').AsInteger;
      intQtdCol := intQtdColOri;

      If (intQtdCol > intQtdEti) And (intColAtu <= 1) Then
        intQtdCol := intQtdEti;

      {*****************************************}
      {* LÊ E INTERPRETA O ID = '00'           *}
      {**************************************MV*}
      If intColAtu <= 1 Then
      Begin
        pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, 0, qryCnfEti);
        {*****************************************}
        {* ESCREVE COM WRITE, MAS NÃO IMPRIME    *}
        {**************************************MV*}
        pEscreveLinha(strArqTxt, AnsiString(strLinha), not VS_SpoolImpressaoCitel, strNomImp, strNomPro, strDesPro);
      End;
      Next;

      If (Length(arrLinhasEti) = 0) Then
      Begin
        SetLength(arrLinhasEti, RecordCount-1);
      End;

      While (Not Eof) Do
      Begin

        If cpuCampos <> Nil Then
          FreeAndNil(cpuCampos);

        cpuCampos := TCamposUso.Create;
        cpuCampos.AdicionaCampos(cdsEtiquetas, 'MOVGER');

        strLinha := '';
        For intContador := intColAtu To intQtdCol Do
        Begin

          strNumCol := fStrZero(IntToStr(intContador), 03);
          intNumCol := FieldByName('CNF_COL' + strNumCol).AsInteger;

          intTamLinAnt := Length(arrLinhasEti[intLinhaEti]);
          pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, (intNumCol - intTamLinAnt), qryCnfEti);

          arrLinhasEti[intLinhaEti] := arrLinhasEti[intLinhaEti] + strLinha;
          strLinha := ''; //Se desistir da matriz, tirar essa linha

        End;
        Inc(intLinhaEti);

        {*****************************************}
        {* NEXT NO ARQUIVO DE CNF                *}
        {**************************************MV*}
        Next;

      End;

      intLinhaEti := 0;
      Dec(intQtdEti, (intQtdColOri+1) - intColAtu);

      Inc(intColAtu, intQtdCol);
      If intColAtu >= intQtdColOri+1 Then
      Begin
        pImpArrLinhasEti;
        intColAtu := 1;
      End;

      If cpuCampos <> Nil Then
        FreeAndNil(cpuCampos);

    End;

  End;
  FreeAndNil(qryCnfEti);
end;

procedure TfrmImpEtiDespacho.pLimpar(const blnLimarEdtChave: Boolean);
begin
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
  edtCodCli.Text := EmptyStr;
  edtNomCli.Text := EmptyStr;
  edtNumDoc.Text := EmptyStr;
  edtEspDoc.Text := EmptyStr;
  edtQtdVol.Text := EmptyStr;
  edtQtdVolSepExc.Text  := EmptyStr;
  edtQtdVolSepNExc.Text := EmptyStr;
  edtEtqInicial.Text := '1';

  If blnLimarEdtChave Then
  Begin
    edtChave.Text := EmptyStr;
    pSetFocus(FComponenteFoco);
  End;
end;

procedure TfrmImpEtiDespacho.pImpArrLinhasEti;
  Var
    intContador1: Integer;
    intLength1: Integer;
    blnUltimoReg: Boolean;
    strLinhaAtu: String;
    blnImprime: Boolean;
begin
  strLinhaAtu := '';
  blnUltimoReg := False;
  intLength1 := Length(arrLinhasEti);
  blnImprime := False;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If arrLinhasEti[intContador1] <> '' Then
    Begin
      blnImprime := True;
      Break;
    End;
  End;

  If Not blnImprime Then
    Exit;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If (intContador1 = intLength1-1) Then
      blnUltimoReg := True;

    pEscreveLinha(strArqTxt, AnsiString(arrLinhasEti[intContador1]), blnUltimoReg, strNomImp, strNomPro, strDesPro);
    strLinhaAtu := '';
  End;

  SetLength(arrLinhasEti, 0);
end;

{***********************************}
{ INSERE MASCARA DE TELEFONE        }
{********************************LU*}
{function TfrmImpEtiDespacho.fFormataTelefone(strFone: String): String;
begin
  Result := '';

  If Not fEmptyStr(strFone) Then
  Begin
    Result := Result + '(';
    Result := Result + MidStr(strFone,0,2) + ')';
    Result := Result + MidStr(strFone,3,4) + '-';
    Result := Result + MidStr(strFone,7,4);
  End;

end;}

procedure TfrmImpEtiDespacho.FormCreate(Sender: TObject);
begin

  {Carrega variáveis e objetos}
  untWS_SkyHub.VS_strCodEmp          := untFuncoesSimples.VS_strCodEmp;
  untWS_SkyHub.Database              := frmModulo.GetCurrentConnection;
  untWS_SkyHub.fRetAutoIncrem        := untFuncoesSimples.fRetAutoIncrem;
  untWS_SkyHub.strLoginUsuarioLogado := untFuncoesSimples.strLoginUsuarioLogado;

  inherited;

  blnExpedi := False;
  blnImpEti := False;
  blnImpAut := False;
  strNomFil := '';
  blnUSigep := False;
  strEspPLP := fTransform(fCfgSis('ESPPLP'), 2);
  strSerCor := '';
  blnApenasGerarEtiqueta := False;
  intMarketplaceTimeout := 30;
  tpeResultadoUnificacao := reuNaoAplicavel;
  strMultPed := EmptyStr;

  strBotaoAcionado := '';

  pnlVolumeSepExc.Visible := fCfgSis('SEPEXC', varBoolean);

  blnExibeTelaDigVolumesCompostos := True;
end;

function TfrmImpEtiDespacho.fRetornaCodCliente(out strCodCli: String): Boolean;
  Var
    qryAux: TUniQuery;
    strSQL: String;
    arrRecordFields: TArrRecordFields;
begin
  Result := False;
  strCodCli := EmptyStr;

  qryAux := fCriaQuery;
  Try
    If Pos(edtEspDoc.Text, 'PD_OR_') > 0 Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT CLI_CODCLI CODCLI, CLI_NOMCLI NOMCLI, CLI_FANSOB FANSOB, FGO_DTAENT DTAENT ';
      strSQL := strSQL + 'FROM FATGOR ';
      strSQL := strSQL + 'JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ';
      strSQL := strSQL + 'WHERE FGO_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '  AND FGO_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '  AND FGO_CODEMP = :CODEMP ';

      qryAux.SQL.Add(strSQL);
    End
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT CLI_CODCLI CODCLI, CLI_NOMCLI NOMCLI, CLI_FANSOB FANSOB, GER_DTAENT DTAENT ';
      strSQL := strSQL + 'FROM MOVGER ';
      strSQL := strSQL + 'JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
      strSQL := strSQL + 'WHERE GER_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '  AND GER_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '  AND GER_CODEMP = :CODEMP ';
      strSQL := strSQL + '  AND GER_ORIDOC = "V" ';
      strSQL := strSQL + '  AND GER_TIP_FC = "C" ';

      qryAux.SQL.Add(strSQL);
      qryAux.SQL.Add(' UNION ');
      qryAux.SQL.Add(strSQL.Replace('MOVGER', 'NOTGER'));
    End;

    qryAux.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    qryAux.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      pMensagemOk('Cliente não encontrado para o documento!');
      Exit;
    End;

    If qryAux.RecordCount > 1 Then
    Begin
      SetLength(arrRecordFields, 4);
      arrRecordFields[0].strFieldName    := 'CODCLI';
      arrRecordFields[0].strFieldCaption := 'Código';
      arrRecordFields[0].intWidth        := 60;
      arrRecordFields[1].strFieldName    := 'NOMCLI';
      arrRecordFields[1].strFieldCaption := 'Nome';
      arrRecordFields[1].intWidth        := 220;
      arrRecordFields[2].strFieldName    := 'FANSOB';
      arrRecordFields[2].strFieldCaption := 'Fantasia';
      arrRecordFields[2].intWidth        := 200;
      arrRecordFields[3].strFieldName    := 'DTAENT';
      arrRecordFields[3].strFieldCaption := 'Data Documento';
      arrRecordFields[3].intWidth        := 90;

      If Not TfrmMsgGridGenerica.fMontaGridGenerico(arrRecordFields, qryAux,
                                                    'Selecione o cliente do documento '+ edtNumDoc.Text +'-'+ edtEspDoc.Text +'-'+ edtCodEmp.Text,
                                                    True, True, '&Confirmar', 'C&ancelar', False) Then
        Exit;
    End;

    strCodCli := qryAux.FieldByName('CODCLI').AsString;

    Result := Not strCodCli.IsEmpty;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmImpEtiDespacho.fBuscaPorCodCliente: Boolean;
begin
  Result := False;

  If Not fCfgSis('CLETDS', varBoolean) Then
    Exit;

  If rdgTpDestinatario.ItemIndex <> 0 Then
    Exit;

  Result := True;
end;

function TfrmImpEtiDespacho.fCarregaVolume: String;

  function fVolumePedido: String;
  begin
    Result := FloatToStr( fCampoTabela('FGO_VOLUME', fNomeTabela,
                                      ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                                      [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text]) );
  end;

  function fVolumeVenda(strTabela: String): String;
  begin

    if fBuscaPorCodCliente then
    begin
      Result := FloatToStr( fCampoTabela('GER_VOLUME', strTabela,
                                        ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_ORIDOC', 'GER_CODCLI'],
                                        [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, 'V', edtCodCli.Text]) );
    end
    else
    begin
      Result := FloatToStr( fCampoTabela('GER_VOLUME', strTabela,
                                        ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_ORIDOC'],
                                        [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, 'V']) );
    end;

  end;

  function fTraEnviaCorreio(strCodTra : String) : Boolean;
  Begin
    Result := False;
    If (fCfgSis('USIGEP', varString) = 'A') Then
    Begin
      strSerCor := fCampoTabela('TRA_CODSER', 'CORTRA', ['TRA_CODTRA', 'TRA_CODEMP'], [strCodTra, VS_strCodEmp]);
      Result := strSerCor <> '';
    End
    Else If (fCfgSis('USIGEP', varString) = 'O') Then
    Begin
      strSerCor := fCampoTabela('TRA_TIPETQ', 'CADTRA', ['TRA_CODTRA'], [strCodTra]);
      Result := (Pos(strSerCor, 'C_T_') > 0); //Correio ou Transportadora.
      {************************************************************************************************}
      {* Invés de Pegar o Código do Serviço do Correio, Quando é OffLine pego o Codigo do Fornecedor, *}
      {* pois é de lá que vai sair todas as informaçoes (NUMERO RASTREIO, SIGLA, LAYOUT ETC...)       *}
      {*********************************************************************************************GB*}
      If Result Then
        strSerCor := strCodTra;
    End;

  End;

  function fVendaEnviaCorreio(strTabela: String): Boolean;
  begin
    Result := False;
    If fEmptyStr(strEspPLP) Or ( Pos(edtEspDoc.Text, strEspPLP) > 0 ) Then
    begin
      if fBuscaPorCodCliente then
      begin
        Result := fTraEnviaCorreio( fCampoTabela('GER_CODTRA', strTabela,
                                                ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_ORIDOC', 'GER_CODCLI'],
                                                [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, 'V', edtCodCli.Text]));
      end
      else
      begin
        Result := fTraEnviaCorreio( fCampoTabela('GER_CODTRA', strTabela,
                                                ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_ORIDOC'],
                                                [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, 'V']));
      end;
    end;
  end;

  function fPedidoEnviaCorreio: Boolean;
  begin
    Result := False;
    If fEmptyStr(strEspPLP) Or ( Pos(edtEspDoc.Text, strEspPLP) > 0 ) Then
      Result := fTraEnviaCorreio( fCampoTabela('FGO_CODTRA', fNomeTabela,
                                              ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                                              [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text]) );
  end;

Begin
  If fNomeTabela = 'FATGOR' Then
  Begin
    Result := fVolumePedido;
    If (fCfgSis('USIGEP') <> 'N') Then
      blnUSigep := fPedidoEnviaCorreio;

    If pnlVolumeSepExc.Visible Then
      pCarregaVolumesSepExclusiva('FATGOR');
  End
  Else
  Begin
    Result := fVolumeVenda(fNomeTabela);
    If (fCfgSis('USIGEP') <> 'N') Then
      blnUSigep := fVendaEnviaCorreio(fNomeTabela);

    If (fStrToFloat(Result) = 0) And (Not blnUSigep) Then
    Begin
      Result := fVolumeVenda(AnsiReplaceStr(fNomeTabela, 'MOV', 'NOT'));
      If (fCfgSis('USIGEP') <> 'N') Then
        blnUSigep := fVendaEnviaCorreio(AnsiReplaceStr(fNomeTabela, 'MOV', 'NOT'));

      If pnlVolumeSepExc.Visible Then
        pCarregaVolumesSepExclusiva('NOTGER', 'AUXNOT');
    End
    Else
    Begin
      If pnlVolumeSepExc.Visible Then
        pCarregaVolumesSepExclusiva('MOVGER', 'AUXMOV');
    End;
  End;

  If blnApenasGerarEtiqueta And (strToIntDef(Result, 0) = 0) Then
    Result := '1';
End;


function TfrmImpEtiDespacho.fGetCodigoDaTransportadora: String;
begin
  Result := '';
  if not fEmptyStr(edtNumDoc.Text) and not fEmptyStr(edtCodEmp.Text) and not fEmptyStr(edtEspDoc.Text) then
  Begin
    If fNomeTabela = 'FATGOR' Then
    begin
      Result := fCampoTabela('FGO_CODTRA', fNomeTabela,
                             ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                             [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text])
    end
    Else
    begin
      if fBuscaPorCodCliente then
      begin
        Result := fCampoTabela('GER_CODTRA', fNomeTabela,
                               ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_ORIDOC', 'GER_CODCLI'],
                               [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, 'V', edtCodCli.Text]);
      end
      else
      begin
        Result := fCampoTabela('GER_CODTRA', fNomeTabela,
                               ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_ORIDOC'],
                               [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, 'V']);
      end;
    end;
  End;
end;

function TfrmImpEtiDespacho.fGetDataDocumento: String;
  var
    LData : String;
    LHora : String;
begin
  If fNomeTabela = 'FATGOR' Then
  Begin
    LData := fCampoTabela('FGO_DTAENT', fNomeTabela,
                          ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                          [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text]);

    LHora := fCampoTabela('FGO_HORENT', fNomeTabela,
                          ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                          [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text]);
  End
  Else
  Begin
    if fBuscaPorCodCliente then
    begin
      LData := fCampoTabela('GER_DTAENT', fNomeTabela,
                            ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_ORIDOC', 'GER_CODCLI'],
                            [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, 'V', edtCodCli.Text]);

      LHora := fCampoTabela('GER_HORENT', fNomeTabela,
                            ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_ORIDOC', 'GER_CODCLI'],
                            [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, 'V', edtCodCli.Text]);
    end
    else
    begin
      LData := fCampoTabela('GER_DTAENT', fNomeTabela,
                            ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_ORIDOC'],
                            [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, 'V']);

      LHora := fCampoTabela('GER_HORENT', fNomeTabela,
                            ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_ORIDOC'],
                            [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, 'V']);
    end;
  End;

  Result := LData+' '+LHora;
end;

function TfrmImpEtiDespacho.fGetEtiDesTransportadoraDoc(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: string): string;
var
  strCodTra: string;
begin
  If (fCfgSis('CLETDS', varBoolean)) And (Not fEmptyStr(strCodCli)) Then
    strCodTra := fCampoTabela('GER_CODTRA', 'MOVGER', ['GER_NUMDOC','GER_ESPDOC','GER_CODEMP','GER_TIP_FC', 'GER_ORIDOC', 'GER_CODCLI'],[strNumDoc, strEspDoc, strCodEmp, 'C', 'V', strCodCli], False)
  Else
    strCodTra := fCampoTabela('GER_CODTRA', 'MOVGER', ['GER_NUMDOC','GER_ESPDOC','GER_CODEMP','GER_TIP_FC', 'GER_ORIDOC'],[strNumDoc, strEspDoc, strCodEmp, 'C', 'V'], False);

  Result := fCampoTabela('TRA_ETIDES', 'CADTRA', ['TRA_CODTRA'], [strCodTra], False);
end;

function TfrmImpEtiDespacho.fGetIntegrarComJadlog: Boolean;
var
  LblnTransportadoraIntegraComJadlog : Boolean;
  LstrCodigoTransportadora : String;
begin
  Result := False;

  LstrCodigoTransportadora := fGetCodigoDaTransportadora;

  if not fEmptyStr(LstrCodigoTransportadora) then
  begin
    LblnTransportadoraIntegraComJadlog := fCampoTabela('TRA_ETIDES', 'CADTRA', ['TRA_CODTRA'], [LstrCodigoTransportadora]) = 'JADLOG';

    if (LblnTransportadoraIntegraComJadlog) and (fCfgSis('USAJAD', varBoolean)) then
      Result := True;
  end;
end;

function TfrmImpEtiDespacho.fGetIntegrarComMandae: Boolean;
  var
    LblnTransportadoraIntegraComMandae : Boolean;
    LstrCodigoTransportadora : String;
begin
  Result := False;

  LstrCodigoTransportadora := fGetCodigoDaTransportadora;

  if not fEmptyStr(LstrCodigoTransportadora) then
  Begin
    LblnTransportadoraIntegraComMandae := fCampoTabela('TRA_ETIDES', 'CADTRA', ['TRA_CODTRA'], [LstrCodigoTransportadora]) = 'MANDAE';

    if (LblnTransportadoraIntegraComMandae) And
       (fCfgSis('MANUSA', varBoolean)) And
       (fEmptyStr(fCfgSis('MANESP')) or (Pos(edtEspDoc.Text, fTransform(fCfgSis('MANESP'), 2)) > 0)) then
      Result := True;
  End;

end;

function TfrmImpEtiDespacho.fGetIntegrarComIntelipost : Boolean;
var
  LblnTransportadoraIntegraComIntelipost: Boolean;
  LstrCodigoTransportadora: String;
  Pedido: untWS_SkyHub.TDocumento;
begin
  Result := False;

  LstrCodigoTransportadora := fGetCodigoDaTransportadora;

  if not fEmptyStr(LstrCodigoTransportadora) then
  Begin
    LblnTransportadoraIntegraComIntelipost := fCampoTabela('TRA_ITPUSA', 'CADTRA', ['TRA_CODTRA'], [LstrCodigoTransportadora]) = 'S';

    Result := ((LblnTransportadoraIntegraComIntelipost) And (fCfgSis('ITPUTI', varBoolean)));
  End;

  if (Result) and (edtEspDoc.Text = 'PD') then
    Result := TIntelipostShipmentOrder.fPedidoTemProcessamentoIntelipost(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text)
  else if (Result) and (edtEspDoc.Text = 'NF') then
  begin
    Pedido := RetornaPedidoDocumentoVenda(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text);
    Result := TIntelipostShipmentOrder.fPedidoTemProcessamentoIntelipost(Pedido.strNumDoc, Pedido.strEspDoc, Pedido.strCodEmp);
  end;
end;

function TfrmImpEtiDespacho.fIncluiAtualizaVolumesCorreios(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intContador,
    intQtdVol   : Integer;
    blnEnviado  : Boolean;
    strDiverg, strJsonEnv, strJsonRet, strIdPost, strNumObj: String;
    blnPossuiChaAce: Boolean;
    strCodCli: String;
    strRastreios: String;
    blnFalhou: Boolean;
Begin
  blnFalhou := False;

  strDiverg :=  fDivergenciasEndereco(edtNumDoc.Text, edtEspDoc.Text);
  If not fEmptyStr(strDiverg) Then
  Begin
    Result := fMensagem('', IfThen(Pos('ENDCLI',strDiverg) > 0 ,'O endereço do cliente possui mais de 50 caracteres.' + #13, '') +
                            IfThen(Pos('ENDCOM',strDiverg) > 0 ,'O complemento do cliente possui mais de 30 caracteres.' + #13, '') +
                            IfThen(Pos('BAICLI',strDiverg) > 0 ,'O bairro do cliente possui mais de 30 caracteres.' + #13, '') +
                            IfThen(Pos('FONCLI',strDiverg) > 0 ,'O telefone do cliente possui mais de 11 caracteres.' + #13, '') +
                            'Favor corrigir, caso contrário será rejeitado na geração da PLP', ['&Ok']) = -1;
    Exit;
  End
  Else
  If fDocumentoEmPLP(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, blnEnviado, intQtdVol) Then
  Begin
    If blnEnviado Then
    Begin
      Result := fMensagem('', 'Documento já Incluido em uma Pré Lista de Postagem Enviada!' +#13+
                              'Só é possível reimprimir as etiquetas geradas, Deseja continuar?', ['&Sim', '&Não']) = 1;
      Exit;
    End
    Else
      //Remove e inseri novamente, pois pode ter trocado o endereço e precisa gerar
      //o DATA2D novamente;
      pRemoveDocumentoAndLiberaObjetos(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text);
  End;

  If (Not fBuscaPorCodCliente) And fEmptyStr(edtCodCli.Text) Then
  Begin
    If Not fRetornaCodCliente(strCodCli) Then
      Exit(False);

    edtCodCli.Text := strCodCli;
  End;

  If (edtEspDoc.Text <> 'PD') And (fCfgSis('USIGEP') = 'A') Then
  Begin
    For intContador := 1 To 10 Do
    Begin
      blnPossuiChaAce := fRetChaveAcesso(edtNumDoc.Text, edtEspDoc.Text, edtCodCli.Text, edtCodEmp.Text) <> '';

      If blnPossuiChaAce Then
        Break;

      Sleep(1000);
    End;

    If Not blnPossuiChaAce Then
    Begin
      pMensagemOk('Não foi possível obter a chave de acesso do documento para geração da etiqueta dos Correios. Tente imprimir novamente mais tarde.');
      Exit(False);
    End;
  End;

  Try
    pgbProgresso.Visible := True;
    pgbProgresso.Properties.Max := StrToInt(edtQtdVol.Text);
    strRastreios := '';

    fStartTransaction;

    For intContador := 1 To StrToInt(edtQtdVol.Text) Do
    Begin
      pStepStatusGravacao(pgbProgresso);

      strJsonEnv := '';
      strJsonRet := '';
      strIdPost  := '';
      strNumObj  := '';

      If fCfgSis('USIGEP') = 'A' Then
      Begin
        try
          If Not fEnviaPreListaPostagem(edtNumDoc.Text,
                                        edtEspDoc.Text,
                                        edtCodEmp.Text,
                                        edtCodCli.Text,
                                        fSerCorToCodCorreio(strSerCor),
                                        StrToInt(edtQtdVol.Text),
                                        strJsonEnv,
                                        strJsonRet,
                                        strIdPost,
                                        strNumObj) Then
          Begin
            blnFalhou := True;
            Break;
          End;
        except
          on E: Exception do
            raise Exception.Create('Não foi possível gerar a Pré Lista de Postagem! '+ E.Message);
        end;

        If (fEmptyStr(strRastreios)) Then
          strRastreios := strNumObj
        Else
          strRastreios := strRastreios + ', ' + strNumObj;
      End;

      If Not fIncluiDocPLP(edtNumDoc.Text,
                           edtEspDoc.Text,
                           edtCodEmp.Text,
                           strSerCor,
                           strJsonEnv,
                           strJsonRet,
                           strIdPost,
                           strNumObj,
                           intContador,
                           False) Then
      Begin
        fRollBack;
        blnFalhou := True;
        fMensagem('', 'Não foi possível incluir documento na Pré Lista de Postagem!', ['&OK']);
        Break;
      End;
    End;

    If blnFalhou Then
    Begin
      fRollBack;
      Exit(False);
    End;

    Result := fCommit;
  Except
    On E : Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  If (Result) And (Not fEmptyStr(strRastreios)) Then
  Begin
    Try
      fDisparaEmailAutomatico(edtNumDoc.Text,
                              'RE',
                              edtEspDoc.Text,
                              '',
                              'ERC',
                              edtCodEmp.Text,
                              edtCodCli.Text,
                              '',
                              '',
                              Nil,
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              False,
                              False,
                              True,
                              '',
                              strRastreios);

      fDisparaWhatsappAutomatico(edtNumDoc.Text,
                                  'RE',
                                  edtEspDoc.Text,
                                  '',
                                  'ERC',
                                  edtCodEmp.Text,
                                  edtCodCli.Text,
                                  '',
                                  True,
                                  '',
                                  Nil,
                                  '',
                                  '',
                                  '',
                                  Self.UnitName,
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  False,
                                  False,
                                  nil,
                                  '',
                                  '',
                                  nil,
                                  '',
                                  strRastreios);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[fIncluiAtualizaVolumesCorreios - Disparo Rastreio]');
    End;
  End;
End;

function TfrmImpEtiDespacho.fNomeTabela: String;
begin
  If Pos(edtEspDoc.Text, 'PD_OR_') > 0 Then
    Result := 'FATGOR'
  Else If Pos(edtEspDoc.Text, 'NF_EL_IF_IV_D1_MI_FF_TE_TR_BR_UC') > 0 Then
    Result := 'MOVGER';
end;

function TfrmImpEtiDespacho.fClienteInformadoEhDoDocumento: Boolean;
begin

  result := false;

  if (fNomeTabela = 'FATGOR') then
  begin
    result := fCampoTabela('COUNT(*) AS QTD', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP', 'FGO_CODCLI'],
                                                   [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text]);
  end;

  if (fNomeTabela = 'MOVGER') then
  begin
    result := fCampoTabela('COUNT(*) AS QTD', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_CODCLI'],
                                                   [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text]);
  end;

  {****************************************************************************}
  { ACRESCENTADA ESSSA VERIFICAÇÃO PARA A NOTGER PELA NECESSIDADE DE VERIFICAR }
  { INCLUSIVE EMISSÃO DE NOTA "REMESSA POR CONTA E ORDEM".                     }
  {*************************************************************** Req: 188730 }
  if not result then
  begin
    result := fCampoTabela('COUNT(*) AS QTD', 'NOTGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_CODCLI'],
                                                   [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text]);
  end;

end;

function TfrmImpEtiDespacho.fEhTransportadoraMercadoLivre(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: string): Boolean;
begin
  Result := fGetEtiDesTransportadoraDoc(strNumDoc, strEspDoc, strCodEmp, strCodCli) = 'MERCADO LIVRE';
end;

function TfrmImpEtiDespacho.fEhTransportadoraAmazon(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: string): Boolean;
begin
  Result := fGetEtiDesTransportadoraDoc(strNumDoc, strEspDoc, strCodEmp, strCodCli) = 'AMAZON';
end;

function TfrmImpEtiDespacho.fEhTransportadoraMagalu(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: string): Boolean;
begin
  Result := fGetEtiDesTransportadoraDoc(strNumDoc, strEspDoc, strCodEmp, strCodCli) = 'MAGALU';
end;

function TfrmImpEtiDespacho.fEhTransportadoraShopee(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: string): Boolean;
begin
  Result := fGetEtiDesTransportadoraDoc(strNumDoc, strEspDoc, strCodEmp, strCodCli) = 'SHOPEE';
end;

function TfrmImpEtiDespacho.fEhTransportadoraTikTok(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: string): Boolean;
begin
  Result := fGetEtiDesTransportadoraDoc(strNumDoc, strEspDoc, strCodEmp, strCodCli) = 'TIKTOK';
end;

function TfrmImpEtiDespacho.fEhTransportadoraViaVarejo(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: string): Boolean;
begin
  Result := fGetEtiDesTransportadoraDoc(strNumDoc, strEspDoc, strCodEmp, strCodCli) = 'VIA VAREJO';
end;

function TfrmImpEtiDespacho.fEhTransportadoraOlist(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: string): Boolean;
begin
  Result := fGetEtiDesTransportadoraDoc(strNumDoc, strEspDoc, strCodEmp, strCodCli) = 'OLIST';
end;

function TfrmImpEtiDespacho.fTemRegistroSelecionado: boolean;
begin
  result := false;
  cdsCaixas.First;
  while not cdsCaixas.eof do
  begin
    if cdsCaixas.FieldByName('FGC_IMPRIM').AsBoolean then
    begin
      result := true;
      exit;
    end;
    cdsCaixas.next;
  end;
end;

function TfrmImpEtiDespacho.fTotCaixaSelec: Integer;
begin
  Result := 0;
  cdsCaixas.First;
  while not cdsCaixas.Eof do
  Begin
    if cdsCaixas.FieldByName('FGC_IMPRIM').AsBoolean then
    Begin
      Inc(Result);
    End;
    cdsCaixas.Next
  End;
end;

function TfrmImpEtiDespacho.fEtiquetaDeDespachoDiferenteParaFaturamentoDePedido: boolean;
begin
  Result := False;

  If (fCfgSis('TIPEXP', varInteger) <> 4) Then
    Exit;

  If (Not fCfgSis('ETQDIF', varBoolean)) Then
    Exit;

  If (not fValidaModeloEtiquetaDespacho) Then
    Exit;

  Result := True;
end;

function TfrmImpEtiDespacho.fValidaModeloEtiquetaDespacho: boolean;
begin
  Result := ((strBotaoAcionado = 'F11') or
             ((not blnExpedi) and (fEmptyStr(strBotaoAcionado)) and (fMensagem('', 'Deseja imprimir a etiqueta de Despacho Faturar Expedido?', ['&Sim', '&Não'], 2) = 1)));
end;

end.
