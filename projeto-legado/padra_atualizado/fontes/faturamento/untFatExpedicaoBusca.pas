unit untFatExpedicaoBusca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, Uni, AppEvnts, BitBtnLockedIncrem, QColorLabel, frxClass,
  frxExportCSVTestabilidade, untTypesSistema, ComboBoxFocus;

Type
  TfrmFatExpedicaoBusca = class(TfrmPai)
    pnlGeral: TPanel;
    btnConfirma: TBitBtnLocked;
    pnlFiltros: TPanel;
    pnlSomenteCliFil: TPanel;
    pnlTopo: TPanel;
    lblVendedor: TLabel;
    lblPedido: TLabel;
    Label4: TLabel;
    lblEspecie: TLabel;
    lblSepImp: TLabel;
    ColorLabel13: TColorLabel;
    edtCodVen: TEditFocus;
    edtNumPed: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtNomVen: TEditFocus;
    edtEspecie: TEditFocus;
    edtSepImp: TEditFocus;
    pnlOpeDes: TPanel;
    lbl8: TLabel;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    pnlTopo2: TPanel;
    Label2: TLabel;
    lbl1: TLabel;
    Label3: TLabel;
    mskDtaIni: TMaskEditFocus;
    rdgDatas: TRadioGroup;
    mskDtaFin: TMaskEditFocus;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    pnlBarDoc: TPanel;
    Label5: TLabel;
    edtBarDoc: TEditFocus;
    shpMultSel: TShape;
    pnlOrigem: TPanel;
    Label7: TLabel;
    cmbOrigem: TComboBoxFocus;
    lblDeptoVendedor: TLabel;
    edtCodDep: TEditFocus;
    edtNomDep: TEditFocus;
    pnlSeqSep: TPanel;
    lblSeqSep: TLabel;
    edtSeqSep: TEditFocus;
    pnlProduto: TPanel;
    Label15: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    pnlRomaneio: TPanel;
    pnlComanda: TPanel;
    lblComanda: TLabel;
    edtBarCom: TEditFocus;
    pnlEntRet: TPanel;
    lblEntRet: TLabel;
    cmbEntRet: TComboBoxFocus;
    Label10: TLabel;
    edtQtdPro: TEditFocus;
    pnlLoteSep: TPanel;
    Label13: TLabel;
    lblEmpLote: TLabel;
    edtNumLot: TEditFocus;
    edtCodEmpLote: TEditFocus;
    edtNomEmpLote: TEditFocus;
    pnlOndaSeparacao: TPanel;
    pnlLocFis: TPanel;
    lblLocFis: TLabel;
    edtLocFis: TEditFocus;
    gbSuperEstoque: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    edtLocFinSup: TEditFocus;
    edtLocIniSup: TEditFocus;
    gb1: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    edtLocFin: TEditFocus;
    edtLocIni: TEditFocus;
    lblTransp: TLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    pnlTipAte: TPanel;
    Label14: TLabel;
    edtCodTpa: TEditFocus;
    edtDesTpa: TEditFocus;
    chkSomenteCliFil: TCheckBox;
    Label6: TLabel;
    edtUrgente: TEditFocus;
    ColorLabel1: TColorLabel;
    NBOndaSeparacao: TNotebook;
    lblQtdPedOnda: TLabel;
    chkOndaSeparacaoUnicoProduto: TCheckBox;
    chkSemSeqSep: TCheckBox;
    edtQtdPedOnda: TEditFocus;
    chkSelPedOndaAut: TCheckBox;
    chkExclusivamentePedidosKits: TCheckBox;
    lblNumeroOnda: TLabel;
    edtNumeroOnda: TEditFocus;
    rdgOndaSeparacao: TRadioGroup;
    Label21: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    Panel1: TPanel;
    Label22: TLabel;
    edtMsgPed: TEditFocus;
    chkOndaSeparacaoVariosProdutos: TCheckBox;
    edtQtdProOndaDe: TEditFocus;
    lblProdutosAte: TLabel;
    edtQtdProOnda: TEditFocus;
    lblProdutosAte2: TLabel;
    pnlLocalDeArmazenamento: TPanel;
    lblLocalArmazenamento: TLabel;
    edtCodLar: TEditFocus;
    edtDesLar: TEditFocus;
    pnlFaturamentoTotal: TPanel;
    lblFatTot: TLabel;
    edtFatTot: TEditFocus;
    cllFatTot: TColorLabel;
    ckbSelPedAut: TCheckBox;
    lblEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    chkSolicitaTelaDeVolume: TCheckBox;
    lblMaxPedidos: TLabel;
    edtNumRom: TEditFocus;
    Label23: TLabel;
    lblEmpresa: TLabel;
    edtCodEmpRom: TEditFocus;
    edtNomEmpRom: TEditFocus;
    lblSeqOnd: TLabel;
    edtSeqOnd: TEditFocus;
    pnlRota: TPanel;
    lblDtaRot: TLabel;
    mskDtaRot: TMaskEditFocus;
    Label12: TLabel;
    edtSeqRot: TEditFocus;
    pnlNumRom: TPanel;
    lblRomaneio: TLabel;
    edtRomaneio: TEditFocus;
    chkOndaSeparacaoPorPeso: TCheckBox;
    edtPesoOndaDe: TEditFocus;
    lblPesoOndaAte: TLabel;
    edtPesoOndaAte: TEditFocus;
    chkOndaSeparacaoApenasFaturadorAutomatico: TCheckBox;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTpaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodOpeExit(Sender: TObject);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodTpaExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtSeqRotKeyPress(Sender: TObject; var Key: Char);
    procedure edtBarComKeyPress(Sender: TObject; var Key: Char);
    procedure cmbEntRetChange(Sender: TObject);
    procedure edtQtdProExit(Sender: TObject);
    procedure chkOndaSeparacaoUnicoProdutoClick(Sender: TObject);
    procedure chkSemSeqSepClick(Sender: TObject);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocIniKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocIniChange(Sender: TObject);
    procedure edtLocFinKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocIniSupKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocIniSupChange(Sender: TObject);
    procedure edtLocFinSupKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTraExit(Sender: TObject);
    procedure edtNumLotEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure rdgOndaSeparacaoClick(Sender: TObject);
    procedure chkOndaSeparacaoVariosProdutosClick(Sender: TObject);
    procedure edtNumeroOndaKeyPress(Sender: TObject; var Key: Char);
    procedure chkExclusivamentePedidosKitsClick(Sender: TObject);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodLarEnter(Sender: TObject);
    procedure edtCodLarExit(Sender: TObject);
    procedure edtCodLarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpEnter(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpRomExit(Sender: TObject);
    procedure edtCodEmpRomEnter(Sender: TObject);
    procedure edtCodEmpRomKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure edtSeqOndKeyPress(Sender: TObject; var Key: Char);
    procedure edtRomaneioKeyPress(Sender: TObject; var Key: Char);
    procedure edtSeqRotExit(Sender: TObject);
    procedure chkOndaSeparacaoPorPesoClick(Sender: TObject);
  private
    { Private declarations }
    qryCadOpe: TUniQuery;
    qryCadCli: TUniQuery;
    qryCadTra: TUniQuery;
    qryCadReg: TUniQuery;
    blnCadLoc: Boolean;
    FUsarTelaParaDefinirFoco : Boolean;
    FNomeUltimoComponenteSelecionado : string;
    FComponente : TComponent;
    FUsarTelaParaDefinirFiltroVendedor: Boolean;
    function fValidaVendedores: Boolean;
    procedure pCarregaCliente;
    procedure pCarregaTransportadora;
    procedure pCarregaRegiao;
    procedure pCarregaCidade;
    procedure pCarregaDeptoVendedor;
    procedure pArmazenarNomeComponente(Sender: TObject);

    function fCampoQuantidadeProdutosPedidoOndaEhMenorQueUm(Sender: TWinControl) : Boolean;
    function fRetornaAlturaFinalForm : Integer;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }

    arrLocArm  : TConsultasArray;
    arrCidade  : TConsultasArray;
    arrRegiao  : TConsultasArray;
    arrTpoAte  : TConsultasArray;
    arrOperador: TConsultasArray;
    arrVendedor: TConsultasArray;
    arrClientes: TConsultasArray;
    arrTransportadoras: TConsultasArray;
    arrDepVen  : TConsultasArray;
    arrEmp,
    arrEmpRom  : TConsultasArray;
    strEntRet  : String;
    intQtdPro  : Integer;
    arrRotas : TConsultasArray;

    {Onda de Separação}
    FiltroOnda       : TFiltroOndaSeparacao;
    blnPDExclusivamenteDeKits : Boolean;
    strNumeroOnda    : String;
    blnSolicitaTelaDeVolume : Boolean;
    intQtdPedOnda    : Integer;
    intQtdProOnda    : Integer;
    intQtdProOndaDe  : Integer;
    fltPesoOndaDe    : Double;
    fltPesoOndaAte   : Double;	
    blnSelPedOndaAut : Boolean;
    blnOndaSeparacaoUnicoProduto   : Boolean;
    blnOndaSeparacaoVariosProdutos : Boolean;
    blnOndaSeparacaoPorPeso        : Boolean; 
	blnSemSeqSep                   : Boolean;
    blnHabilitaFiltroPeriodo       : Boolean;
    blnApenasImprimirBaixarSeparacao : Boolean;

    procedure pSetarDefaultVariaveisOndaSeparacao;
    procedure pAtribuirValoresVariaveisOndaSeparacao;
    procedure pOpcoesDefaultPainelOnda;

    property UsarTelaParaDefinirFoco           : boolean read FUsarTelaParaDefinirFoco           write FUsarTelaParaDefinirFoco;
    property UsarTelaParaDefinirFiltroVendedor : boolean read FUsarTelaParaDefinirFiltroVendedor write FUsarTelaParaDefinirFiltroVendedor;
    property NomeUltimoComponenteSelecionado   : string  read FNomeUltimoComponenteSelecionado;
  end;

