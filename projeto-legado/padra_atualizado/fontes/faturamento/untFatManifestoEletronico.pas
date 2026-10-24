unit untFatManifestoEletronico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, untPaiOrdena, DB,
  UniDataSetProvider, AppEvnts,
  Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids,
  DBGridCitel, DBGrids, Buttons, BitBtnLockedIncrem, ExtCtrls, StrUtils, UniClientDataSet,
  Uni, MemDS, DBAccess, Datasnap.DBClient, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade, untTypesSistema, untFuncoesConsulta, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxCheckBox, MemoFocus, cxGroupBox, cxRadioGroup;

type
  TfrmFatManifestoEletronico = class(TfrmPaiOrdena)
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    Label2: TLabel;
    Label3: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    lblCodEmp: TLabel;
    Label1: TLabel;
    edtPercurso: TEditFocus;
    shpEmp: TShape;
    chkCarPos: TcxCheckBox;
    pnlInformacoes: TPanel;
    rdgTipoDocumento: TcxRadioGroup;
    Label5: TLabel;
    edtNumRom: TEditFocus;
    pnlFiltroRotaRegiao: TPanel;
    lblCodReg: TLabel;
    edtCodRot: TEditFocus;
    rdgNotas: TRadioGroup;
    rdgInformacaoDeDestino: TRadioGroup;
    lblMunicipioDestino: TLabel;
    edtCodCidDestino: TEditFocus;
    edtNomCidDestino: TEditFocus;
    edtUFDestino: TEditFocus;
    lblUFDestino: TLabel;
    grbInformacoes: TGroupBox;
    memoInformacoes: TMemoFocus;
    grbOriDoc: TGroupBox;
    chkDocOriVen: TCheckBox;
    chkDocOriDev: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure chkCarPosClick(Sender: TObject);
    procedure rdgTipoDocumentoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtNumRomKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRotKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidDestinoExit(Sender: TObject);
    procedure edtCodCidDestinoKeyPress(Sender: TObject; var Key: Char);
    procedure rdgInformacaoDeDestinoClick(Sender: TObject);
    procedure edtUFDestinoKeyPress(Sender: TObject; var Key: Char);
    procedure rdgNotasClick(Sender: TObject);
  private
    blnLibEmp        : Boolean;
    blnRegCid        : Boolean;
    strEmpresa       : String;
    arrEmpresa       : TConsultasArray;
    intTipoDocumento : Integer;
    arrCidade        : TConsultasArray;

    InformacaoDeDestinoManifestoEletronico : TInformacaoDeDestinoManifestoEletronico;
    procedure pSetInformacaoDeDestinoDefault;
    procedure pSetInformacaoDeDestino;

    procedure pRetornaMotorista(stlCodMot: TStringList; Var strPlaVei, strPlaVeiReboque: String; var blnReboque: Boolean);

    function fAtualizarDocumentosManifesto(const stlCodMot: TStringList;
                                                 strPlaca,
                                                 strPlacaReboque,
                                                 strPercurso,
                                                 strUFDestino: String;
                                                 cdsSegCar,
                                                 cdsSegCarAver,
                                                 cdsInfc,
                                                 cdsProPre,
                                                 cdsMDFPAG,
                                                 cdsMDFCOM,
                                                 cdsMDFPRA,
                                                 cdsMDFPRO : TUniClientDataSet;
                                                 strCodCidDestino : String): String;

    procedure pFiltrar(Var cdsClient : TUniClientDataSet;
                           intSeqPag : Integer);

    procedure pEnviarManifesto(const strNumMan: String);
    procedure pCarregaFila(const strNomPro: String; var strNomeFila, strTipImp: String);
    procedure pLimparTela;

    function fManifestoUfDiferentes: Boolean;
    function fManifestoPendenteEncerramento(strPlaca, strPlacaReboque: String): Boolean;
    function fCriaCdsInfc(cmpSelf: TComponent): TUniClientDataSet;
    function fGetSqlNFe: string;
    function fGetSqlCTe: string;
    procedure pPesquisar;

    function fValidaRota(strCodRot: String): Boolean;
    function fValidaEstadosdaRota(strPercurso : String): Boolean;
    function fUfEmRotaManifestoAnterior(strPlaca, strPlacaReboque: String): Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    procedure pAcaoAdd; Override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untDigMotorista, untLibNfe, untFatManifestoEletronicoSeguroCarga,
  untConsultas, untRomGer, untValidacoesRotasRegiao;

{ TfrmFatManifestoEletronico }

procedure TfrmFatManifestoEletronico.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pDesmarcaTodos;
end;

procedure TfrmFatManifestoEletronico.btnGravarClick(Sender: TObject);
Var
  strNumMan : String;
  stlCodMot : TStringList;
  strPlaca  : String;
  strPlacaReboque: string;
  blnReboque: Boolean;
  cdsMDFPRO     : TUniClientDataSet;
  cdsProPre     : TUniClientDataSet;
  cdsSegCar     : TUniClientDataSet;
  cdsSegCarAver : TUniClientDataSet;
  cdsInfc       : TUniClientDataSet;
  cdsMDFPAG     : TUniClientDataSet;
  cdsMDFCOM     : TUniClientDataSet;
  cdsMDFPRA     : TUniClientDataSet;

  function fValidaPercuso: Boolean;
  begin
    Result := False;

    If not pnlTail.Visible Then
      Exit;

    If fEmptyStr(edtPercurso.Text) Then
      Exit;

    If fEmptyStr(edtUFDestino.Text) Then
      Exit;

    If not (fRetUFEmpresa(edtCodEmp.Text) = edtUFDestino.Text) Then
      Exit;

    Result := True;
  end;