var
  frmFatExpedicaoBusca: TfrmFatExpedicaoBusca;
const
  SELECAO_PEDIDOS_GERACAO_ONDA = 0;
  FATURAMENTO_ONDA             = 1;
  NAO_UTILIZAR_ONDA_SEPARACAO  = 2;

implementation

uses untfuncoesSimples, untConsultas, Data.DB, untFuncoesConsulta,
  untFatDigCodBarrasComanda, untCfgSugExp;

{$R *.dfm}

procedure TfrmFatExpedicaoBusca.edtSeqOndKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSep: TConsultasArray;
begin
  inherited;
  If fPesqRemessaDeSeparacao(Self, edtSeqOnd, Nil, Key, arrSep, True, True) Then
  Begin
    If fValidaCampos(edtSeqOnd, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExpedicaoBusca.edtSeqRotExit(Sender: TObject);
begin
  inherited;
  If edtSeqRot.Text <> '00000000' Then
    pEdtCodSelectExit(edtSeqRot, Nil, arrRotas, Nil, Nil, 'da Rota');
end;

procedure TfrmFatExpedicaoBusca.edtSeqRotKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEntregasRotasRegiao(Self, edtSeqRot, Nil, Nil, Key, arrRotas, False, '', '', False) Then
	Begin
		If fValidaCampos(edtSeqRot, False) Then
  		Self.SelectNext(ActiveControl, True, True);
	End;
end;

function TfrmFatExpedicaoBusca.fCampoQuantidadeProdutosPedidoOndaEhMenorQueUm(Sender: TWinControl): Boolean;
begin

  Result := False;

  If (FiltroOnda <> fosSelecaoPedidosGeracaoOnda) Then
    Exit;

  If (Sender <> edtQtdProOndaDe) Then
    Exit;

  If (chkOndaSeparacaoUnicoProduto.Checked) Then
    Exit;

  If (strToIntDef(edtQtdProOndaDe.Text, 0) >= 1) Then
    Exit;

  Result := True;

end;

procedure TfrmFatExpedicaoBusca.btnConfirmaClick(Sender: TObject);
begin

  inherited;

  blnHabilitaFiltroPeriodo := ((rdgOndaSeparacao.ItemIndex = 2) And (fEmptyStr(edtNumLot.Text)) And (fEmptyStr(edtNumRom.Text)));

  pAtribuirValoresVariaveisOndaSeparacao;

  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;

end;

function TfrmFatExpedicaoBusca.fRetornaAlturaFinalForm: Integer;
var
  intContador    : Integer;
  intAlturaFinal : Integer;
begin

  intAlturaFinal := 0;

  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If Not (Components[intContador] Is TPanel) Then
      Continue;

    If Not (Components[intContador] As TPanel).Visible Then
      Continue;

    If ((Components[intContador] As TPanel).Name = pnlGeral.Name) Then
      Continue;

    If ((Components[intContador] As TPanel).Name = pnlFiltros.Name) Then
      Continue;

    intAlturaFinal := intAlturaFinal + (Components[intContador] As TPanel).Height;

  End;

  Result := intAlturaFinal;

end;

function TfrmFatExpedicaoBusca.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  var
    intMax : Integer;
    intDig : Integer;
begin

  If (FUsarTelaParaDefinirFoco) Or
     ((FUsarTelaParaDefinirFiltroVendedor) And
      (Not Sender.Enabled))  Then
    Exit(True);

  Result := True;

  If fCampoQuantidadeProdutosPedidoOndaEhMenorQueUm(Sender) Then
  Begin
    fMensagem('ATENÇÃO!', 'O campo "Pedidos de []" deve conter valores acima ou igual a 1!', ['&Ok']);
    pSetFocus(edtQtdProOndaDe);
    Result := False;
  End

  Else If (Sender = edtPesoOndaDe) And (edtPesoOndaDe.Enabled) And (FiltroOnda = fosSelecaoPedidosGeracaoOnda) Then
  Begin
    If StrToFloatDef(edtPesoOndaDe.Text, -1) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo "Pedidos com peso de" deve ser maior ou igual a 0!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtPesoOndaAte) And (edtPesoOndaAte.Enabled) And (FiltroOnda = fosSelecaoPedidosGeracaoOnda) Then
  Begin
    If StrToFloatDef(edtPesoOndaAte.Text, -1) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo "Pedidos com peso até" deve ser maior ou igual a 0!', ['&Ok']);
      Result := False;
    End
    Else If StrToFloatDef(edtPesoOndaAte.Text, 0) < StrToFloatDef(edtPesoOndaDe.Text, 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo "Pedidos com peso até" deve ser maior ou igual ao campo "Pedidos com peso de"!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtNumPed) then
  Begin
    If (blnBuscaPorChave) And (Not fEmptyStr(edtNumPed.Text)) Then
    Begin
      edtNumPed.Text := fStrZero(edtNumPed.Text, edtNumPed.TamCampo);
      btnConfirma.Click;
    End;
  End

  Else If (Sender = edtNumLot) and pnlLoteSep.Visible Then
  Begin
    If not fEmptyStr(edtNumLot.Text) Then
    Begin
      Result := not fEmptyStr(fCampoTabela('AUTOINCREM', 'ROMLGE', ['RLG_NUMLOT', 'RLG_CODEMP'], [edtNumLot.Text, edtCodEmpLote.Text]));
      If not Result Then
        fMensagem('', 'Lote de separação não encontrado!', ['&OK'])
      Else
        btnConfirma.Click;
    End

  End

  Else If (Sender = edtNumRom) and pnlLoteSep.Visible Then
  Begin
    If not fEmptyStr(edtNumRom.Text) Then
    Begin
      Result := not fEmptyStr(fCampoTabela('AUTOINCREM', 'ROMGERX', ['GER_NUMROM', 'GER_EMPROM'], [edtNumRom.Text, edtCodEmpRom.Text]));
      If not Result Then
        fMensagem('', 'Romaneio não encontrado!', ['&OK'])
      Else
        btnConfirma.Click;
    End

  End

  Else If (Sender = edtRomaneio) And (pnlNumRom.Visible) Then
  Begin
    If (Not fEmptyStr(edtRomaneio.Text)) Then
    Begin
      If (fEmptyStr(fCampoTabela('AUTOINCREM', 'ROMGERX', ['GER_NUMROM', 'GER_EMPROM'], [edtRomaneio.Text, Vs_strCodEmp]))) Then
      Begin
        fMensagem('', 'Romaneio não encontrado!', ['&OK']);
        Result := False;
      End
      Else
        btnConfirma.Click;
    End;
  End

  Else If (Sender = edtNumeroOnda) Then
  Begin
    If (blnBuscaPorChave) And (Not fEmptyStr(edtNumeroOnda.Text)) Then
    Begin
      edtNumeroOnda.Text := fStrZero(edtNumeroOnda.Text, edtNumeroOnda.TamCampo);
      pAtribuirValoresVariaveisOndaSeparacao;
      btnConfirma.Click;
    End;
  End

  Else If (Sender = edtBarDoc) then
  Begin
    If blnBuscaPorChave And (Length(edtBarDoc.Text) >= 13) Then
      btnConfirma.Click;
  End

  {Comanda}
  Else If (Sender = edtBarCom) then
  Begin
    If blnBuscaPorChave And (Length(edtBarCom.Text) = edtBarCom.MaxLength) Then
      btnConfirma.Click;
  End

  Else If (Sender = edtSeqSep) then
  Begin
    If (blnBuscaPorChave) And (Not fEmptyStr(edtSeqSep.Text)) Then
    Begin
      edtSeqSep.Text := fStrZero(edtSeqSep.Text, edtSeqSep.TamCampo);
      btnConfirma.Click;
    End;
  End

  Else If (Sender = edtCodVen) And (Not fEmptyStr(edtCodVen.Text)) Then
  Begin
    pDesmarcaLista(edtCodVen, arrVendedor);
    Result := fValidaVendedores;
  End

  Else If (Sender = edtCodIte) then
  Begin
    If (blnBuscaPorChave) And (Not fEmptyStr(edtCodIte.Text)) And (Length(Trim(edtCodIte.Text)) <= fTamCodIte) Then
    Begin
      If Length(edtCodIte.Text) < fTamCodIte Then
        edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte)
      Else If Length(edtCodIte.Text) > fTamCodIte Then
        edtCodIte.Text := fCampoTabela('ITE_CODITE','CADITE',['ITE_CODBAR'],[edtCodIte.Text]);
    End;
  End

  Else If (Sender = edtSepImp) Then
  Begin

    If (fEmptyStr(edtSepImp.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Separação Impressa deve ser preenchido com S, N ou T !', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      If (Pos(edtSepImp.Text,'SNT') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Separação Impressa deve ser preenchido com S, N ou T !!', ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtUrgente) Then
  Begin
    If (Pos(edtUrgente.Text,'SNT') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Urgente deve ser preenchido com S, N ou T !!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatTot) And (pnlFaturamentoTotal.Visible) Then
  Begin
    If (Pos(edtFatTot.Text,'SNT') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo "'+lblFatTot.Caption+'" deve ser preenchido com S, N ou T !', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = cmbOrigem) Then
  Begin
    If (cmbOrigem.ItemIndex = -1) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Origem deve ser informada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtLocFis) Then
  Begin

    If blnCadLoc Then
    Begin

      If (Not fEmptyStr(edtLocFis.Text)) Then
      Begin

        If fEmptyStr(fRetNomLocFisica(edtLocFis.Text)) Then
        Begin
          pMensagemOk('Localização Física não encontrada!');
          Result := False;
        End

      End;

    End;

  End

  Else If (Sender = edtLocIni) Then
  Begin

    If blnCadLoc Then
    Begin

      If (Not fEmptyStr(edtLocIni.Text)) Then
      Begin

        If fEmptyStr(fRetNomLocFisica(edtLocIni.Text)) Then
        Begin
          pMensagemOk('Localização Física Inicial do Estoque não encontrada!');
          Result := False;
        End
        Else
          edtLocFin.Enabled := True;

      End
      Else
      Begin
        edtLocFin.Enabled := False;
        edtLocFin.Clear;
      End;

    End;

  End

  Else If (Sender = edtLocFin) Then
  Begin

    If blnCadLoc Then
    Begin

      If (Not fEmptyStr(edtLocFin.Text)) Then
      Begin

        If fEmptyStr(fRetNomLocFisica(edtLocFin.Text)) Then
        Begin
          pMensagemOk('Localização Física Final do Estoque não encontrada!');
          Result := False;
        End
        Else
        Begin
          If edtLocIni.Text > edtLocFin.Text Then
          Begin
            fMensagem('ATENÇÃO!', 'A Localização Física do Estoque Final não pode ser menor que a Inicial', ['&O k']);
            Result := False;
          End;
        End;

      End
      Else
      Begin
        If (Not fEmptyStr(edtLocIni.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Localização Física do Estoque Final deve ser preenchida.', ['&O k']);
          Result := False;
        End;
      End;

    End;

  End

  {*************************************************}
  {* VALIDACAO DA LOCALIZACAO FISICA SUPER ESTOQUE *}
  {***********************************************FC}
  Else If (Sender = edtLocIniSup) Then
  Begin

    If blnCadLoc Then
    Begin

      If (Not fEmptyStr(edtLocIniSup.Text)) Then
      Begin

        If fEmptyStr(fRetNomLocFisica(edtLocIniSup.Text)) Then
        Begin
          pMensagemOk('Localização Física Inicial do Super Estoque não encontrada!');
          Result := False;
        End
        Else
          edtLocFinSup.Enabled := True;

      End
      Else
      Begin
        edtLocFinSup.Enabled := False;
        edtLocFinSup.Clear;
      End;

    End;

  End

  Else If (Sender = edtLocFinSup) Then
  Begin

    If blnCadLoc Then
    Begin

      If (Not fEmptyStr(edtLocFinSup.Text)) Then
      Begin

        If fEmptyStr(fRetNomLocFisica(edtLocFinSup.Text)) Then
        Begin
          pMensagemOk('Localização Física Final do Super Estoque não encontrada!');
          Result := False;
        End
        Else
        Begin
          If edtLocIniSup.Text > edtLocFinSup.Text Then
          Begin
            fMensagem('ATENÇÃO!', 'A Localização Física do Super Estoque Final não pode ser menor que a Inicial', ['&O k']);
            Result := False;
          End;
        End;

      End
      Else
      Begin
        If (Not fEmptyStr(edtLocIniSup.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Localização Física do Super Estoque Final deve ser preenchida.', ['&O k']);
          Result := False;
        End;
      End;

    End;

  End

  Else If (Sender = edtCodTra) Then
  Begin

  End

  Else If (Sender = mskDtaIni) Then
  Begin

    If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      mskDtaFin.Clear;
      mskDtaFin.Enabled := False;
    End
    Else
      mskDtaFin.Enabled := True;

  End

  Else If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
  Begin

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
       (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&OK']);
        Result := False;
      End;
    End;
    
  End

  Else If (Sender = edtQtdPedOnda) Then
  Begin

    intMax := fCfgSis('ONDMAX', varInteger);

    If TryStrToInt(edtQtdPedOnda.Text, intDig) Then
    Begin
      If (intDig > intMax) Then
      Begin
        fMensagem('Atenção', 'A quantidade de pedidos não pode exceder o limite máximo!', ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtSeqOnd) And (edtSeqOnd.Visible) Then
  Begin
    If Not fEmptyStr(edtSeqOnd.Text) Then
    Begin
      If Not fRemessaDeSeparacaoExiste(edtSeqOnd.Text) Then
      Begin
        fMensagem('Atenção', 'Remessa de Separação não encontrada!', ['&Ok']);
        Result := False;
      End
      Else If fRetornaStatusRemessaDeSeparacao(edtSeqOnd.Text) = 'F' Then
      Begin
        fMensagem('Atenção', 'Remessa de Separação já finalizada!', ['&Ok']);
        Result := False;
      End
      Else If fRetornaStatusRemessaDeSeparacao(edtSeqOnd.Text) = 'P' Then
      Begin
        fMensagem('Atenção', 'Remessa de Separação parcialmente finalizada!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmFatExpedicaoBusca.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadOpe := fCriaQuery(Self);
  qryCadCli := fCriaQuery(Self);
  qryCadTra := fCriaQuery(Self);
  qryCadReg := fCriaQuery(Self);

  blnCadLoc := fCfgSis('CADLOC', varBoolean);

  edtNumPed.MaxLength := fTamDocCadRec();
  edtNumPed.TamCampo  := edtNumPed.MaxLength;

  {Comanda}
  pnlComanda.Visible := fCfgSis('COMAND', varBoolean);

  If Not (fCfgSis('OPEDES', varBoolean) And (Pos(VS_strTipExp, '3_4_') > 0)) Then
    pnlOpeDes.Visible := False;

  If fUsaOndaSeparacaoExpedicao() Then
  Begin

    pnlOndaSeparacao.Visible := True;
    pnlSeqSep.Visible        := False;

    pOpcoesDefaultPainelOnda;

  End
  Else
  Begin

    pSetarDefaultVariaveisOndaSeparacao;
    pnlOndaSeparacao.Visible := False;

    //Se nao usa Rotina com Coletor de dados (gurgel), oculta filtro
    If Not (fUsaRotinaWMS And fConferenciaDepoisDaEntrada) Then
      pnlSeqSep.Visible := False;
  End;

  if not fVerificaAcessoSistema('SPLAUT') then
  begin
    ckbSelPedAut.Visible := False;
    pnlLoteSep.Height := 26;
  end;

  If Not (fCfgSis('ROMLOT', varBoolean) And (Pos(VS_strTipExp, '3_4_') > 0)) Then
  Begin
    pnlLoteSep.Visible := False;
  End
  Else
  Begin
    edtCodEmpLote.Text := VS_strCodEmp;
    edtNomEmpLote.Text := fRetNomeEmpresa;

    edtCodEmpRom.Text := VS_strCodEmp;
    edtNomEmpRom.Text := fRetNomeEmpresa;
  End;

  strEntRet := 'T'; //TODAS

  FUsarTelaParaDefinirFoco := False;
  FUsarTelaParaDefinirFiltroVendedor := False;

  gbSuperEstoque.Visible := not fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica;

  blnHabilitaFiltroPeriodo := True;

  chkSolicitaTelaDeVolume.Visible := fCfgSis('ONDASE', VarBoolean) And fCfgSis('VOLEXP', VarBoolean);

end;

procedure TfrmFatExpedicaoBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (FUsarTelaParaDefinirFoco) Then
  Begin
    If (Key = VK_ESCAPE) Or (Key = VK_RETURN) Then
      Abort;
  End
  Else
    inherited;
end;

procedure TfrmFatExpedicaoBusca.FormPaint(Sender: TObject);
begin
  inherited;

  If (Not FUsarTelaParaDefinirFoco) And
     (Not FUsarTelaParaDefinirFiltroVendedor) then
    Exit;

  if Assigned(FComponente) then
    pSetFocus(TEditFocus(FComponente), Self);
end;

procedure TfrmFatExpedicaoBusca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryCadOpe.Close;
  qryCadCli.Close;
  qryCadTra.Close;
  qryCadReg.Close;

  FreeAndNil(qryCadOpe);
  FreeAndNil(qryCadCli);
  FreeAndNil(qryCadTra);
  FreeAndNil(qryCadReg);
end;

procedure TfrmFatExpedicaoBusca.pArmazenarNomeComponente(Sender: TObject);
begin
  If (Not FUsarTelaParaDefinirFoco) And
     (Not FUsarTelaParaDefinirFiltroVendedor) Then
    Exit;

  if Sender Is TEditFocus then
  begin
    FNomeUltimoComponenteSelecionado := TEditFocus(Sender).Name;
    TEditFocus(Sender).FocusColor    := clYellow;
    FComponente := TEditFocus(Sender);
  end;
end;

procedure TfrmFatExpedicaoBusca.pAtribuirValoresVariaveisOndaSeparacao;
begin

  If (FiltroOnda = fosNaoUtilizarOnda) Then
  Begin
    pSetarDefaultVariaveisOndaSeparacao;
    Exit;
  End;

  {Seleção de pedidos para geração da onda}
  If (FiltroOnda = fosSelecaoPedidosGeracaoOnda) Then
  Begin

    blnOndaSeparacaoUnicoProduto   := chkOndaSeparacaoUnicoProduto.Checked;
    blnOndaSeparacaoVariosProdutos := chkOndaSeparacaoVariosProdutos.Checked;
    blnOndaSeparacaoPorPeso        := chkOndaSeparacaoPorPeso.Checked;
    blnSemSeqSep := chkSemSeqSep.Checked;
    blnPDExclusivamenteDeKits := chkExclusivamentePedidosKits.Checked;

    intQtdProOnda    := strToIntDef(edtQtdProOnda.Text, 0);
    intQtdProOndaDE  := strToIntDef(edtQtdProOndaDe.Text, 0);
    intQtdPedOnda    := strToIntDef(edtQtdPedOnda.Text, 0);
    blnSelPedOndaAut := chkSelPedOndaAut.Checked;
    fltPesoOndaDe    := fStrToFloat(edtPesoOndaDe.Text);
    fltPesoOndaAte   := fStrToFloat(edtPesoOndaAte.Text);

    strNumeroOnda := '';
    blnSolicitaTelaDeVolume := False;

  End

  Else

  {Faturamento da onda de separação}
  If (FiltroOnda = fosFaturamentoLiberacaoOnda) Then
  Begin

    If edtNumeroOnda.Enabled Then
      strNumeroOnda := edtNumeroOnda.Text
    Else
      strNumeroOnda := '';

    If chkSolicitaTelaDeVolume.Visible Then
      blnSolicitaTelaDeVolume := chkSolicitaTelaDeVolume.Checked;

    blnOndaSeparacaoUnicoProduto   := False;
    blnOndaSeparacaoVariosProdutos := False;
    blnOndaSeparacaoPorPeso        := False;
    blnSemSeqSep := chkSemSeqSep.Checked;
    blnPDExclusivamenteDeKits := False;

    edtQtdProOnda.Clear;
    intQtdProOnda := 0;

    edtQtdProOndaDe.Clear;
    intQtdProOndaDe := 0;

    edtQtdPedOnda.Clear;
    intQtdPedOnda := 0;

    edtPesoOndaDe.Clear;
    fltPesoOndaDe := 0;

    edtPesoOndaAte.Clear;
    fltPesoOndaAte := 0;

    blnSelPedOndaAut := False;

  End;

end;

procedure TfrmFatExpedicaoBusca.pCarregaCliente;
begin
  If (Length(arrClientes) = 1) Then Begin
    With qryCadCli Do Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT                 ');
      SQL.Add('  *                    ');
      SQL.Add('FROM                   ');
      SQL.Add('  CADCLI               ');
      SQL.Add('WHERE                  ');
      SQL.Add('  CLI_CODCLI = :CODCLI ');

      ParamByName('CODCLI').AsString := edtCodCli.Text;
      Open;

      edtNomCli.Text := FieldByName('CLI_NOMCLI').AsString;
    End;
  End;
end;

procedure TfrmFatExpedicaoBusca.pCarregaTransportadora;
begin
  If (Length(arrTransportadoras) = 1) Then
  Begin
    With qryCadTra Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT                 ');
      SQL.Add('  *                    ');
      SQL.Add('FROM                   ');
      SQL.Add('  CADTRA               ');
      SQL.Add('WHERE                  ');
      SQL.Add('  TRA_CODTRA = :CODTRA ');

      ParamByName('CODTRA').AsString := edtCodTra.Text;
      Open;

      edtNomTra.Text := FieldByName('TRA_NOMTRA').AsString;
    End;
  End;
end;

procedure TfrmFatExpedicaoBusca.pCarregaDeptoVendedor;
begin
  If (Length(arrDepVen) = 1) Then
    edtCodDep.Text := arrDepVen[0].strCodigo
  Else If (Length(arrDepVen) > 1) Then
  Begin
    edtCodDep.Text := '000';
    edtNomDep.Text := '+1';
  End;

  If (Length(arrDepVen) > 0) Then
    edtCodDepExit(edtCodDep);
end;

procedure TfrmFatExpedicaoBusca.pCarregaRegiao;
begin
  If (Length(arrRegiao) = 1) Then Begin
    With qryCadReg Do Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT                 ');
      SQL.Add('  *                    ');
      SQL.Add('FROM                   ');
      SQL.Add('  CADREG               ');
      SQL.Add('WHERE                  ');
      SQL.Add('  REG_CODREG = :CODREG ');

      ParamByName('CODREG').AsString := edtCodReg.Text;
      Open;

      edtDesReg.Text := FieldByName('REG_DESREG').AsString;
    End;
  End;
end;

procedure TfrmFatExpedicaoBusca.pCarregaCidade;
begin
  If (Length(arrCidade) = 1) Then
    edtNomCid.Text := fRetNomCidade(edtCodCid.Text)
end;

function TfrmFatExpedicaoBusca.fValidaVendedores: Boolean;
  Var
    strInativos : String;

  procedure pLancaVendedorNoArray(strCodigo: String; Var arrLinha: TConsultasArray);
  Begin
    If Not fEmptyStr(strCodigo) Then
    Begin
      SetLength(arrLinha, 1);
      arrLinha[0].strCodigo := strCodigo;
    End
  End;
begin
  Result := True;
  strInativos := EmptyStr;

  If fEmptyStr(edtCodVen.Text) Then
    Exit();

  qryCadOpe.Close;
  qryCadOpe.SQL.Clear;
  qryCadOpe.SQL.Add('SELECT                 ');
  qryCadOpe.SQL.Add('  *                    ');
  qryCadOpe.SQL.Add('FROM                   ');
  qryCadOpe.SQL.Add('  CADOPE               ');
  qryCadOpe.SQL.Add('WHERE                  ');
  qryCadOpe.SQL.Add('  OPE_CODOPE IN (:CODOPE) ');

  If (Length(arrVendedor) > 0) Then
    qryCadOpe.SQL.Text := StringReplace(qryCadOpe.SQL.Text, ':CODOPE', fRetArrToSQLIn(arrVendedor, ''), [rfReplaceAll])
  Else
    qryCadOpe.ParamByName('CODOPE').AsString := edtCodVen.Text;

  qryCadOpe.Open;

  If (qryCadOpe.RecordCount = 1) Then
  Begin
    edtNomVen.Text := qryCadOpe.FieldByName('OPE_NOMOPE').AsString;

    If (Length(arrVendedor) = 0) Then
      pLancaVendedorNoArray(edtCodVen.Text, arrVendedor);
  End
  Else If (qryCadOpe.RecordCount = 0) Then
    edtNomVen.Text := '';

  If qryCadOpe.FieldByName('OPE_CODOPE').IsNull Then
  Begin
    fMensagem('ATENÇÃO!', 'O vendedor '+qryCadOpe.FieldByName('OPE_CODOPE').AsString+' não está cadastrado!', ['&Ok']);
    Exit(False);
  End;

  qryCadOpe.First;
  While Not qryCadOpe.Eof Do
  Begin
    If qryCadOpe.FieldByName('OPE_STATUS').AsString <> 'A' Then
    Begin
      If (fEmptyStr(strInativos)) Then
        strInativos := qryCadOpe.FieldByName('OPE_CODOPE').AsString
      Else
        strInativos := strInativos + ', ' + qryCadOpe.FieldByName('OPE_CODOPE').AsString;
    End;

    qryCadOpe.Next;
  End;

  If Not fEmptyStr(strInativos) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esses vendedores estão inativos: '+strInativos+'!', ['&Ok']);
  End;

  Result := fEmptyStr(strInativos);
end;

procedure TfrmFatExpedicaoBusca.pOpcoesDefaultPainelOnda;
begin
  pSetarDefaultVariaveisOndaSeparacao;
  rdgOndaSeparacao.ItemIndex := NAO_UTILIZAR_ONDA_SEPARACAO;
  NBOndaSeparacao.PageIndex  := NAO_UTILIZAR_ONDA_SEPARACAO;
end;

procedure TfrmFatExpedicaoBusca.pSetarDefaultVariaveisOndaSeparacao;
begin
  FiltroOnda       := fosNaoUtilizarOnda;
  blnPDExclusivamenteDeKits := False;
  strNumeroOnda    := '';
  blnSolicitaTelaDeVolume := False;
  intQtdPedOnda    := 0;
  intQtdProOnda    := 0;
  intQtdProOndaDe  := 0;
  fltPesoOndaDe    := 0;
  fltPesoOndaAte   := 0;
  blnSelPedOndaAut := False;
  blnOndaSeparacaoUnicoProduto   := False;
  blnOndaSeparacaoVariosProdutos := False;
  blnOndaSeparacaoPorPeso        := False;
  blnSemSeqSep                   := False;
end;

procedure TfrmFatExpedicaoBusca.rdgOndaSeparacaoClick(Sender: TObject);
begin
  inherited;

  NBOndaSeparacao.PageIndex := rdgOndaSeparacao.ItemIndex;
  chkSelPedOndaAut.Enabled  := True;

  Case rdgOndaSeparacao.ItemIndex Of
    0: Begin
         FiltroOnda := fosSelecaoPedidosGeracaoOnda;
         chkSemSeqSep.Checked := True;
         chkSemSeqSepClick(Nil);

         If fUsaOndaSeparacaoExpedicaoWMS Then
           chkSelPedOndaAut.Checked := True;
       End;
    1: Begin
         FiltroOnda := fosFaturamentoLiberacaoOnda;
         chkSemSeqSep.Checked := False;
         chkSemSeqSepClick(Nil);
       End;
    2: Begin
         FiltroOnda := fosNaoUtilizarOnda;
         pSetarDefaultVariaveisOndaSeparacao;
         chkSemSeqSepClick(Nil);
       End;
  End;

end;

procedure TfrmFatExpedicaoBusca.edtCodVenExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodVen.Text) Then
  Begin
    pDesmarcaLista(edtCodVen, arrVendedor);
    edtNomVen.Text := 'TODOS';
  End;
end;

procedure TfrmFatExpedicaoBusca.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (fEntraCons(Key)) Then
  Begin
    If fPesqOperador(Self, edtCodVen, edtNomVen, qryCadOpe, Key, arrVendedor, False) Then
    Begin
      If fValidaCampos(edtCodVen, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmFatExpedicaoBusca.edtLocFinKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocFin, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocFin, True) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmFatExpedicaoBusca.edtLocFinSupKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If blnCadLoc And fPesqLocFisica(Self, edtLocFinSup, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocFinSup, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmFatExpedicaoBusca.edtLocFisKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocFis, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocFis, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmFatExpedicaoBusca.edtLocIniChange(Sender: TObject);
begin
  inherited;
  edtLocFin.Enabled := Not fEmptyStr(edtLocIni.Text);
end;

procedure TfrmFatExpedicaoBusca.edtLocIniKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocIni, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocIni, True) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmFatExpedicaoBusca.edtLocIniSupChange(Sender: TObject);
begin
  inherited;
  edtLocFinSup.Enabled := Not fEmptyStr(edtLocIniSup.Text);
end;

procedure TfrmFatExpedicaoBusca.edtLocIniSupKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocIniSup, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocIniSup, True) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmFatExpedicaoBusca.edtNumeroOndaKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqOndaSeparacao(Self, edtNumeroOnda, Nil, Key, arrSel) Then
  Begin
    if fValidaCampos(edtNumeroOnda, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatExpedicaoBusca.edtNumLotEnter(Sender: TObject);
begin
  pArmazenarNomeComponente(Sender);
end;

procedure TfrmFatExpedicaoBusca.edtNumLotKeyPress(Sender: TObject;
  var Key: Char);
var
  qryConsulta: TUniQuery;
  arrSel     : TConsultasArray;
begin
  inherited;

  qryConsulta := fCriaQuery(Self);
  
  try
    if fPesqRomaneioLoteSeparacao(Self, edtNumLot, qryConsulta, Key, arrSel, True, VS_strCodEmp, True) then
    begin
      if (fValidaCampos(edtNumLot, True)) then
        SelectNext(ActiveControl, True, True);
    end;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

procedure TfrmFatExpedicaoBusca.edtQtdProExit(Sender: TObject);
begin
  inherited;
  intQtdPro := 0;
  If not fEmptyStr(edtQtdPro.Text) Then
    intQtdPro := StrToIntDef(edtQtdPro.Text, 0);
end;

procedure TfrmFatExpedicaoBusca.edtRomaneioKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryConsulta: TUniQuery;
begin
  inherited;
  qryConsulta := fCriaQuery(Self);

  Try
    If (fPesqRomaneio(Self, edtRomaneio, qryConsulta, Key, arrSel, '', True, True, 'Consulta de Romaneios')) Then
    Begin
      If (fValidaCampos(edtRomaneio, True)) Then
        SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmFatExpedicaoBusca.chkExclusivamentePedidosKitsClick(Sender: TObject);
begin
  inherited;

  chkOndaSeparacaoUnicoProduto.Enabled   := True;
  chkOndaSeparacaoVariosProdutos.Enabled := True;
  edtQtdProOnda.Enabled                  := True;
  edtQtdProOndaDe.Enabled                := True;

  If (chkExclusivamentePedidosKits.Checked) Then
  Begin

    chkOndaSeparacaoVariosProdutos.Checked := True;
    chkOndaSeparacaoVariosProdutosClick(Self);

    chkOndaSeparacaoUnicoProduto.Enabled   := False;
    chkOndaSeparacaoVariosProdutos.Enabled := False;

    edtQtdProOndaDe.Text    := '2';
    edtQtdProOndaDe.Enabled := False;

    edtQtdProOnda.Text    := '999999';
    edtQtdProOnda.Enabled := False;

  End;

end;

procedure TfrmFatExpedicaoBusca.chkOndaSeparacaoPorPesoClick(Sender: TObject);
begin
  inherited;
  If chkOndaSeparacaoPorPeso.Checked And pnlOndaSeparacao.Visible Then
  Begin
    edtPesoOndaDe.Enabled  := True;
    edtPesoOndaAte.Enabled := True;
  End
  Else
  Begin
    edtPesoOndaDe.Enabled  := False;
    edtPesoOndaDe.Text     := '0';

    edtPesoOndaAte.Enabled := False;
    edtPesoOndaAte.Text    := '9999';
  End;
end;

procedure TfrmFatExpedicaoBusca.chkOndaSeparacaoUnicoProdutoClick(Sender: TObject);
begin

  inherited;

  If chkOndaSeparacaoUnicoProduto.Checked And pnlOndaSeparacao.Visible Then
  Begin

    edtQtdPro.Enabled := False;
    intQtdPro         := 1;
    edtQtdPro.Text    := '1';

    edtQtdProOndaDe.Enabled := False;
    edtQtdProOndaDe.Text    := '0';

    edtQtdProOnda.Enabled := False;
    edtQtdProOnda.Text    := '1';

    chkOndaSeparacaoVariosProdutos.Checked := False;

  End;

end;

procedure TfrmFatExpedicaoBusca.chkOndaSeparacaoVariosProdutosClick(Sender: TObject);
begin

  inherited;

  If chkOndaSeparacaoVariosProdutos.Checked And pnlOndaSeparacao.Visible Then
  Begin

    edtQtdPro.Enabled := False;
    edtQtdPro.Clear;

    edtQtdProOndaDe.Enabled := True;
    edtQtdProOndaDe.Text := '2';

    edtQtdProOnda.Enabled := True;
    edtQtdProOnda.Text := '999999';

    chkOndaSeparacaoUnicoProduto.Checked := False;

  End;

end;

procedure TfrmFatExpedicaoBusca.chkSemSeqSepClick(Sender: TObject);
begin
  inherited;
  edtSepImp.Text    := IIF(chkSemSeqSep.Checked, 'N', 'T');
  edtSepImp.Enabled := IIF((FiltroOnda <> fosNaoUtilizarOnda), False, True);
end;

procedure TfrmFatExpedicaoBusca.cmbEntRetChange(Sender: TObject);
begin
  inherited;

  If (cmbEntRet.ItemIndex = 0) Then
    strEntRet := 'R' //RETIRA
  Else If (cmbEntRet.ItemIndex = 1) Then
    strEntRet := 'E' //ENTREGA
  Else
    strEntRet := 'T'; //TODAS
end;

procedure TfrmFatExpedicaoBusca.edtBarComKeyPress(Sender: TObject; var Key: Char);
begin

  inherited;

  if (Key = #13) and (Length(edtBarCom.Text) = edtBarCom.MaxLength) then
  begin

    {Valida faixa permitida!}
    if not TfrmFatDigCodBarrasComanda.fComandaEstaDentroFaixa(edtBarCom.Text) then
    begin
      fMensagem('Atenção', 'Código da comanda esta fora da faixa permitida!', ['&Ok']);
      edtBarCom.Clear;
      pSetFocus(edtBarCom);
    end;

  end;

end;

procedure TfrmFatExpedicaoBusca.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtNomCid, arrCidade, fRetNomCidadeSemOpc, Nil, 'da Cidade');

end;

procedure TfrmFatExpedicaoBusca.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtNomCid, Nil, Nil, Key, arrCidade, False) Then
  Begin
    fValidaCampos(edtCodCid, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExpedicaoBusca.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmFatExpedicaoBusca.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExpedicaoBusca.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtNomDep, arrDepVen, fRetNomDep, nil, 'do Departamento do Vendedor');
end;

procedure TfrmFatExpedicaoBusca.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtNomDep, Nil, Key, arrDepVen, False) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExpedicaoBusca.edtCodEmpEnter(Sender: TObject);
begin
  inherited;
  pArmazenarNomeComponente(Sender);
end;

procedure TfrmFatExpedicaoBusca.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
end;

procedure TfrmFatExpedicaoBusca.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False, True) then
  begin
    if fValidaCampos(edtCodEmp) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmFatExpedicaoBusca.edtCodEmpRomEnter(Sender: TObject);
begin
  inherited;
  pArmazenarNomeComponente(Sender);
end;

procedure TfrmFatExpedicaoBusca.edtCodEmpRomExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpRom, edtNomEmpRom, arrEmpRom, fRetNomeEmpresa, nil, 'da empresa', 3);
end;

procedure TfrmFatExpedicaoBusca.edtCodEmpRomKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqEmpresa(conEmpSimples, Self, edtCodEmpRom, edtNomEmpRom, Nil, Key, arrEmpRom, True, True) then
  begin
    if fValidaCampos(edtCodEmpRom) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmFatExpedicaoBusca.edtCodIteExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodIte.Text) Then
  Begin
    edtDesIte.Clear;
    Exit;
  End;

  If Length(Trim(edtCodIte.Text)) <= fTamCodIte Then
  Begin
    edtDesIte.Text := fRetDescricao(edtCodIte.Text, 'CADITE', 'ITE_CODITE', 'ITE_DESITE');
  End
  Else
  Begin
    edtCodIte.Text := fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODBAR'], [edtCodIte.Text]);
    edtDesIte.Text := fRetDescricao(edtCodIte.Text, 'CADITE', 'ITE_CODITE', 'ITE_DESITE');
  End;
end;

procedure TfrmFatExpedicaoBusca.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
      If fValidaCampos(edtCodIte, True) Then
        Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExpedicaoBusca.edtCodLarEnter(Sender: TObject);
begin
  inherited;
  pArmazenarNomeComponente(Sender);
end;

procedure TfrmFatExpedicaoBusca.edtCodLarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodLar, edtDesLar, arrLocArm, Nil, fRetLocalArmazenamentoWMS, 'do Local de Armazenamento');
end;