begin

  inherited;

  If stlListSelecao.Count <= 0 Then
  Begin
    pMensagemOk('É necessário selecionar pelo menos 1 documento para a emissão do manifesto.');
    Exit;
  End;

  if chkCarPos.Checked then
  begin
    edtCodCidDestino.Text := cdsConsulta.FieldByName('CODCID').AsString;
    edtUFDestino.Text     := cdsConsulta.FieldByName('EMP_UF').AsString;
    edtPercurso.Text      := '';
  end;

  If (InformacaoDeDestinoManifestoEletronico = tidInformadoEmCadaNF) Then
  Begin

    If fEmptyStr(edtUFDestino.Text) Then
    Begin
      pMensagemOk('Informe a UF de Destino.');
      pSetFocus(edtUFDestino);
      Exit;
    End

    Else If not fValidaEstado(edtUFDestino.Text) Then
    Begin
      pMensagemOk('UF de Destino inválida.');
      pSetFocus(edtUFDestino);
      Exit;
    End;

    If fManifestoUfDiferentes Then
    Begin
      pMensagemOk('Não é permitido enviar um manifesto eletrônico para UFs diferentes.' + sLineBreak +
                  'Deve-se levar em consideração as UFs de descarregamento para quantificar o número de manifestos eletrônicos a serem emitidos.');
      Exit;
    End;

  End

  Else If (InformacaoDeDestinoManifestoEletronico = tidDestinoUnico) Then
  Begin

    If fEmptyStr(edtCodCidDestino.Text) Then
    Begin
      pMensagemOk('Informe o Município de Destino.');
      pSetFocus(edtCodCidDestino);
      Exit;
    End;

  End;

  If fValidaPercuso Then
  Begin
    pMensagemOk('Não informe o percurso se as UFs de origem e destino forem iguais.'+#13+
                'Limpe o campo percurso antes de prosseguir com a emissão do manifesto.');
    pSetFocus(edtPercurso);
    Exit;
  End;

  stlCodMot := TStringList.Create;
  try
    pRetornaMotorista(stlCodMot, strPlaca, strPlacaReboque, blnReboque);
    If ((stlCodMot.Count = 0) Or fEmptyStr(strPlaca)) or (blnReboque and fEmptyStr(strPlacaReboque)) Then
      Exit;

    If fManifestoPendenteEncerramento(strPlaca, IIF(blnReboque, strPlacaReboque, '')) Then
    Begin
      if not fUfEmRotaManifestoAnterior(strPlaca, IIF(blnReboque, strPlacaReboque, '')) then
      begin
        if fMensagem('AVISO', 'Há manifestos não encerrados/pendentes para esta placa na UF selecionada.' + sLineBreak +
                  'A UF selecionada não consta no percurso dos manifestos já existentes.'  + sLineBreak +
                  'Confirma a Emissão do Manifesto?', ['&Sim', '&Não'], 2) = 2 then
        Exit;
      end;
    End;

    If Not fValidaUFsPercurso(edtPercurso.Text) Then
      Exit;

    chkCarPos.Enabled := False;

    pCriarFormularios(TfrmFatManifestoEletronicoSeguroCarga, frmFatManifestoEletronicoSeguroCarga);

    Try

      frmFatManifestoEletronicoSeguroCarga.ShowModal;
      While (frmFatManifestoEletronicoSeguroCarga.ModalResult = mrRetry) Do
        frmFatManifestoEletronicoSeguroCarga.ShowModal;

      If (frmFatManifestoEletronicoSeguroCarga.ModalResult = mrOk) and
         (fMensagem('', 'Confirma a Emissão do Manifesto?', ['&Sim', '&Não'], 2) = 1) Then
      Begin

        cdsSegCar     := TUniClientDataSet.Create(Self);
        cdsSegCarAver := TUniClientDataSet.Create(Self);
        cdsMDFPRO     := TUniClientDataSet.Create(Self);
        cdsProPre     := TUniClientDataSet.Create(Self);

        cdsMDFPAG     := TUniClientDataSet.Create(Self);
        cdsMDFCOM     := TUniClientDataSet.Create(Self);
        cdsMDFPRA     := TUniClientDataSet.Create(Self);

        pCloneDataSet(cdsSegCar,     frmFatManifestoEletronicoSeguroCarga.cdsSegCar);
        pCloneDataSet(cdsSegCarAver, frmFatManifestoEletronicoSeguroCarga.cdsSegCarAver);
        pCloneDataSet(cdsMDFPRO,     frmFatManifestoEletronicoSeguroCarga.cdsMdfPro);
        pCloneDataSet(cdsProPre,     frmFatManifestoEletronicoSeguroCarga.cdsProPre);

        pCloneDataSet(cdsMDFPAG, frmFatManifestoEletronicoSeguroCarga.cdsMDFPAG);
        pCloneDataSet(cdsMDFCOM, frmFatManifestoEletronicoSeguroCarga.cdsMDFCOM);
        pCloneDataSet(cdsMDFPRA, frmFatManifestoEletronicoSeguroCarga.cdsMDFPRA);

      End
      Else
      Begin

        cdsSegCar     := Nil;
        cdsSegCarAver := Nil;
        cdsMDFPRO     := Nil;
        cdsProPre     := Nil;

        cdsMDFPAG     := Nil;
        cdsMDFCOM     := Nil;
        cdsMDFPRA     := Nil;

        Exit;

      End;

      If Not fEmptyStr(fTrimAll(memoInformacoes.text)) Then
      Begin

        cdsInfc := fCriaCdsInfc(self);
        cdsInfc.Open;
        cdsInfc.Append;
        cdsInfc.FieldByName('MDF_INFCOM').AsString := StringReplace(memoInformacoes.Text, #$D#$A, '', [rfReplaceAll]);
        cdsInfc.FieldByName('MDF_SEQGER').AsString := fRetiraQuotedLista(stlListSelecao.Strings[0]);
        cdsInfc.Post;

      End
      Else
        cdsInfc := Nil;

      strNumMan := fAtualizarDocumentosManifesto(stlCodMot,
                                                 strPlaca,
                                                 IIF(blnReboque, strPlacaReboque, ''),
                                                 edtPercurso.Text,
                                                 edtUFDestino.Text,
                                                 cdsSegCar,
                                                 cdsSegCarAver,
                                                 cdsInfc,
                                                 cdsProPre,
                                                 cdsMDFPAG,
                                                 cdsMDFCOM,
                                                 cdsMDFPRA,
                                                 cdsMDFPRO,
                                                 edtCodCidDestino.Text);

    Finally

      pFreeAndNil(frmFatManifestoEletronicoSeguroCarga);

      If Assigned(cdsSegCar) Then
        FreeAndNil(cdsSegCar);

      If Assigned(cdsSegCarAver) Then
        FreeAndNil(cdsSegCarAver);

      If Assigned(cdsMDFPRO) Then
        FreeAndNil(cdsMDFPRO);

      If Assigned(cdsProPre) Then
        FreeAndNil(cdsProPre);

      If Assigned(cdsMDFPAG) Then
        FreeAndNil(cdsMDFPAG);

      If Assigned(cdsMDFCOM) Then
        FreeAndNil(cdsMDFCOM);

      If Assigned(cdsMDFPRA) Then
        FreeAndNil(cdsMDFPRA);

      If Assigned(cdsInfc) Then
        FreeAndNil(cdsInfc);

    End;
  finally
    stlCodMot.Free;
  end;

  If Not fEmptyStr(strNumMan) Then
  Begin

    Try

      pEnviarManifesto(strNumMan);

      pMensagemOk('Manifesto enviado com sucesso. Aguarde a autorização no PainelNFe.');
      chkCarPos.Enabled := True;

    Except

      On E: Exception Do
      Begin
        chkCarPos.Enabled := True;
        pMensagemOk('Manifesto não gerado. Por favor verifique o erro no PainelNFe.');
        pMensagensErro(E.Message, '[btnGravarClick]');
      End;

    End;

  End;

  pLimparTela;

end;

function TfrmFatManifestoEletronico.fManifestoUfDiferentes: Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('  SELECT                                                                                         ');
  qryAux.SQL.Add('    COUNT(DISTINCT CD.CID_ESTADO) AS QTD                                                         ');
  qryAux.SQL.Add('  FROM                                                                                           ');
  qryAux.SQL.Add('  (                                                                                              ');
  qryAux.SQL.Add('    SELECT                                                                                       ');
  qryAux.SQL.Add('      CF.AUTOINCREM,                                                                             ');
  qryAux.SQL.Add('      CF.FIS_ESTADO,                                                                             ');
  qryAux.SQL.Add('      CD.CID_ESTADO,                                                                             ');
  qryAux.SQL.Add('      AM.AUX_VENPRE                                                                              ');
  qryAux.SQL.Add('    FROM                                                                                         ');
  qryAux.SQL.Add('      CADFIS CF                                                                                  ');
  qryAux.SQL.Add('    LEFT JOIN                                                                                    ');
  qryAux.SQL.Add('      CADCLI CC ON CC.CLI_CODCLI = CF.FIS_FORCLI AND                                             ');
  qryAux.SQL.Add('                   CF.FIS_TIP_FC = "C"                                                           ');
  qryAux.SQL.Add('    LEFT JOIN                                                                                    ');
  qryAux.SQL.Add('      CADFOR CFR ON CFR.FOR_CODFOR = CF.FIS_FORCLI AND                                           ');
  qryAux.SQL.Add('                    CF.FIS_TIP_FC = "F"                                                          ');
  qryAux.SQL.Add('    JOIN                                                                                         ');
  qryAux.SQL.Add('      MOVGER MG ON MG.GER_NUMDOC = CF.FIS_NUMDOC AND                                             ');
  qryAux.SQL.Add('                   MG.GER_ESPDOC = CF.FIS_ESPDOC AND                                             ');
  qryAux.SQL.Add('                   MG.GER_CODEMP = CF.FIS_CODEMP AND                                             ');
  qryAux.SQL.Add('                   MG.GER_TIP_FC = CF.FIS_TIP_FC AND                                             ');
  qryAux.SQL.Add('                   MG.GER_ORIDOC = CF.FIS_ORIDOC AND                                             ');
  qryAux.SQL.Add('                   IFNULL(MG.GER_CODCLI, MG.GER_CODFOR) = CF.FIS_FORCLI AND                      ');
  qryAux.SQL.Add('                   IFNULL(MG.GER_SERIE_, "") = IFNULL(CF.FIS_SERIE_, "")                         ');
  qryAux.SQL.Add('    LEFT JOIN                                                                                    ');
  qryAux.SQL.Add('      AUXMOV AM ON AM.AUX_SEQGER = MG.AUTOINCREM                                                 ');
  qryAux.SQL.Add('    LEFT JOIN                                                                                    ');
  qryAux.SQL.Add('      ENTCLI EC ON AM.AUX_ENTGER = EC.AUTOINCREM AND                                             ');
  qryAux.SQL.Add('                   EC.ETC_CODCLI = IFNULL(MG.GER_CODCLI, NULL)                                   ');
  qryAux.SQL.Add('    LEFT JOIN                                                                                    ');
  qryAux.SQL.Add('      CADCID CD ON CD.CID_CODCID = IFNULL(EC.ETC_CIDENT, IFNULL(CC.CLI_CODCID, CFR.FOR_CODCID))  ');
  qryAux.SQL.Add('    WHERE CF.AUTOINCREM IN (' + stlListSelecao.CommaText + ')                                    ');
  qryAux.SQL.Add('                                                                                                 ');
  qryAux.SQL.Add('    UNION ALL                                                                                    ');
  qryAux.SQL.Add('                                                                                                 ');
  qryAux.SQL.Add('    SELECT                                                                                       ');
  qryAux.SQL.Add('      CF.AUTOINCREM,                                                                             ');
  qryAux.SQL.Add('      CF.FIS_ESTADO,                                                                             ');
  qryAux.SQL.Add('      CD.CID_ESTADO,                                                                             ');
  qryAux.SQL.Add('      AN.AUX_VENPRE                                                                              ');
  qryAux.SQL.Add('    FROM                                                                                         ');
  qryAux.SQL.Add('      CADFIS CF                                                                                  ');
  qryAux.SQL.Add('    LEFT JOIN                                                                                    ');
  qryAux.SQL.Add('      CADCLI CC ON CC.CLI_CODCLI = CF.FIS_FORCLI AND                                             ');
  qryAux.SQL.Add('                   CF.FIS_TIP_FC = "C"                                                           ');
  qryAux.SQL.Add('    LEFT JOIN                                                                                    ');
  qryAux.SQL.Add('      CADFOR CFR ON CFR.FOR_CODFOR = CF.FIS_FORCLI AND                                           ');
  qryAux.SQL.Add('                    CF.FIS_TIP_FC = "F"                                                          ');
  qryAux.SQL.Add('    JOIN                                                                                         ');
  qryAux.SQL.Add('      NOTGER NG ON NG.GER_NUMDOC = CF.FIS_NUMDOC AND                                             ');
  qryAux.SQL.Add('                   NG.GER_ESPDOC = CF.FIS_ESPDOC AND                                             ');
  qryAux.SQL.Add('                   NG.GER_CODEMP = CF.FIS_CODEMP AND                                             ');
  qryAux.SQL.Add('                   NG.GER_TIP_FC = CF.FIS_TIP_FC AND                                             ');
  qryAux.SQL.Add('                   NG.GER_ORIDOC = CF.FIS_ORIDOC AND                                             ');
  qryAux.SQL.Add('                   IFNULL(NG.GER_CODCLI, NG.GER_CODFOR) = CF.FIS_FORCLI AND                      ');
  qryAux.SQL.Add('                   IFNULL(NG.GER_SERIE_, "") = IFNULL(CF.FIS_SERIE_, "")                         ');
  qryAux.SQL.Add('    LEFT JOIN                                                                                    ');
  qryAux.SQL.Add('      AUXNOT AN ON AN.AUX_SEQGER = NG.AUTOINCREM                                                 ');
  qryAux.SQL.Add('    LEFT JOIN                                                                                    ');
  qryAux.SQL.Add('      ENTCLI EC ON AN.AUX_ENTGER = EC.AUTOINCREM AND                                             ');
  qryAux.SQL.Add('                   EC.ETC_CODCLI = IFNULL(NG.GER_CODCLI, NULL)                                   ');
  qryAux.SQL.Add('    LEFT JOIN                                                                                    ');
  qryAux.SQL.Add('      CADCID CD ON CD.CID_CODCID = IFNULL(EC.ETC_CIDENT, IFNULL(CC.CLI_CODCID, CFR.FOR_CODCID))  ');
  qryAux.SQL.Add('    WHERE CF.AUTOINCREM IN (' + stlListSelecao.CommaText + ')                                    ');
  qryAux.SQL.Add('  ) CD                                                                                           ');

  qryAux.Open;

  Result := (qryAux.FieldByName('QTD').AsInteger > 1);

  FreeAndNil(qryAux);
end;

function TfrmFatManifestoEletronico.fManifestoPendenteEncerramento(strPlaca, strPlacaReboque: String): Boolean;
  Var
    qryAux: TUniQuery;
    strUf: String;
begin
  cdsConsulta.Locate('AUTOINCREM', stlListSelecao[0], []);
  strUf := cdsConsulta.FieldByName('ESTADO').AsString;

  qryAux := fCriaQuery(Self);
  try
    qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM CADFIS ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  FIS_ESTADO = :ESTADO AND ');
    qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  (FIS_PLAMAN = :PLAMAN ');
    if not fEmptyStr(strPlacaReboque) then
      qryAux.SQL.Add('  OR FIS_PLAMA2 = :PLAMA2 ');

    qryAux.SQL.Add('  ) AND FIS_ENCERR IS NULL ');

    qryAux.ParamByName('ESTADO').AsString := strUf;
    qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryAux.ParamByName('PLAMAN').AsString := strPlaca;
    if not fEmptyStr(strPlacaReboque) then
      qryAux.ParamByName('PLAMA2').AsString := strPlacaReboque;
    qryAux.Open;

    Result := (qryAux.FieldByName('QTD').AsInteger > 0);
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmFatManifestoEletronico.pRetornaMotorista(stlCodMot: TStringList; Var strPlaVei, strPlaVeiReboque: String; var blnReboque: Boolean);
begin
  stlCodMot.Clear;
  strPlaVei := '';
  pCriarFormularios(TfrmDigMotorista, frmDigMotorista);
  Try
    frmDigMotorista.blnObrigatorio := True;

    If Not fEmptyStr(edtNumRom.Text) Then
    Begin
      frmDigMotorista.edtCodMot.Text := cdsConsulta.FieldByName('CODMOT').AsString;
      frmDigMotorista.mskPlaVei.Text := cdsConsulta.FieldByName('PLAVEI').AsString;
    End;

    If frmDigMotorista.ShowModal = mrOk Then
    Begin
      frmDigMotorista.cdsGrid.First;
      while not frmDigMotorista.cdsGrid.Eof do
      begin
        stlCodMot.Add(frmDigMotorista.cdsGrid.FieldByName('MOT_CODMOT').AsString);
        frmDigMotorista.cdsGrid.Next;
      end;

      strPlaVei := frmDigMotorista.mskPlaVei.Text;
      blnReboque := frmDigMotorista.chkReboque.Checked;
      strPlaVeiReboque := frmDigMotorista.mskPlaVeiReboque.Text;
    End;
  Finally
    pFreeAndNil(frmDigMotorista);
  End;
end;

procedure TfrmFatManifestoEletronico.pSetInformacaoDeDestino;
begin

  InformacaoDeDestinoManifestoEletronico.SetValue(rdgInformacaoDeDestino.ItemIndex);

  edtCodCidDestino.Clear;
  edtNomCidDestino.Clear;
  edtUFDestino.Clear;

  If (InformacaoDeDestinoManifestoEletronico = tidInformadoEmCadaNF) Then
  Begin
    pDisableEdit(edtCodCidDestino);
    pDisableEdit(edtNomCidDestino);
    pEnabledEdit(edtUFDestino);
  End

  Else If (InformacaoDeDestinoManifestoEletronico = tidDestinoUnico) Then
  Begin
    pEnabledEdit(edtCodCidDestino);
    pDisableEdit(edtNomCidDestino);
    pDisableEdit(edtUFDestino);
  End;

end;

procedure TfrmFatManifestoEletronico.pSetInformacaoDeDestinoDefault;
begin
  rdgInformacaoDeDestino.ItemIndex := InformacaoDeDestinoManifestoEletronico.GetValueDefault;
  pSetInformacaoDeDestino;
end;

procedure TfrmFatManifestoEletronico.rdgInformacaoDeDestinoClick(Sender: TObject);
begin
  inherited;
  pSetInformacaoDeDestino;
end;

procedure TfrmFatManifestoEletronico.rdgNotasClick(Sender: TObject);
begin
  inherited;
  chkDocOriVen.Checked := True;
  chkDocOriDev.Checked := False;

  case rdgNotas.ItemIndex of
    0: grbOriDoc.Visible := True;
    1: grbOriDoc.Visible := False;
    2: grbOriDoc.Visible := True;
  end;
end;

procedure TfrmFatManifestoEletronico.rdgTipoDocumentoClick(Sender: TObject);
begin
  inherited;
  chkCarPos.Enabled := (rdgTipoDocumento.ItemIndex = 0);
  if not chkCarPos.Enabled then
    chkCarPos.Checked := False;

  if (intTipoDocumento <> rdgTipoDocumento.ItemIndex) then
  begin
    intTipoDocumento := rdgTipoDocumento.ItemIndex;
    pPesquisar;
  end;
end;

procedure TfrmFatManifestoEletronico.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaTodos;
end;

procedure TfrmFatManifestoEletronico.chkCarPosClick(Sender: TObject);
begin
  inherited;

  pnlTail.Visible := not chkCarPos.Checked;
  if (stlListSelecao.Count > 0) and (chkCarPos.Checked) then
  begin
    pDesmarcaTodos;
  end;
end;

procedure TfrmFatManifestoEletronico.edtCodCidDestinoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCidDestino, edtNomCidDestino, arrCidade, fRetNomCidadeSemOpc, nil, 'da Cidade');
  edtUFDestino.Text := fRetNomCidade(edtCodCidDestino.Text, 1);

  If Not fEmptyStr(fRetCidade(edtCodCidDestino.Text)) Then
  Begin
    If Not fValidaEstado(edtUFDestino.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'UF Destino inválida, verifique seu cadastro!', ['&Ok']);
      pSetFocus(edtCodCidDestino);
    End;
  End;

end;

procedure TfrmFatManifestoEletronico.edtCodCidDestinoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCidade(Self, edtCodCidDestino, edtNomCidDestino, edtUFDestino, Nil, Key, arrCidade) Then
  Begin
    fValidaCampos(edtCodCidDestino, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatManifestoEletronico.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  If blnLibEmp Then
    pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpresa, fRetNomeEmpresa, nil, 'da empresa', 3);
end;

procedure TfrmFatManifestoEletronico.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If blnLibEmp And fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa, False, False) Then
  Begin
    fValidaCampos(edtCodEmp,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatManifestoEletronico.edtCodRotKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrRotReg : TConsultasArray;
begin
  inherited;

  If fPesqEntregasRotasRegiao(Self, edtCodRot, Nil, Nil, Key, arrRotReg, True,
      '', '', False) Then
  Begin
    If fValidaCampos(edtCodRot, True) Then
      SelectNext(GetParentForm(self).ActiveControl, True, True);
  End;
end;

procedure TfrmFatManifestoEletronico.edtNumRomKeyPress(Sender: TObject;
  var Key: Char);
Var
  qryConGen: TUniQuery;
  arrSel   : TConsultasArray;
begin
  inherited;

  qryConGen := fCriaQuery(Self);

  If fPesqRomaneio(Self, edtNumRom, qryConGen, Key, arrSel, '', True, True, 'Consulta de Romaneios') Then
  Begin
    If (fValidaCampos(edtNumRom, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

  FreeAndNil(qryConGen);
end;

procedure TfrmFatManifestoEletronico.edtUFDestinoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #13) And (Not edtUFDestino.ReadOnly) Then
    If (pnlInformacoes.Visible) And (memoInformacoes.Enabled) Then
      pSetFocus(memoInformacoes);
end;

function TfrmFatManifestoEletronico.fGetSql(blnLike: Boolean): String;
begin
  if (rdgTipoDocumento.ItemIndex = 0) then
    Result := fGetSqlNFe
  else
    Result := fGetSqlCTe;
end;

function TfrmFatManifestoEletronico.fGetSqlCTe: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  CONCAT_WS("-", FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP) AS NUMDOC, ';
  Result := Result + '  FIS_DTAENT AS DTAENT, ';
  Result := Result + '  CD.CID_ESTADO AS ESTADO, ';
  Result := Result + '  IF(IFNULL(MOVGER.GER_NOMCON,"") <> "", MOVGER.GER_CGCCON, CLI_C_G_C_) AS CNPJDE, ';
  Result := Result + '  IF(IFNULL(MOVGER.GER_NOMCON,"") <> "", MOVGER.GER_NOMCON, CLI_NOMCLI) AS NOMDES, ';
  Result := Result + '  GER_CODMOT AS CODMOT, ';
  Result := Result + '  GER_PLAVEI AS PLAVEI, ';
  Result := Result + '  CE.CID_COIBGE AS COIBGE, ';
  Result := Result + '  CE.CID_ESTADO AS EMP_UF, ';
  Result := Result + '  CE.CID_CODCID AS CODCID, ';
  Result := Result + '  MOVGER.GER_VLRCON AS VLRCON, ';
  Result := Result + '  CD.CID_COIBGE AS COIBGECLI, ';
  Result := Result + '  CD.CID_CODCID AS CODCID, ';
  Result := Result + '  CD.CID_NOMCID AS NOMCID, ';
  Result := Result + '  CADFIS.AUTOINCREM AS AUTOINCREM ';
  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';
  Result := Result + '  JOIN MOVCTE ON FIS_NUMDOC = CONCAT("000", CTE_NUMCTE) ';
  Result := Result + '             AND FIS_CODEMP =  CTE_CODEMP ';
  Result := Result + '  LEFT JOIN CADCLI    ON CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC = "C" ';
  Result := Result + '  LEFT JOIN CADEMP    ON EMP_CODEMP = FIS_CODEMP ';
  Result := Result + '  LEFT JOIN CADCID CE ON CE.CID_CODCID = EMP_CODCID ';
  Result := Result + '  JOIN MOVGER ON CTE_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  LEFT JOIN ENTCLI ON AUXMOV.AUX_ENTGER = ENTCLI.AUTOINCREM ';
  Result := Result + '                  AND ENTCLI.ETC_CODCLI = IFNULL(GER_CODCLI, NULL) ';
  Result := Result + '  LEFT JOIN CADCID CD ON CD.CID_CODCID = IFNULL(ETC_CIDENT, CLI_CODCID) ';
  Result := Result + '  LEFT JOIN ROMGERX ON MOVGER.GER_NUMDOC = ROMGERX.GER_NUMDOC AND MOVGER.GER_ESPDOC = ROMGERX.GER_ESPDOC AND MOVGER.GER_CODEMP = ROMGERX.GER_EMPROM ';
  Result := Result + 'WHERE ';
  Result := Result + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  Result := Result + '  FIS_ESPDOC = "CT" AND ';
  Result := Result + '  IFNULL(FIS_ACESSO,"") <> "" AND ';

  If Not fEmptyStr(edtNumRom.Text) Then
    Result := Result + '  ROMGERX.GER_NUMROM = '+QuotedStr(edtNumRom.Text)+' AND ';

  Result := Result + '  FIS_ENTSAI = "S" ';

  If blnLibEmp Then
    Result := Result + fStrLocate(edtCodEmp, arrEmpresa, 'FIS_CODEMP', 'CODEMP')
  Else
    Result := Result + ' AND FIS_CODEMP = :CODEMP ' ;

  Result := Result + '  AND FIS_NUMMAN IS NULL ';

  if (blnRegCid) and
     (not fEmptyStr(edtCodRot.Text))then
  begin
    Result := Result
            + '  AND MOVGER.AUTOINCREM IN (SELECT MOVDET.DET_SEQGER FROM MOVDET '
            + '                             INNER JOIN FATGOR ON FATGOR.FGO_NUMDOC = MOVDET.DET_NUM_PD '
            + '                                              AND FATGOR.FGO_ESPDOC = MOVDET.DET_ESP_PD '
            + '                                              AND FATGOR.FGO_CODEMP = MOVDET.DET_EMP_PD '
            + '                             INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '
            + '                             WHERE EXTGOR.FGO_CODROT = :CODROT) ';
  end;

  Result := Result + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVGER', 'NOTGER'), 'AUXMOV', 'AUXNOT'), 'MOVCTE', 'NOTCTE');
end;

function TfrmFatManifestoEletronico.fGetSqlNFe: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  CONCAT_WS("-", FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP) AS NUMDOC, ';
  Result := Result + '  FIS_DTAENT AS DTAENT, ';
  Result := Result + '  CD.CID_ESTADO AS ESTADO, ';
  Result := Result + '  IF(IFNULL(MOVGER.GER_NOMCON,"") <> "", MOVGER.GER_CGCCON, IFNULL(CLI_C_G_C_, FOR_C_G_C_)) AS CNPJDE, ';
  Result := Result + '  IF(IFNULL(MOVGER.GER_NOMCON,"") <> "", MOVGER.GER_NOMCON, IFNULL(CLI_NOMCLI, FOR_NOMFOR)) AS NOMDES, ';
  Result := Result + '  GER_CODMOT AS CODMOT, ';
  Result := Result + '  GER_PLAVEI AS PLAVEI, ';
  Result := Result + '  CE.CID_COIBGE AS COIBGE, ';
  Result := Result + '  CE.CID_ESTADO AS EMP_UF, ';
  Result := Result + '  MOVGER.GER_VLRCON AS VLRCON, ';
  Result := Result + '  CD.CID_COIBGE AS COIBGECLI, ';
  Result := Result + '  CD.CID_CODCID AS CODCID, ';
  Result := Result + '  CD.CID_NOMCID AS NOMCID, ';
  Result := Result + '  CADFIS.AUTOINCREM AS AUTOINCREM ';
  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';
  Result := Result + '  LEFT JOIN CADCLI    ON CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC = "C" ';
  Result := Result + '  LEFT JOIN CADFOR    ON FOR_CODFOR = FIS_FORCLI AND FIS_TIP_FC = "F" ';
  Result := Result + '  LEFT JOIN CADEMP    ON EMP_CODEMP = FIS_CODEMP ';
  Result := Result + '  LEFT JOIN CADCID CE ON CE.CID_CODCID = EMP_CODCID ';
  Result := Result + '  JOIN MOVGER ON GER_NUMDOC = FIS_NUMDOC AND ';
  Result := Result + '                 GER_ESPDOC = FIS_ESPDOC AND ';
  Result := Result + '                 GER_CODEMP = FIS_CODEMP AND ';
  Result := Result + '                 GER_TIP_FC = FIS_TIP_FC AND ';
  Result := Result + '                 IFNULL(GER_CODCLI, FOR_CODFOR) = FIS_FORCLI AND ';
  Result := Result + '                 IFNULL(GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") AND ';
  Result := Result + '                 GER_ORIDOC = FIS_ORIDOC ';
  Result := Result + '  LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  LEFT JOIN ENTCLI ON AUXMOV.AUX_ENTGER = ENTCLI.AUTOINCREM ';
  Result := Result + '                  AND ENTCLI.ETC_CODCLI = IFNULL(GER_CODCLI, NULL) ';
  Result := Result + '  LEFT JOIN CADCID CD ON CD.CID_CODCID = IFNULL(ETC_CIDENT, IFNULL(CLI_CODCID, FOR_CODCID)) ';
  Result := Result + '  LEFT JOIN ROMGERX ON MOVGER.GER_NUMDOC = ROMGERX.GER_NUMDOC AND MOVGER.GER_ESPDOC = ROMGERX.GER_ESPDOC AND MOVGER.GER_CODEMP = ROMGERX.GER_EMPROM ';
  Result := Result + 'WHERE ';
  Result := Result + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  Result := Result + '  FIS_ESPDOC IN ("NF", "EL") AND ';
  Result := Result + '  IFNULL(FIS_ACESSO,"") <> "" AND ';

  If Not fEmptyStr(edtNumRom.Text) Then
    Result := Result + '  ROMGERX.GER_NUMROM = '+QuotedStr(edtNumRom.Text)+' AND ';

  If (rdgNotas.ItemIndex = 0) Then
  Begin
    If (chkDocOriVen.Checked) And (Not chkDocOriDev.Checked) Then
    Begin
      Result := Result + fSqlManifestoNotaDeVenda;
    End
    Else If (Not chkDocOriVen.Checked) And (chkDocOriDev.Checked) Then
    Begin
      Result := Result + fSqlManifestoNotaDeDevolucao;
    End
    Else If (chkDocOriVen.Checked) And (chkDocOriDev.Checked) Then
    Begin
      Result := Result + ' ('+fSqlManifestoNotaDeVenda+' OR '+fSqlManifestoNotaDeDevolucao+') ';
    End;
  End
  Else If (rdgNotas.ItemIndex = 1) Then
  Begin
    Result := Result + fSqlManifestoNotaDeTerceiros;
  End
  Else
  Begin
    If (chkDocOriVen.Checked) And (Not chkDocOriDev.Checked) Then
    Begin
      Result := Result + ' ('+fSqlManifestoNotaDeVenda+' OR '+fSqlManifestoNotaDeTerceiros+') ';
    End
    Else If (Not chkDocOriVen.Checked) And (chkDocOriDev.Checked) Then
    Begin
      Result := Result + ' ('+fSqlManifestoNotaDeDevolucao+' OR '+fSqlManifestoNotaDeTerceiros+') ';
    End
    Else If (chkDocOriVen.Checked) And (chkDocOriDev.Checked) Then
    Begin
      Result := Result + fSqlManifestoDocumentosPermitidos;
    End;
  End;

  If blnLibEmp Then
    Result := Result + fStrLocate(edtCodEmp, arrEmpresa, 'FIS_CODEMP', 'CODEMP')
  Else
    Result := Result + ' AND FIS_CODEMP = :CODEMP ' ;

  Result := Result + '  AND FIS_NUMMAN IS NULL ';

  if (blnRegCid) and
     (not fEmptyStr(edtCodRot.Text))then
  begin
    Result := Result
            + '  AND MOVGER.AUTOINCREM IN (SELECT MOVDET.DET_SEQGER FROM MOVDET '
            + '                             INNER JOIN FATGOR ON FATGOR.FGO_NUMDOC = MOVDET.DET_NUM_PD '
            + '                                              AND FATGOR.FGO_ESPDOC = MOVDET.DET_ESP_PD '
            + '                                              AND FATGOR.FGO_CODEMP = MOVDET.DET_EMP_PD '
            + '                             INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '
            + '                             WHERE EXTGOR.FGO_CODROT = :CODROT) ';
  end;

  Result := Result + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVGER', 'NOTGER'), 'AUXMOV', 'AUXNOT');
end;

procedure TfrmFatManifestoEletronico.FormCreate(Sender: TObject);
begin
  inherited;
  intTipoDocumento := 0;
end;

procedure TfrmFatManifestoEletronico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
  Begin
    If dbgConsulta.Focused Then
    Begin
      If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não'], 2) = 1 Then
      Begin
        pLimparTela;
      End;
    End
    Else
      inherited;
  End
  Else If Key = VK_F10 Then
  Begin
    btnGravar.Click;
  End
  Else If Key = VK_F6 Then
  Begin
    btnMarcaTodos.Click;
  End
  Else If Key = VK_F7 Then
  Begin
    btnDesmarcaTodos.Click;
  End
  Else
    inherited;
end;

procedure TfrmFatManifestoEletronico.FormShow(Sender: TObject);
begin
  inherited;
  chkCarPos.Visible := (fCampoExiste('CADFIS', 'FIS_CARPOS', True)) and (fCfgSis('VERMDF') = '3.00a');
  blnSempreRelerBanco := False;
  rdgTipoDocumento.Enabled := fCfgSis('EMICTE', varBoolean);
  rdgTipoDocumento.ItemIndex := IIF(rdgTipoDocumento.Enabled, 1, 0);
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;
  blnLibEmp := fVerificaAcessoSistema('MDFEMP');
  blnRegCid := fCfgSis('REGCID', varBoolean);
  pnlFiltroRotaRegiao.Visible := blnRegCid;
  grbOriDoc.Visible := ((rdgNotas.ItemIndex = 0) or (rdgNotas.ItemIndex = 2));
  chkDocOriVen.Checked := True;
  chkDocOriDev.Checked := False;

  pVerdeVermelho(edtCodEmp, shpEmp, blnLibEmp);
  edtCodEmp.ReadOnly := not blnLibEmp;
  if chkCarPos.Visible then
    pSetFocus(chkCarPos)
  else
    pSetFocus(mskDtaIni);

  pSetInformacaoDeDestinoDefault;

end;

function TfrmFatManifestoEletronico.fSetParametros: Boolean;
begin
  With qryConsulta Do
  Begin
    ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);

    If blnLibEmp Then
      pSetaParam(edtCodEmp.Text , arrEmpresa , strEmpresa , 'CODEMP', qryConsulta)
    ELSE
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    if (blnRegCid) and
       (not fEmptyStr(edtCodRot.Text))then
    begin
      ParamByName('CODROT').AsString := edtCodRot.Text;
    end;

  End;

  Result := True;
end;

function TfrmFatManifestoEletronico.fUfEmRotaManifestoAnterior(strPlaca, strPlacaReboque: String): Boolean;
Var
  qryAux: TUniQuery;
  strUf: String;
  strSQL : String;
begin
  Result := False;
  cdsConsulta.Locate('AUTOINCREM', stlListSelecao[0], []);
  strUf := cdsConsulta.FieldByName('ESTADO').AsString;

  strSQL :=  'SELECT FIS_PERCUR ' +
             'FROM CADFIS ' +
             'WHERE FIS_ESTADO = :ESTADO' +
             '  AND FIS_CODEMP = :CODEMP' +
             '  AND (FIS_PLAMAN = :PLAMAN ' +
             IIF(fEmptyStr(strPlacaReboque), '', '  OR FIS_PLAMA2 = :PLAMA2 ') +
             '  ) AND FIS_ENCERR IS NULL ';

  qryAux := fCriaQuery(Self);
  try
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('ESTADO').AsString := strUf;
    qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryAux.ParamByName('PLAMAN').AsString := strPlaca;
    if not fEmptyStr(strPlacaReboque) then
      qryAux.ParamByName('PLAMA2').AsString := strPlacaReboque;
    qryAux.Open;

    qryAux.First;
    while not qryAux.Eof do
    begin
      Result := fValidaEstadosdaRota(qryAux.FieldByName('FIS_PERCUR').AsString);
      if Result then
        Break;
      qryAux.Next;
    end;

  finally
    FreeAndNil(qryAux);
  end;

end;

function TfrmFatManifestoEletronico.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  IntCorre : Integer;

  procedure pConsultaManifesto;
  begin
    pLimpaPesquisa;

    If (Not chkDocOriVen.Checked) And (Not chkDocOriDev.Checked) Then
      chkDocOriVen.Checked := True;

    fAbreConsulta(True);
    If cdsConsulta.IsEmpty Then
    Begin
      pMensagemOk('Não há notas para envio de manifesto eletrônico neste período.');
      Result := False;
    End;
  end;

begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End;

      If Result And edtCodEmp.ReadOnly and
        (not blnRegCid) Then
        pConsultaManifesto;

    End
    Else If (Sender = edtNumRom) Then
    Begin
      If (Not fEmptyStr(edtNumRom.Text)) And  (Not fRomaneioExiste(edtNumRom.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse romaneio não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodEmp) Then
    Begin
      if (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) or (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      begin
        fMensagem('ATENÇÃO!', 'Informe o período corretamente!', ['&O k']);
        Result := False;
        pSetFocus(mskDtaIni);
        Exit;
      end;

      pDesmarcaLista(edtCodEmp, arrEmpresa);
      If High(arrEmpresa) >= 0 Then
        For IntCorre := 0 To High(arrEmpresa) Do
        Begin
          If Not fEmptyStr(arrEmpresa[intCorre].strCodigo) Then
          Begin
            If (Pos(arrEmpresa[intCorre].strCodigo, QuotedStr(strEmpAcessoUsuarioLogado)) <= 0) Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
              Result := False;
              Break;
            End;
          End;
        End
      Else
      Begin
        If Not fEmptyStr(edtCodEmp.Text) Then
        Begin
          If (Pos(edtCodEmp.Text, QuotedStr(strEmpAcessoUsuarioLogado)) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
            Result := False;
          End;
        End;
      End;

      if not blnRegCid then
        pConsultaManifesto;
    End
    Else If (Sender = edtCodRot) Then
    begin
      if (not fEmptyStr(edtCodRot.Text)) and blnRegCid then
      begin
        If Not fValidaRota(edtCodRot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Rota não permitida!', ['&Ok']);
          Result := False;
        End
        else
          pConsultaManifesto;
      end
      else
        pConsultaManifesto;
    end;
  End;
end;

function TfrmFatManifestoEletronico.fValidaEstadosdaRota(
  strPercurso: String): Boolean;
Var
  stlUFs: TStringList;
  strUF: String;
begin
  Result := False;
  stlUFs := TStringList.Create;
  try
    ExtractStrings([','], [], PChar(strPercurso), stlUFs);

    cdsConsulta.DisableControls;
    try
      cdsConsulta.First;
      while not cdsConsulta.Eof do
      begin
        strUF := cdsConsulta.FieldByName('ESTADO').AsString;
        Result := Pos(strUF, stlUFs.CommaText) > 0;
        if not Result then
          Break;
        cdsConsulta.Next;
      end;
    finally
      cdsConsulta.EnableControls;
    end;
  finally
    FreeAndNil(stlUFs);
  end;
end;


function TfrmFatManifestoEletronico.fValidaRota(strCodRot: String): Boolean;
var
  objRotReg : TRotReg;
begin
  Result    := False;
  objRotReg := nil;
  Try
    Try
      objRotReg           := TRotReg.Create(Self);
      objRotReg.strCodRot := strCodRot;

      Result := objRotReg.fExisteRota;
    Except
      On E: Exception do
      Begin
        pMensagensErro(E.Message,'[fValidaRota]');
      End;
    End;
  Finally
    objRotReg.Free;
  End;
end;

procedure TfrmFatManifestoEletronico.pAcaoAdd;
begin
  inherited;
  if fEmptyStr(cdsConsulta.FieldByName('COIBGECLI').AsString) then
  begin
    pMensagemOk('Falta Código do IBGE para a Cidade de entrega desse Documento!' + #13 +
                'Corrija no cadastro de Cidades a Cidade: ' +
                cdsConsulta.FieldByName('CODCID').AsString + ' - ' +
                cdsConsulta.FieldByName('NOMCID').AsString);
    dbgConsultaDblClick(Nil);
    Exit;
  end;

  if (chkCarPos.Checked) and
     (cdsConsulta.FieldByName('ESTADO').AsString <> cdsConsulta.FieldByName('EMP_UF').AsString) then
  begin
    pMensagemOk('Na categoria de retirada de produtos, somente é permitido carregamento no mesmo Estado!');
    dbgConsultaDblClick(Nil);
  end;
end;

procedure TfrmFatManifestoEletronico.pCarregaFila(const strNomPro : String; Var strNomeFila, strTipImp : String);
  Var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  Try
    pCarregaConfImpr(qryCfgRel, strNomPro);
    strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
    strTipImp   := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
    If Not fEmptyStr(strNomeFila) Then
      fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
  Finally
    FreeAndNil(qryCfgRel);
  End;
end;

procedure TfrmFatManifestoEletronico.pEnviarManifesto(const strNumMan: String);
var
  strNomImp: string;
  strTipImp: string;
begin
  pCarregaFila(Self.Name, strNomImp, strTipImp);
  fEnviarManifestoEletronico(strNumMan, strNomImp);
end;

procedure TfrmFatManifestoEletronico.pFiltrar(Var cdsClient: TUniClientDataSet;
                                                  intSeqPag: Integer);
begin

  If Not Assigned(cdsClient) Then
    Exit;

  cdsClient.Filtered := False;
  cdsClient.Filter   := 'MDF_SEQPAG = ' + intSeqPag.ToString;
  cdsClient.Filtered := True;

end;

procedure TfrmFatManifestoEletronico.pLimparTela;
begin
  pDesmarcaTodos;
  qryConsulta.Close;
  cdsConsulta.Close;
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtPercurso.Clear;
  edtCodCidDestino.Clear;
  edtNomCidDestino.Clear;
  edtUFDestino.Clear;
  memoInformacoes.Clear;
  if chkCarPos.Visible then
    pSetFocus(chkCarPos)
  else
    pSetFocus(mskDtaIni);
end;

procedure TfrmFatManifestoEletronico.pPesquisar;
var
  blnPesquisar: Boolean;
begin
  blnPesquisar := not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text));
  blnPesquisar := (blnPesquisar) and (not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)));
  blnPesquisar := (blnPesquisar) and (not fEmptyStr(edtCodEmp.Text));
  if (blnPesquisar) and (Assigned(cdsConsulta)) then
  begin
    pDesmarcaTodos;
    fAbreConsulta();
  end;
end;

function TfrmFatManifestoEletronico.fAtualizarDocumentosManifesto(const stlCodMot: TStringList;
                                                                        strPlaca,
                                                                        strPlacaReboque,
                                                                        strPercurso,
                                                                        strUFDestino : String;
                                                                        cdsSegCar,
                                                                        cdsSegCarAver,
                                                                        cdsInfc,
                                                                        cdsProPre,
                                                                        cdsMDFPAG,
                                                                        cdsMDFCOM,
                                                                        cdsMDFPRA,
                                                                        cdsMDFPRO  : TUniClientDataSet;
                                                                        strCodCidDestino : String): String;
Var
  strSQL    : String;
  qryAux    : TUniQuery;
  qryMdfSeg : TUniQuery;
  qryMdfAve : TUniQuery;
  qryMdfInc : TUniQuery;
  qryMdfPro : TUniQuery;
  qryMdfPPR : TUniQuery;
  qryMdfPAG : TUniQuery;
  qryMdfCOM : TUniQuery;
  qryMdfPRA : TUniQuery;
  I         : Integer;
  J         : Integer;
begin

  fStartTransaction;

  Try

    Result := fStrZero(fRetSequencial('PRO_ME'), 6);

    strSQL := '';
    strSQL := strSQL + 'UPDATE CADFIS SET ';
    strSQL := strSQL + '  FIS_NUMMAN = :NUMMAN, ';
    strSQL := strSQL + '  FIS_EMPMAN = :EMPMAN, ';
    strSQL := strSQL + '  FIS_DTAMAN = :DTAMAN, ';

    if chkCarPos.Visible then
      strSQL := strSQL + '  FIS_CARPOS = :CARPOS, ';

    strSQL := strSQL + '  FIS_PLAMAN = :PLAVEI, ';
    if not fEmptyStr(strPlacaReboque) then
      strSQL := strSQL + '  FIS_PLAMA2 = :PLAVE2, ';
    strSQL := strSQL + '  FIS_PERCUR = :PERCUR, ';
    strSQL := strSQL + '  FIS_ESTMAN = :ESTMAN, ';

    strSQL := strSQL + '  FIS_CIDDES = ' + IIF(strCodCidDestino.IsEmpty, 'NULL', ':CIDDES') + ' ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  AUTOINCREM IN (' + stlListSelecao.CommaText + ') ';

    qryAux := fCriaQuery(Self);
    Try
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('NUMMAN').AsString := Result;
      qryAux.ParamByName('EMPMAN').AsString := VS_strCodEmp;
      qryAux.ParamByName('DTAMAN').AsDateTime := VS_Date;

      if (chkCarPos.Visible) then
        qryAux.ParamByName('CARPOS').AsString :=  IIF(chkCarPos.Checked, 'S', 'N');

      qryAux.ParamByName('PLAVEI').AsString := strPlaca;
      if not fEmptyStr(strPlacaReboque) then
        qryAux.ParamByName('PLAVE2').AsString := strPlacaReboque;
      qryAux.ParamByName('PERCUR').AsString := strPercurso;
      qryAux.ParamByName('ESTMAN').AsString := strUFDestino;

      If Not strCodCidDestino.IsEmpty Then
        qryAux.ParamByName('CIDDES').AsString := strCodCidDestino;

      qryAux.ExecSQL;
    Finally
      FreeAndNil(qryAux);
    End;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO FISMOT(AUTOINCREM, FMO_SEQGER, FMO_CODMOT) ';
    strSQL := strSQL + 'VALUES(:AUTOINCREM, :SEQGER, :CODMOT); ';

    qryAux := fCriaQuery(Self);
    Try
      qryAux.SQL.Add(strSQL);

      for I := 0 to Pred(stlListSelecao.Count) do
      begin
        for J := 0 to Pred(stlCodMot.Count) do
        begin
          qryAux.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('FISMOT', VS_strCodEmp);
          qryAux.ParamByName('SEQGER').AsString     := fRetiraQuotedLista(stlListSelecao.Strings[I]);
          qryAux.ParamByName('CODMOT').AsString     := stlCodMot[J];
          qryAux.ExecSQL;
        end;
      end;
    Finally
      FreeAndNil(qryAux);
    End;

    If (Assigned(cdsSegCar)) And (Not cdsSegCar.IsEmpty) Then
    Begin
      qryMdfSeg := fCriaQuery(Self);
      Try
        qryMdfSeg.SQL.Text := 'SELECT * FROM MDFSEG WHERE FALSE';
        qryMdfSeg.Open;

        cdsSegCar.First;
        While Not cdsSegCar.Eof Do
        Begin

          qryMdfSeg.Append;
          qryMdfSeg.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('MDFSEG', VS_strCodEmp);
          qryMdfSeg.FieldByName('MDF_NUMMAN').AsString  := Result;
          qryMdfSeg.FieldByName('MDF_EMPMAN').AsString  := VS_strCodEmp;
          qryMdfSeg.FieldByName('MDF_SEQUEN').AsInteger := cdsSegCar.FieldByName('MDF_SEQUEN').AsInteger;
          qryMdfSeg.FieldByName('MDF_RESSEG').AsInteger := cdsSegCar.FieldByName('MDF_RESSEG').AsInteger;
          qryMdfSeg.FieldByName('MDF_RESCPF').AsString  := cdsSegCar.FieldByName('MDF_RESCPF').AsString;
          qryMdfSeg.FieldByName('MDF_NOMSEG').AsString  := cdsSegCar.FieldByName('MDF_NOMSEG').AsString;
          qryMdfSeg.FieldByName('MDF_SEGCNP').AsString  := cdsSegCar.FieldByName('MDF_SEGCNP').AsString;
          qryMdfSeg.FieldByName('MDF_NUMAPO').AsString  := cdsSegCar.FieldByName('MDF_NUMAPO').AsString;
          qryMdfSeg.Post;

          cdsSegCar.Next;
        End;
      Finally
        FreeAndNil(qryMdfSeg);
      End;
    End;

    If (Assigned(cdsSegCarAver)) And (Not cdsSegCarAver.IsEmpty) Then
    Begin
      qryMdfAve := fCriaQuery(Self);
      Try
        qryMdfAve.SQL.Text := 'SELECT * FROM MDFAVE WHERE FALSE';
        qryMdfAve.Open;

        cdsSegCarAver.First;
        While Not cdsSegCarAver.Eof Do
        Begin

          qryMdfAve.Append;
          qryMdfAve.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('MDFAVE', VS_strCodEmp);
          qryMdfAve.FieldByName('MDF_NUMMAN').AsString  := Result;
          qryMdfAve.FieldByName('MDF_EMPMAN').AsString  := VS_strCodEmp;
          qryMdfAve.FieldByName('MDF_SEQUEN').AsInteger := cdsSegCarAver.FieldByName('MDF_SEQUEN').AsInteger;
          qryMdfAve.FieldByName('MDF_NUMAVE').AsString  := cdsSegCarAver.FieldByName('MDF_NUMAVE').AsString;
          qryMdfAve.Post;

          cdsSegCarAver.Next;
        End;
      Finally
        FreeAndNil(qryMdfAve);
      End;
    End;

    If (Assigned(cdsInfc)) And (Not cdsInfc.IsEmpty) Then
    Begin
      qryMdfInc := fCriaQuery(Self);
      qryMdfInc.SQL.Text := 'SELECT * FROM MDFINC WHERE FALSE';
      qryMdfInc.Open;

      cdsInfc.First;
      While Not cdsInfc.Eof Do
      Begin

        qryMdfInc.Append;
        qryMdfInc.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MDFINC', VS_strCodEmp);
        qryMdfInc.FieldByName('MDF_NUMMAN').AsString := Result;
        qryMdfInc.FieldByName('MDF_EMPMAN').AsString := VS_strCodEmp;
        qryMdfInc.FieldByName('MDF_INFCOM').AsString := cdsInfc.FieldByName('MDF_INFCOM').AsString;
        qryMdfInc.FieldByName('MDF_SEQGER').AsString := cdsInfc.FieldByName('MDF_SEQGER').AsString;
        qryMdfInc.Post;

        cdsInfc.Next;
      End;
    End;

    {Proprietário do Veículo}
    If (Assigned(cdsMDFPRO)) And (Not cdsMDFPRO.IsEmpty) Then
    Begin

      qryMdfPro := fCriaQuery(Self);

      Try

        qryMdfPro.Close;
        qryMdfPro.SQL.Clear;
        qryMdfPro.SQL.Text := 'SELECT * FROM MDFPRO WHERE FALSE';
        qryMdfPro.Open;

        qryMdfPro.Append;
        qryMdfPro.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('MDFPRO', VS_strCodEmp);
        qryMdfPro.FieldByName('MDF_NUMMAN').AsString  := Result;
        qryMdfPro.FieldByName('MDF_EMPMAN').AsString  := VS_strCodEmp;
        qryMdfPro.FieldByName('MDF_CPFCNP').AsString  := cdsMDFPRO.FieldByName('MDF_CPFCNP').AsString;
        qryMdfPro.FieldByName('MDF_RNTRC_').AsString  := cdsMDFPRO.FieldByName('MDF_RNTRC_').AsString;
        qryMdfPro.FieldByName('MDF_NOMRAZ').AsString  := cdsMDFPRO.FieldByName('MDF_NOMRAZ').AsString;
        qryMdfPro.FieldByName('MDF_INSEST').AsString  := cdsMDFPRO.FieldByName('MDF_INSEST').AsString;
        qryMdfPro.FieldByName('MDF_UF_PRO').AsString  := cdsMDFPRO.FieldByName('MDF_UF_PRO').AsString;
        qryMdfPro.FieldByName('MDF_TIPPRO').AsInteger := cdsMDFPRO.FieldByName('MDF_TIPPRO').AsInteger;
        qryMdfPro.Post;

      Finally
        FreeAndNil(qryMdfPro);
      End;

    End;

    {Produto Predominante}
    If (Assigned(cdsProPre)) And (Not cdsProPre.IsEmpty) Then
    Begin

      qryMdfPPR := fCriaQuery(Self);

      Try

        qryMdfPPR.Close;
        qryMdfPPR.SQL.Clear;
        qryMdfPPR.SQL.Text := 'SELECT * FROM MDFPPR WHERE FALSE';
        qryMdfPPR.Open;

        qryMdfPPR.Append;
        qryMdfPPR.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('MDFPPR', VS_strCodEmp);
        qryMdfPPR.FieldByName('MDF_NUMMAN').AsString  := Result;
        qryMdfPPR.FieldByName('MDF_EMPMAN').AsString  := VS_strCodEmp;
        qryMdfPPR.FieldByName('MDF_TIPCAR').AsString  := cdsProPre.FieldByName('MDF_TIPCAR').AsString;
        qryMdfPPR.FieldByName('MDF_DESPRO').AsString  := cdsProPre.FieldByName('MDF_DESPRO').AsString;
        qryMdfPPR.FieldByName('MDF_C_GTIN').AsString  := cdsProPre.FieldByName('MDF_C_GTIN').AsString;
        qryMdfPPR.FieldByName('MDF_CODNCM').AsString  := cdsProPre.FieldByName('MDF_CODNCM').AsString;
        qryMdfPPR.FieldByName('MDF_CEPCAR').AsString  := cdsProPre.FieldByName('MDF_CEPCAR').AsString;
        qryMdfPPR.FieldByName('MDF_LATCAR').AsString  := cdsProPre.FieldByName('MDF_LATCAR').AsString;
        qryMdfPPR.FieldByName('MDF_LONCAR').AsString  := cdsProPre.FieldByName('MDF_LONCAR').AsString;
        qryMdfPPR.FieldByName('MDF_CEPDES').AsString  := cdsProPre.FieldByName('MDF_CEPDES').AsString;
        qryMdfPPR.FieldByName('MDF_LATDES').AsString  := cdsProPre.FieldByName('MDF_LATDES').AsString;
        qryMdfPPR.FieldByName('MDF_LONDES').AsString  := cdsProPre.FieldByName('MDF_LONDES').AsString;
        qryMdfPPR.Post;

      Finally
        FreeAndNil(qryMdfPPR);
      End;

    End;

    {Informações do Pagamento do Frete}
    If (Assigned(cdsMDFPAG)) And (Not cdsMDFPAG.IsEmpty) Then
    Begin

      qryMdfPAG := fCriaQuery(Self);
      qryMdfCOM := fCriaQuery(Self);
      qryMdfPRA := fCriaQuery(Self);

      qryMdfPAG.Close;
      qryMdfPAG.SQL.Clear;
      qryMdfPAG.SQL.Text := 'SELECT * FROM MDFPAG WHERE FALSE';
      qryMdfPAG.Open;

      qryMdfCOM.Close;
      qryMdfCOM.SQL.Clear;
      qryMdfCOM.SQL.Text := 'SELECT * FROM MDFCOM WHERE FALSE';
      qryMdfCOM.Open;

      qryMdfPRA.Close;
      qryMdfPRA.SQL.Clear;
      qryMdfPRA.SQL.Text := 'SELECT * FROM MDFPRA WHERE FALSE';
      qryMdfPRA.Open;

      Try

        cdsMDFPAG.First;
        pFiltrar(cdsMDFCOM, cdsMDFPAG.FieldByName('MDF_SEQPAG').AsInteger);
        pFiltrar(cdsMDFPRA, cdsMDFPAG.FieldByName('MDF_SEQPAG').AsInteger);

        While Not cdsMDFPAG.Eof Do
        Begin

          qryMdfPAG.Append;
          qryMdfPAG.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('MDFPAG', VS_strCodEmp);
          qryMdfPAG.FieldByName('MDF_NUMMAN').AsString   := Result;
          qryMdfPAG.FieldByName('MDF_EMPMAN').AsString   := VS_strCodEmp;
          qryMdfPAG.FieldByName('MDF_SEQPAG').AsInteger  := cdsMDFPAG.FieldByName('MDF_SEQPAG').AsInteger;
          qryMdfPAG.FieldByName('MDF_NOMRES').AsString   := cdsMDFPAG.FieldByName('MDF_NOMRES').AsString;
          qryMdfPAG.FieldByName('MDF_CPFCNP').AsString   := cdsMDFPAG.FieldByName('MDF_CPFCNP').AsString;
          qryMdfPAG.FieldByName('MDF_ESTRAN').AsString   := cdsMDFPAG.FieldByName('MDF_ESTRAN').AsString;
          qryMdfPAG.FieldByName('MDF_VALTOT').AsCurrency := cdsMDFPAG.FieldByName('MDF_VALTOT').AsCurrency;
          qryMdfPAG.FieldByName('MDF_FORPAG').AsInteger  := cdsMDFPAG.FieldByName('MDF_FORPAG').AsInteger;
          qryMdfPAG.FieldByName('MDF_NUMBAN').AsString   := cdsMDFPAG.FieldByName('MDF_NUMBAN').AsString;
          qryMdfPAG.FieldByName('MDF_NUMAGE').AsString   := cdsMDFPAG.FieldByName('MDF_NUMAGE').AsString;
          qryMdfPAG.FieldByName('MDF_CNPJPG').AsString   := cdsMDFPAG.FieldByName('MDF_CNPJPG').AsString;
          qryMdfPAG.FieldByName('MDF_TIPPIX').AsInteger  := cdsMDFPAG.FieldByName('MDF_TIPPIX').AsInteger;
          qryMdfPAG.FieldByName('MDF_CHAPIX').AsString   := cdsMDFPAG.FieldByName('MDF_CHAPIX').AsString;
          qryMdfPAG.FieldByName('MDF_VALADI').AsCurrency := cdsMDFPAG.FieldByName('MDF_VALADI').AsCurrency;
          qryMdfPAG.Post;

          {Componentes}
          If Not cdsMDFCOM.IsEmpty Then
          Begin

            cdsMDFCOM.First;
            While Not cdsMDFCOM.Eof Do
            Begin

              qryMdfCOM.Append;
              qryMdfCOM.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('MDFCOM', VS_strCodEmp);
              qryMdfCOM.FieldByName('MDF_NUMMAN').AsString   := Result;
              qryMdfCOM.FieldByName('MDF_EMPMAN').AsString   := VS_strCodEmp;
              qryMdfCOM.FieldByName('MDF_SEQPAG').AsInteger  := cdsMDFCOM.FieldByName('MDF_SEQPAG').AsInteger;
              qryMdfCOM.FieldByName('MDF_SEQCOM').AsInteger  := cdsMDFCOM.FieldByName('MDF_SEQCOM').AsInteger;
              qryMdfCOM.FieldByName('MDF_TIPCOM').AsString   := cdsMDFCOM.FieldByName('MDF_TIPCOM').AsString;
              qryMdfCOM.FieldByName('MDF_VALCOM').AsCurrency := cdsMDFCOM.FieldByName('MDF_VALCOM').AsCurrency;
              qryMdfCOM.FieldByName('MDF_DESCOM').AsString   := cdsMDFCOM.FieldByName('MDF_DESCOM').AsString;
              qryMdfCOM.Post;

              cdsMDFCOM.Next;

            End;

          End;

          {Prazos}
          If Not cdsMDFPRA.IsEmpty Then
          Begin

            cdsMDFPRA.First;
            While Not cdsMDFPRA.Eof Do
            Begin

              qryMdfPRA.Append;
              qryMdfPRA.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('MDFPRA', VS_strCodEmp);
              qryMdfPRA.FieldByName('MDF_NUMMAN').AsString   := Result;
              qryMdfPRA.FieldByName('MDF_EMPMAN').AsString   := VS_strCodEmp;
              qryMdfPRA.FieldByName('MDF_SEQPAG').AsInteger  := cdsMDFPRA.FieldByName('MDF_SEQPAG').AsInteger;
              qryMdfPRA.FieldByName('MDF_SEQPRA').AsInteger  := cdsMDFPRA.FieldByName('MDF_SEQPRA').AsInteger;
              qryMdfPRA.FieldByName('MDF_NUMPAR').AsInteger  := cdsMDFPRA.FieldByName('MDF_NUMPAR').AsInteger;
              qryMdfPRA.FieldByName('MDF_DTAVEN').AsString   := cdsMDFPRA.FieldByName('MDF_DTAVEN').AsString;
              qryMdfPRA.FieldByName('MDF_VALPAR').AsCurrency := cdsMDFPRA.FieldByName('MDF_VALPAR').AsCurrency;
              qryMdfPRA.Post;

              cdsMDFPRA.Next;

            End;

          End;

          cdsMDFPAG.Next;
          pFiltrar(cdsMDFCOM, cdsMDFPAG.FieldByName('MDF_SEQPAG').AsInteger);
          pFiltrar(cdsMDFPRA, cdsMDFPAG.FieldByName('MDF_SEQPAG').AsInteger);

        End;

      Finally
        FreeAndNil(qryMdfPAG);
        FreeAndNil(qryMdfCOM);
        FreeAndNil(qryMdfPRA);
      End;

    End;

    fCommit;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := '';
      pMensagensErro(E.Message, '[TfrmFatManifestoEletronico.fAtualizarDocumentosManifesto]');
    End;
  End;
end;

function TfrmFatManifestoEletronico.fCriaCdsInfc(
  cmpSelf: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(cmpSelf);

  With result, FieldDefs Do
  Begin
    With AddFieldDef Do
    Begin
      Name     := 'MDF_INFCOM';
      DataType := ftString;
      Required := False;
      Size     := 12750;
    End;

    With AddFieldDef Do
    Begin
      Name     := 'MDF_SEQGER';
      DataType := ftString;
      Required := False;
      Size     := 20;
    End;
    CreateDataSet;
    Open;
    LogChanges := False;
  End;

end;

end.