procedure TfrmFatExpedicaoBusca.edtCodLarKeyPress(Sender: TObject; var Key: Char);
begin

  inherited;

  If fPesqLocalArmazenamentoWms(Self, edtCodLar, edtDesLar, Nil, Key, arrLocArm, False) Then
  Begin
    if fValidaCampos(edtCodLar, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatExpedicaoBusca.edtCodOpeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodOpe, edtNomOpe, arrOperador, fRetNomeOperador, nil, 'do Operador', 3);
end;

procedure TfrmFatExpedicaoBusca.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodOpe, edtNomOpe, nil, Key, arrOperador, False, True) Then Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExpedicaoBusca.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg, edtDesReg, arrRegiao, fRetDesReg, nil, 'da Região');
end;

procedure TfrmFatExpedicaoBusca.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegiao, False) Then
  Begin
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExpedicaoBusca.edtCodTpaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodTpa, edtDesTpa, arrTpoAte, fRetNomTipoAtend, Nil, 'do Tipo de Atendimento');
end;

procedure TfrmFatExpedicaoBusca.edtCodTpaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqTipoAtendimento(Self, edtCodTpa, edtDesTpa, Nil, Key, arrTpoAte, False) Then Begin
    If fValidaCampos(edtCodTpa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExpedicaoBusca.edtCodTraExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodTra, edtNomTra, arrTransportadoras, fRetNomTransportadora, Nil, 'da Transportadora');
end;

procedure TfrmFatExpedicaoBusca.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtNomTra, Nil, Key, arrTransportadoras, False) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatExpedicaoBusca.FormShow(Sender: TObject);
var LNomeCampoParaFoco : string;

  procedure pInicializarEditsArray(Var edtCodigo, edtDescri: TEditFocus);
  begin
    edtCodigo.Text := StringOfChar('0', edtCodigo.TamCampo);
    edtDescri.Text := '+1';
  end;

begin
  inherited;

  lblMaxPedidos.Caption := '(Máximo ' + fCfgSis('ONDMAX', varString) + ' pedidos)';

  pnlLocalDeArmazenamento.Visible := fSolicitaLocalDeArmazenamento;

  edtEspecie.Visible := (VS_strTipExp = '2');
  lblEspecie.Visible := (VS_strTipExp = '2');
  pnlBarDoc.Visible  := (VS_strTipExp = '3') or (VS_strTipExp = '4') or (VS_strTipExp = '2');
  pnlTipAte.Visible  := Not (VS_strTipExp = '2');

  edtSeqOnd.Visible := fUsaOndaSeparacaoAgrupamento;
  lblSeqOnd.Visible := edtSeqOnd.Visible;

  chkExclusivamentePedidosKits.Enabled := (fCfgSis('EXPKIT', varBoolean));

  If fCfgSis('OBRSBR', varBoolean) And ( not fVerificaAcessoSistema('LIB_F3') ) Then
    pnlFiltros.Enabled := False;

  pnlRota.Visible   := ((VS_strTipExp = '3') Or (VS_strTipExp = '4')) And (fCfgSis('REGCID', varBoolean));
  pnlNumRom.Visible := ((VS_strTipExp = '3') Or (VS_strTipExp = '4')) And (Not fCfgSis('ROMLOT', varBoolean));
  pnlRomaneio.Visible := (pnlRota.Visible) Or (pnlNumRom.Visible);
  pnlLocFis.Visible := (Not fUsaRotinaWMS()) And '3_4_'.Contains(VS_strTipExp);

  If (Length(arrVendedor) > 1) Then
    pInicializarEditsArray(edtCodVen, edtNomVen)
  Else If (Length(arrVendedor) = 1) Then
  Begin
    edtCodVen.Text := arrVendedor[0].strCodigo;
    edtNomVen.Text := fRetNomeOperador(edtCodVen.Text);
  End;

  If (Length(arrClientes) > 1) Then
    pInicializarEditsArray(edtCodCli, edtNomCli)
  Else If (Length(arrClientes) = 1) Then
    edtCodCli.Text := arrClientes[0].strCodigo;

  If (Length(arrTransportadoras) > 1) Then
    pInicializarEditsArray(edtCodTra, edtNomTra)
  Else If (Length(arrTransportadoras) = 1) Then
    edtCodTra.Text := arrTransportadoras[0].strCodigo;

  If (Length(arrLocArm) > 1) Then
    pInicializarEditsArray(edtCodLar, edtDesLar)
  Else
  If (Length(arrLocArm) = 1) Then
  Begin
    edtCodLar.Text := arrLocArm[0].strCodigo;
    edtDesLar.Text := arrLocArm[0].strDescri;
  End;

  if (Length(arrEmp) > 1) then
    pInicializarEditsArray(edtCodEmp, edtNomEmp)
  else if (Length(arrEmp) = 1) then
  begin
    edtCodEmp.Text := arrEmp[0].strCodigo;
    edtNomEmp.Text := arrEmp[0].strDescri;
  end;

  If intQtdPro > 0 Then
    edtQtdPro.Text := IntToStr(intQtdPro);

  If pnlOndaSeparacao.Visible Then
  Begin

    If fUsaOndaSeparacaoAgrupamento Then
    Begin
      lblNumeroOnda.Caption := 'Remessa de Pedido:';
      lblQtdPedOnda.Caption := 'Quantidade de pedidos por remessa:';

      rdgOndaSeparacao.Caption  := 'Remessa de Pedido';
      rdgOndaSeparacao.Items[0] := IIF(fUsaOndaSeparacaoExpedicaoWMS, 'Seleção de pedidos (Gerar remessa / Separar)', 'Seleção de pedidos para geração de remessa');
      rdgOndaSeparacao.Items[1] := 'Faturamento de Remessa';
      rdgOndaSeparacao.Items[2] := 'Não utilizar remessa de pedido';
    End
    Else
    Begin
      lblNumeroOnda.Caption := 'Seq. Onda Separação:';
      lblQtdPedOnda.Caption := 'Quantidade de pedidos por onda:';

      rdgOndaSeparacao.Caption  := 'Onda de Separação';
      rdgOndaSeparacao.Items[0] := IIF(fUsaOndaSeparacaoExpedicaoWMS, 'Seleção de pedidos (Gerar onda / Separar)', 'Seleção de pedidos para geração de onda');
      rdgOndaSeparacao.Items[1] := IIF(blnApenasImprimirBaixarSeparacao, 'Liberar onda para expedição', 'Faturamento de Onda');
      rdgOndaSeparacao.Items[2] := 'Não utilizar onda de separação';
    End;

    If (FiltroOnda = fosSelecaoPedidosGeracaoOnda) Then
    Begin

      chkOndaSeparacaoUnicoProduto.Checked := blnOndaSeparacaoUnicoProduto;
      chkOndaSeparacaoUnicoProdutoClick(Nil);

      chkOndaSeparacaoVariosProdutos.Checked := blnOndaSeparacaoVariosProdutos;
      chkOndaSeparacaoVariosProdutosClick(Nil);

      chkOndaSeparacaoPorPeso.Checked := blnOndaSeparacaoPorPeso;
      chkOndaSeparacaoPorPesoClick(Nil);

      chkSemSeqSep.Checked := blnSemSeqSep;
      chkSemSeqSepClick(Nil);

      chkExclusivamentePedidosKits.Checked := blnPDExclusivamenteDeKits;

      edtQtdProOnda.Text   := IntToStr(intQtdProOnda);
      edtQtdProOndaDe.Text := IntToStr(intQtdProOndaDe);

      edtPesoOndaDe.Text  := FloatToStr(fltPesoOndaDe);
      edtPesoOndaAte.Text := FloatToStr(fltPesoOndaAte);

      edtQtdPedOnda.Text := IntToStr(intQtdPedOnda);
      chkSelPedOndaAut.Checked := blnSelPedOndaAut;

      rdgOndaSeparacao.ItemIndex := SELECAO_PEDIDOS_GERACAO_ONDA;
      NBOndaSeparacao.PageIndex  := SELECAO_PEDIDOS_GERACAO_ONDA;
    End

    Else

    If (FiltroOnda = fosFaturamentoLiberacaoOnda) Then
    Begin

      edtNumeroOnda.Text := strNumeroOnda;
      chkSolicitaTelaDeVolume.Checked := blnSolicitaTelaDeVolume;
      rdgOndaSeparacao.ItemIndex := FATURAMENTO_ONDA;
      NBOndaSeparacao.PageIndex  := FATURAMENTO_ONDA;

    End

    Else

    If (FiltroOnda = fosNaoUtilizarOnda) Then
    Begin
      pSetarDefaultVariaveisOndaSeparacao;
      rdgOndaSeparacao.ItemIndex := NAO_UTILIZAR_ONDA_SEPARACAO;
      NBOndaSeparacao.PageIndex  := NAO_UTILIZAR_ONDA_SEPARACAO;
    End;

  End;

  If (Length(arrOperador) > 1) Then
    pInicializarEditsArray(edtCodOpe, edtNomOpe)
  Else If (Length(arrOperador) = 1) Then Begin
    edtCodOpe.Text := arrOperador[0].strCodigo;
    edtNomOpe.Text := fRetNomeOperador(arrOperador[0].strCodigo);
  End;

  If (Length(arrRegiao) > 1) Then
    pInicializarEditsArray(edtCodReg, edtDesReg)
  Else If (Length(arrRegiao) = 1) Then
    edtCodReg.Text := arrRegiao[0].strCodigo;

  If (Length(arrCidade) > 1) Then
    pInicializarEditsArray(edtCodCid, edtNomCid)
  Else If (Length(arrCidade) = 1) Then
    edtCodCid.Text := arrCidade[0].strCodigo;

  If (Length(arrRotas) > 1) Then
    edtSeqRot.Text := StringOfChar('0', edtSeqRot.TamCampo)
  Else If (Length(arrRotas) = 1) Then
    edtSeqRot.Text := arrRotas[0].strCodigo;

  If (pnlTipAte.Visible) Then Begin
    If (Length(arrTpoAte) > 1) Then
      pInicializarEditsArray(edtCodTpa, edtDesTpa)
    Else If (Length(arrTpoAte) = 1) Then Begin
      edtCodTpa.Text := arrTpoAte[0].strCodigo;
      edtDesTpa.Text := fRetNomTipoAtend(arrTpoAte[0].strCodigo);
    End;
  End;

  If (Not FUsarTelaParaDefinirFoco) Then
    fValidaVendedores;

  pCarregaCliente;
  pCarregaTransportadora;
  pCarregaRegiao;
  pCarregaCidade;
  pCarregaDeptoVendedor;

  if (not FUsarTelaParaDefinirFoco) then
  begin
    If fEmptyStr(edtSepImp.Text) Then
      edtSepImp.Text := 'T';
  end
  else
    edtNomEmpLote.Text := '';

  LNomeCampoParaFoco := TCfgSugExp.fCarregaCampoParaFocus('TfrmFatExpedicaoBusca');
  if not fEmptyStr(LNomeCampoParaFoco) then
  begin
    FComponente := FindComponent(LNomeCampoParaFoco);
    if FComponente.ClassName = 'TEditFocus' then
      pSetFocus(TEditFocus(FComponente));

    if (pnlLoteSep.Visible) and (ckbSelPedAut.Visible) then
      pSetFocus(ckbSelPedAut);
  end
  else
  begin
    If pnlLoteSep.Visible Then
    Begin
      if ckbSelPedAut.Visible then
        pSetFocus(ckbSelPedAut)
      Else
        pSetFocus(edtNumLot);
    End
    Else If pnlComanda.Visible Then
      pSetFocus(edtBarCom)
    Else If pnlSeqSep.Visible Then
      pSetFocus(edtSeqSep)
    Else If pnlBarDoc.Visible Then
      pSetFocus(edtBarDoc)
    Else
      pSetFocus(edtCodVen);
  end;

  pnlEntRet.Visible := (VS_strTipExp = '2');
  pnlFaturamentoTotal.Visible := fCfgSis('FTEXPC', varBoolean);

  Self.Height := fRetornaAlturaFinalForm;

end;

end.
