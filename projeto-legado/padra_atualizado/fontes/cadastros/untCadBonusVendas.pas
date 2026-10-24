unit untCadBonusVendas;

interface

uses
  Windows, Classes, Controls, Forms, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  DB, UniClientDataSet, Mask, MaskEditFocus, DBCtrls, Grids, DBGridCitel, DBGrids, ComCtrls, EditFocus,
  untBonGer, Uni, AppEvnts, BitBtnLockedIncrem, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadBonusVendas = class(TfrmPai)
    pnlBonus: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    edtDesRed: TEditFocus;
    edtDesCli: TEditFocus;
    edtDesBmg: TEditFocus;
    edtCodBmg: TEditFocus;
    edtCodRed: TEditFocus;
    edtCodCli: TEditFocus;
    pgcDados: TPageControl;
    tbsProdutos: TTabSheet;
    pnlProdutos: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    edtCodIte: TEditFocus;
    edtReferencia: TEditFocus;
    edtVlrDesIte: TEditFocus;
    edtDesUni: TEditFocus;
    edtDesIte: TEditFocus;
    dbgItens: TDBGridCitel;
    pnlResumo: TPanel;
    lblTotDesIte: TLabel;
    tbsGenerica: TTabSheet;
    pnlResumo1: TPanel;
    lblTotDesGen: TLabel;
    dbgItens2: TDBGridCitel;
    pnlGenerico: TPanel;
    lblOpcao: TLabel;
    Label26: TLabel;
    Label20: TLabel;
    edtCodOpc: TEditFocus;
    edtVlrDesGen: TEditFocus;
    edtDesOpc: TEditFocus;
    rdgOpcao: TRadioGroup;
    pnlDadosAdicionais: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    edtObs1: TEditFocus;
    edtObs2: TEditFocus;
    edtObs3: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    dtsItens: TDataSource;
    cdsItens2: TUniClientDataSet;
    cdsItens2CODOPC: TStringField;
    cdsItens2DESOPC: TStringField;
    cdsItens2VLRDES: TFloatField;
    cdsItens2OPCAO: TStringField;
    cdsItens2AUTINC: TStringField;
    cdsItens2AGG_TOTDES: TAggregateField;
    dtsItens2: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensITESIM: TStringField;
    cdsItensAUTINC: TStringField;
    cdsItensVLRDES: TFloatField;
    cdsItensAGG_TOTDES: TAggregateField;
    btnConfirmar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem2: TBitBtnLocked;
    btnAdicionar2: TBitBtnLocked;
    procedure edtCodBmgKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodOpcKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpcExit(Sender: TObject);
    procedure btnAdicionar2Click(Sender: TObject);
    procedure btnCancelaItem2Click(Sender: TObject);
    procedure dbgItens2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgOpcaoClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodBmgExit(Sender: TObject);
    procedure dtsItensDataChange(Sender: TObject; Field: TField);
    procedure dtsItens2DataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsItensAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }

    objBonGer: TBonGer;
    intOnExit: Integer;
    strNomPro: String;
    strRefere: String;
    strMarca : String;
    strUnidad: String;

    strProdExcluidos: String;
    strGenExcluidos : String;

    intrdgInd: Integer;

    procedure pLimpaEdits(blnBonus: Boolean = False; blnProdutos: Boolean = False;
    blnDadosAdicionais: Boolean = False; blnGenerica: Boolean = False);
    procedure pCarregaItensAlteracao;
    procedure pCarregaItensAlteracao2;
    procedure pCancelarDados;
    procedure pLimpaDataSet(DataSet: TUniClientDataSet);

//    function fConsisteSimilaridade(strCodIte: String): Boolean;

  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;

  public
    { Public declarations }
  end;

implementation

uses SysUtils, untFuncoesSimples, untConsultas, untRedeLojas, untTypesSistema;

{$R *.dfm}

{*******************************************}
{* VALIDA CAMPOS                           *}
{****************************************RL*}
function TfrmCadBonusVendas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA DATA INICIAL                   *}
    {**************************************RL*}
    If (Sender = mskDtaIni) And (pnlDadosAdicionais.Visible) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data de início da campanha deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Try
        StrToDate(mskDtaIni.Text);
      Except
        fMensagem('ATENÇÃO!', 'Data inválida!', ['&Ok']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA DATA FINAL                     *}
    {**************************************RL*}
    Else If (Sender = mskDtaFin) And (pnlDadosAdicionais.Visible) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data de término da campanha deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Try
        StrToDate(mskDtaFin.Text);

        If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data de início deve ser menor ou igual a data de término!', ['&Ok']);
          Result := False;
        End;
      Except
        fMensagem('ATENÇÃO!', 'Data inválida!', ['&Ok']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA NOME DO BÔNUS                  *}
    {**************************************RL*}
    Else If (Sender = edtDesBmg) Then
    Begin

      If (fEmptyStr(edtDesBmg.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O nome do bônus deve ser preenchido !', ['&Ok']);
        Result := False;
      End

    End

    {*****************************************}
    {* VALIDA REDE DE LOJAS                  *}
    {**************************************RL*}
    Else If (Sender = edtCodRed) Then
    Begin

      If (Not fEmptyStr(edtCodRed.Text)) And (Not fEmptyStr(edtCodCli.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para informar o nome da rede de loja, o cliente !' + #13 +
                  'não pode estar preenchido! Selecione a Rede ou o Cliente participante.' , ['&Ok']);

        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA CLIENTE                        *}
    {**************************************RL*}
    Else If (Sender = edtCodCli) Then
    Begin

      If (Not fEmptyStr(edtCodRed.Text)) And (Not fEmptyStr(edtCodCli.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para informar o nome do cliente, a rede de loja' + #13 +
                  'não pode estar preenchida! Selecione a Rede ou o Cliente participante.' , ['&Ok']);

        Result := False;
      End
      Else If (fEmptyStr(edtCodRed.Text)) And (fEmptyStr(edtCodCli.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Cliente ou Rede participante!', ['&Ok']);
        Result := False;
      End

    End

    {*****************************************}
    {* VALIDA PRODUTO                        *}
    {**************************************RL*}
    Else If (Sender = edtCodIte) Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin

        If (cdsItens.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'O código do produto deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          pSetFocus(dbgItens);
          blnMudarFoco := False;
        End;

      End;

    End

    {*****************************************}
    {* VALIDA DESCONTO DE PRODUTOS           *}
    {**************************************RL*}
    Else If (Sender = edtVlrDesIte) Then
    Begin

      If fEmptyStr(edtVlrDesIte.Text) Then
      Begin

        fMensagem('ATENÇÃO!', 'O valor do produto deve ser preenchido !', ['&Ok']);
        Result := False;

      End
      Else If fStrToFloat(edtVlrDesIte.Text) <= 0 Then
      Begin

        fMensagem('ATENÇÃO!', 'O valor deve ser maior que Zero!', ['&O k']);
        Result := False;

      End;

    End

    {*****************************************}
    {* VALIDA OPÇÃO DO BÔNUS GENÉRICO        *}
    {**************************************RL*}
    Else If (Sender = edtCodOpc) Then
    Begin

      If fEmptyStr(edtCodOpc.Text) Then
      Begin

        If (cdsItens2.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'O código da opção escolhida deve ser preenchido !', ['&Ok']);
          Result := False;
        End
        Else
        begin
          pSetFocus(dbgItens2);
          blnMudarFoco := False;
        End;

      End;

    End

    {*****************************************}
    {* VALIDA DESCONTO GENÉRICO              *}
    {**************************************RL*}
    Else If (Sender = edtVlrDesGen) Then
    Begin

      If fEmptyStr(edtVlrDesGen.Text) Then
      Begin

        fMensagem('ATENÇÃO!', 'O valor do desconto deve ser preenchido !', ['&Ok']);
        Result := False;

      End
      Else If fStrToFloat(edtVlrDesGen.Text) <= 0 Then
      Begin

        fMensagem('ATENÇÃO!', 'O valor do desconto deve ser maior que zero !', ['&Ok']);
        Result := False;

      End;

    End;

  End;

  If Not (Result) Then
    pSetFocus(Sender);

end;

{*******************************************}
{* CONSULTA BÔNUS                          *}
{****************************************RL*}
procedure TfrmCadBonusVendas.edtCodBmgKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryTmp : TUniQuery;
    arrSel : TConsultasArray;

begin
  inherited;
  qryTmp := fCriaQuery;

  If fPesqBonusVen(Self, edtCodBmg, qryTmp , Key, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryTmp);

end;

{*******************************************}
{* CARREGA BÔNUS                           *}
{****************************************RL*}
procedure TfrmCadBonusVendas.edtCodBmgExit(Sender: TObject);
  Var
    i: Integer;
begin
  inherited;

  strProdExcluidos := '';
  strGenExcluidos  := '';

  If Not fEmptyStr(edtCodBmg.Text) Then
  Begin

    objBonGer.pCarregaBonGer(edtCodBmg.Text);

    If fEmptyStr(objBonGer.strCodBmg) Then
    Begin
      fMensagem('ATENÇÃO!', 'Bônus não cadastrado!', ['&Ok']);
      pSetFocus(edtCodBmg);
      Exit;
    End;

    {*******************************************}
    {* SE BÔNUS FINALIZADO, PERMITE AO USUÁRIO *}
    {* APENAS CONSULTAR OS DADOS               *}
    {****************************************RL*}
    If StrToDate(objBonGer.strDtaFin) < VS_Date Then
    begin

      fMensagem('ATENÇÃO!', 'Este bônus está finalizado!', ['&Ok']);

      For i := 0 To Self.ComponentCount - 1 Do
        If Components[i] is TPanel Then
        Begin
          TPanel(Components[i]).Enabled := False;

          If TPanel(Components[i]).Name = 'pnlDadosAdicionais' Then
            TPanel(Components[i]).Visible := True;
        End;

      If pgcDados.ActivePage = tbsProdutos Then
        pSetFocus(dbgItens);

      If pgcDados.ActivePage = tbsGenerica Then
        pSetFocus(dbgItens2);

    End
    Else
    Begin

      edtCodBmg.Enabled := False;

      If pgcDados.ActivePage = tbsProdutos Then
        pSetFocus(edtCodIte)
      Else
        pSetFocus(edtCodOpc);

    End;

    pLimpaDataSet(cdsItens);
    pLimpaDataSet(cdsItens2);

    {*******************************************}
    {* CARREGA BONGER                          *}
    {****************************************RL*}
    edtDesBmg.Text := objBonGer.strDesBmg;
    edtCodRed.Text := objBonGer.strCodRed;
    edtDesRed.Text := objBonGer.strDesRed;
    edtCodCli.Text := objBonGer.strCodCli;
    edtDesCli.Text := objBonGer.strDesCli;
    edtObs1.Text   := objBonGer.strObs_01;
    edtObs2.Text   := objBonGer.strObs_02;
    edtObs3.Text   := objBonGer.strObs_03;
    mskDtaIni.Text := objBonGer.strDtaIni;
    mskDtaFin.Text := objBonGer.strDtaFin;

    {*******************************************}
    {* CARREGA BONDET                          *}
    {****************************************RL*}
    With objBonGer.objBonDet.qryBonDet Do
    Begin

      While Not Eof Do
      Begin
        cdsItens.Insert;
        cdsItens.FieldByName('CODITE').AsString := FieldByName('BMD_CODITE').AsString;
        cdsItens.FieldByName('DESITE').AsString := fRetNomProduto(FieldByName('BMD_CODITE').AsString);
        cdsItens.FieldByName('ITESIM').AsString := objBonGer.objBonDet.fRetornaSimilaridade(FieldByName('BMD_CODITE').AsString);
        cdsItens.FieldByName('VLRDES').AsFloat  := FieldByName('BMD_VLRDES').AsFloat;
        cdsItens.FieldByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
        cdsItens.Post;

        Next;
      End;

      cdsItens.First;

    End;

    {*******************************************}
    {* CARREGA BONGEN                          *}
    {****************************************RL*}
    With objBonGer.objBonGen.qryBonGen Do
    Begin

      While Not Eof Do
      Begin
        cdsItens2.Insert;
        cdsItens2.FieldByName('OPCAO').AsString  := FieldByName('GEN_OPCAO_').AsString;

        If FieldByName('GEN_OPCAO_').AsString = '1' Then
        Begin

          cdsItens2.FieldByName('CODOPC').AsString := FieldByName('GEN_CODGRU').AsString;
          cdsItens2.FieldByName('DESOPC').AsString := fRetNomeLinhaGrupo(FieldByName('GEN_CODGRU').AsString);
          rdgOpcao.ItemIndex := 0;

        End
        Else If FieldByName('GEN_OPCAO_').AsString = '2' Then
        Begin

          cdsItens2.FieldByName('CODOPC').AsString := FieldByName('GEN_CODFOR').AsString;
          cdsItens2.FieldByName('DESOPC').AsString := fRetNomFornecedor(FieldByName('GEN_CODFOR').AsString);
          rdgOpcao.ItemIndex := 1;

        End
        Else
        Begin

          cdsItens2.FieldByName('CODOPC').AsString := FieldByName('GEN_CODMAR').AsString;
          cdsItens2.FieldByName('DESOPC').AsString := fRetNomMarca(FieldByName('GEN_CODMAR').AsString);
          rdgOpcao.ItemIndex := 2;

        End;

        cdsItens2.FieldByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
        cdsItens2.FieldByName('VLRDES').AsFloat  := FieldByName('GEN_VLRDES').AsFloat;
        cdsItens2.Post;

        Next;
      End;

      cdsItens2.First;

      If Not cdsItens2.IsEmpty Then
        rdgOpcao.Enabled := False;

    End;

  End
  Else
    edtCodBmg.Enabled := False;

  If Not fEmptyStr(edtCodBmg.Text) Then
    btnExcluir.Enabled := True
  Else
    btnExcluir.Enabled := False;

  If (cdsItens.RecordCount = 0) And (cdsItens2.RecordCount > 0) Then
    pgcDados.ActivePage := tbsGenerica
  Else If (Not fEmptyStr(edtCodBmg.Text)) Then
    pgcDados.ActivePage := tbsProdutos;

end;

{*******************************************}
{* CONSULTA REDE DE LOJA                   *}
{****************************************RL*}
procedure TfrmCadBonusVendas.edtCodRedKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrRede: TConsultasArray;

begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadBonusVendas.edtCodRedExit(Sender: TObject);
  Var
    objRedeLojas: TRedeLojas;
begin
  inherited;

  If intOnExit = 1 Then
  Begin
    intOnExit := 0;
    Exit;
  End;

  objRedeLojas := Nil;

  If Not fEmptyStr(edtCodRed.Text) Then
  Begin

    objRedeLojas := TRedeLojas.Create(Self);

    If objRedeLojas.fCarregaCadRed(edtCodRed.Text) Then
    Begin

      edtDesRed.Text := objRedeLojas.strDesRed;
      edtCodCli.Clear;
      edtDesCli.Clear;

    End
    Else
    Begin

      edtCodRed.Clear;
      edtDesRed.Clear;
      fMensagem('', 'Rede de Loja não encontrada !', ['&Ok']);
      pSetFocus(edtCodRed);

    End;

  End;

  If Assigned(objRedeLojas) Then
    FreeAndNil(objRedeLojas);

end;

{*******************************************}
{* CONSULTA CLIENTE                        *}
{****************************************RL*}
procedure TfrmCadBonusVendas.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryTmp : TUniQuery;
    arrSel : TConsultasArray;

begin

  inherited;

  If fEntraCons(Key) Then
  Begin
    qryTmp := fCriaQuery;

    if fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, qryTmp, Key, arrSel) then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;
    FreeAndNil(qryTmp);
  End;

end;

procedure TfrmCadBonusVendas.edtCodCliExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin

    edtDesCli.Text := fRetNomCliente(edtCodCli.Text);

    If fEmptyStr(edtDesCli.Text) Then
    Begin
      fMensagem('', 'Cliente não encontrado !', ['&Ok']);
      pSetFocus(edtCodCli);
    End

  End
  Else
    edtDesCli.Clear;

end;

procedure TfrmCadBonusVendas.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryTmp : TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    qryTmp := fCriaQuery;

    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryTmp, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(qryTmp);
  End;
end;

procedure TfrmCadBonusVendas.edtCodIteExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodIte.Text) Then
  Begin

    If (fCfgSis('SIMCAM', varBoolean)) And (cdsItens.State = dsBrowse) Then
      If objBonGer.objBonDet.fConsisteSimilaridade(edtCodIte.Text, cdsItens) Then
        pSetFocus(edtCodIte);

    pRetDadosItem(edtCodIte.Text,
                  strNomPro,
                  strRefere,
                  strMarca,
                  strUnidad);

    edtDesIte.Text     := strNomPro;
    edtReferencia.Text := strRefere;
    edtDesUni.Text     := fRetNomUnidade(strUnidad);

    If fEmptyStr(strNomPro) Then
    Begin
      pLimpaEdits(False, True);
      fMensagem('', 'Produto não encontrado !', ['&Ok']);
      pSetFocus(edtCodIte);
    End;

  End
  Else
    pLimpaEdits(False, True);

end;

procedure TfrmCadBonusVendas.FormCreate(Sender: TObject);
begin
  inherited;

  intOnExit := 0;

  {********************************************}
  {* ABRE E CRIA ESTRUTURA DOS CLIENTDATASETS *}
  {*****************************************RL*}

  pSetaCodIte(cdsItensCODITE);

  cdsItens.CreateDataSet;
  cdsItens2.CreateDataSet;

  objBonGer := TBonGer.Create(Self);

  intrdgInd := rdgOpcao.ItemIndex;

end;

{*******************************************}
{* LIMPA CONTEÚDO DOS EDITS                *}
{****************************************RL*}
procedure TfrmCadBonusVendas.pLimpaEdits(blnBonus: Boolean = False; blnProdutos: Boolean = False;
 blnDadosAdicionais: Boolean = False; blnGenerica: Boolean = False);
Begin

  If blnBonus Then
  Begin
    edtCodBmg.Clear;
    edtDesBmg.Clear;
    edtCodRed.Clear;
    edtDesRed.Clear;
    edtCodCli.Clear;
    edtDesCli.Clear;
  End;

  If blnProdutos Then
  Begin
    edtCodIte.Clear;
    edtDesIte.Clear;
    edtReferencia.Clear;
    edtDesUni.Clear;
    edtVlrDesIte.Clear;
    edtVlrDesIte.Text := '0,00';
  End;

  If blnDadosAdicionais Then
  Begin
    mskDtaIni.Clear;
    mskDtaFin.Clear;
    edtObs1.Clear;
    edtObs2.Clear;
    edtObs3.Clear;
  End;

  If blnGenerica Then
  Begin
    edtCodOpc.Clear;
    edtDesOpc.Clear;
    edtVlrDesGen.Clear;
    edtVlrDesGen.Text := '0,00';
  End;

End;

{*******************************************}
{* ADICIONAR PRODUTO                       *}
{****************************************RL*}
procedure TfrmCadBonusVendas.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If Not fValidaPanel(pnlProdutos) Then
    Exit;

  if fEmptyStr(edtCodIte.Text) Then
    Exit;

  With cdsItens Do
  Begin

    If Locate('CODITE', edtCodIte.Text, []) Then
      Edit
    Else
    Begin
      Insert;
      FieldByName('AUTINC').AsString := '';
    End;

    FieldByName('CODITE').AsString := edtCodIte.Text;
    FieldByName('DESITE').AsString := edtDesIte.Text;
    FieldByName('ITESIM').AsString := objBonGer.objBonDet.fRetornaSimilaridade(edtCodIte.Text);
    FieldByName('VLRDES').AsFloat  := fStrToFloat(edtVlrDesIte.Text);
    Post;

  End;

  pLimpaEdits(False, True);
  pSetFocus(edtCodIte);

end;

procedure TfrmCadBonusVendas.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin

    btnCancelaItem.Click

  End
  Else If (Key = VK_Return) And (pnlProdutos.Enabled) Then
  Begin

    pCarregaItensAlteracao

  End
  Else If (Key = VK_Delete) And (pnlProdutos.Enabled) Then
  Begin

    If (Not cdsItens.FieldByName('CODITE').IsNull) Then
    Try

      strProdExcluidos := strProdExcluidos + QuotedStr(cdsItens.FieldByName('CODITE').AsString) + ',';

      cdsItens.Delete;
      pSetFocus(dbgItens);

      If cdsItens.IsEmpty Then
        pSetFocus(edtCodIte);

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmCadBonusVendas.dbgItensKeyDown]');

    End
    Else
      pSetFocus(edtCodIte);

  End;

end;

procedure TfrmCadBonusVendas.btnCancelaItemClick(Sender: TObject);
begin
  inherited;

  If Not pnlBonus.Enabled Then
  Begin
    pCancelarDados;
    Exit;
  End;

  If (ActiveControl.Parent = pnlProdutos) And (fEmptyStr(edtCodIte.Text)) Then
    pCancelarDados
  Else
  Begin

    cdsItens.Cancel;
    pLimpaEdits(False, True);
    pSetFocus(edtCodIte);

  End;

end;

{*******************************************}
{* CARREGA ITEM SELECIONADO PARA ALTERAÇÃO *}
{****************************************RL*}
procedure TfrmCadBonusVendas.pCarregaItensAlteracao;
begin

  edtCodIte.Text := cdsItens.FieldByName('CODITE').AsString;

  pRetDadosItem(edtCodIte.Text,
                strNomPro,
                strRefere,
                strMarca,
                strUnidad);

  edtDesIte.Text     := strNomPro;
  edtReferencia.Text := strRefere;
  edtDesUni.Text     := fRetNomUnidade(strUnidad);
  edtVlrDesIte.Text  := FloatToStrF(cdsItens.FieldByName('VLRDES').AsFloat, ffFixed, 12, 2);

  cdsItens.Edit;
  pSetFocus(edtCodIte);

end;

{*******************************************}
{* CARREGA ITEM SELECIONADO PARA ALTERAÇÃO *}
{****************************************RL*}
procedure TfrmCadBonusVendas.pCarregaItensAlteracao2;
begin

  If cdsItens2.FieldByName('OPCAO').AsString = '1' Then
    rdgOpcao.ItemIndex := 0
  Else If cdsItens2.FieldByName('OPCAO').AsString = '2' Then
    rdgOpcao.ItemIndex := 1
  Else If cdsItens2.FieldByName('OPCAO').AsString = '3' Then
    rdgOpcao.ItemIndex := 2;

  edtCodOpc.Text    := cdsItens2.FieldByName('CODOPC').AsString;
  edtDesOpc.Text    := cdsItens2.FieldByName('DESOPC').AsString;
  edtVlrDesGen.Text := FloatToStrF(cdsItens2.FieldByName('VLRDES').AsFloat, ffFixed, 12, 2);

  cdsItens2.Edit;
  pSetFocus(edtCodOpc);

end;

procedure TfrmCadBonusVendas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
  Begin

    Key := 0;
    btnConfirmar.Click;

  End
  Else If (Key = VK_F11) And (btnExcluir.Enabled) Then
  begin

    btnExcluir.Click;

  End
  Else If (Shift = [SSAlt]) And (Key = Ord('P')) Then
  Begin

    pgcDados.ActivePage := tbsProdutos;

  End
  Else If (Shift = [SSAlt]) And (Key = Ord('G')) Then
  Begin

    pgcDados.ActivePage := tbsGenerica;

  End
  Else If (Key = VK_RETURN) Then
  Begin

    If(pgcDados.ActivePage = tbsGenerica) Then
      If (ActiveControl.Parent = rdgOpcao) Then
        SelectNext(ActiveControl, True, True);

  End
  Else If(pgcDados.ActivePage = tbsGenerica) And (Key = VK_ESCAPE) Then
    If (ActiveControl.Parent = rdgOpcao) Then
      pCancelarDados;

end;

procedure TfrmCadBonusVendas.FormShow(Sender: TObject);
begin
  inherited;
  pSetaCodIte( edtCodIte );
end;

procedure TfrmCadBonusVendas.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodBmg);
end;

procedure TfrmCadBonusVendas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  cdsItens.Close;
  cdsItens2.Close;

end;

{*******************************************}
{* CONSULTA OPÇÃO DO BÔNUS GENÉRICO        *}
{****************************************RL*}
procedure TfrmCadBonusVendas.edtCodOpcKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    If rdgOpcao.ItemIndex = 0 Then
    Begin
      If fPesqGrupo(Self, edtCodOpc, edtDesOpc, nil, Key, arrSel) Then
      Begin
        Self.SelectNext(ActiveControl, True, True);
      End;
    End
    Else If rdgOpcao.ItemIndex = 1 Then
    Begin
      {*********************************}
      {* NOVA CONSULTA DE FORNECEDORES *}
      {******************************RV*}
      If fPesqFornecedor(conForSimples, Self, edtCodOpc, edtDesOpc, Nil, Key, arrSel) Then
      Begin
        If fValidaCampos(edtCodOpc, True) Then
          SelectNext(ActiveControl, True, True);
      End;
    End
    Else
    Begin
      {***************************}
      {* NOVA CONSULTA DE MARCAS *}
      {************************DP*}
      If fPesqMarcas(Self, edtCodOpc, edtDesOpc, Nil, Key, arrSel) Then
      Begin
        Self.SelectNext(ActiveControl, True, True);
      End;
    End;

  End;

end;

procedure TfrmCadBonusVendas.edtCodOpcExit(Sender: TObject);
begin
  inherited;

  If rdgOpcao.ItemIndex = 0 Then
  Begin

    If Not fEmptyStr(edtCodOpc.Text) Then
    Begin
      edtDesOpc.Text := fRetNomeLinhaGrupo(edtCodOpc.Text);

      If fEmptyStr(edtDesOpc.Text) Then
      Begin

        fMensagem('ATENÇÃO!', 'Linha/Grupo não encontrada!', ['&Ok']) ;
        pSetFocus(edtCodOpc);
        edtCodOpc.Clear;
        edtDesOpc.Clear;
      End;
    End;

  End
  Else If rdgOpcao.ItemIndex = 1 Then
  Begin

    If Not fEmptyStr(edtCodOpc.Text) Then
    Begin
      edtDesOpc.Text := fRetNomFornecedor(edtCodOpc.Text);

      If fEmptyStr(edtDesOpc.Text) Then
      Begin

        fMensagem('ATENÇÃO!', 'Fornecedor não encontrado!', ['&Ok']) ;
        pSetFocus(edtCodOpc);
        edtCodOpc.Clear;
        edtDesOpc.Clear;
      End;
    End;

  End
  Else
  Begin

    If Not fEmptyStr(edtCodOpc.Text) Then
    Begin
      edtDesOpc.Text := fRetNomMarca(edtCodOpc.Text);

      If fEmptyStr(edtDesOpc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Marca não encontrada!', ['&Ok']) ;
        pSetFocus(edtCodOpc);
        edtCodOpc.Clear;
        edtDesOpc.Clear;
      End;
    End;

  End;

end;

procedure TfrmCadBonusVendas.btnAdicionar2Click(Sender: TObject);
  Var
    strOpcao: String;
begin
  inherited;

  If Not fValidaPanel(pnlGenerico) Then
    Exit;

  if fEmptyStr(edtCodOpc.Text) Then
    Exit;

  strOpcao := IIF(fEmptyStr(cdsItens2.FieldByName('OPCAO').AsString), '-1', cdsItens2.FieldByName('OPCAO').AsString);
  If ((rdgOpcao.ItemIndex + 1) <> StrToInt(strOpcao)) And (strOpcao <> '-1') Then
  Begin

    If strOpcao = '1' Then
      fMensagem('ATENÇÃO!', 'Só é permitido incluir a opção de Linha/Grupo na campanha!' + #13 +
                'Para inserir outra opção, apague os itens de Linha/Grupo adicionados!' , ['&Ok'])
    Else If strOpcao = '2' Then
      fMensagem('ATENÇÃO!', 'Só é permitido incluir a opção de Fornecedor na campanha!' + #13 +
                'Para inserir outra opção, apague os itens de Fornecedor adicionados!' , ['&Ok'])
    Else
      fMensagem('ATENÇÃO!', 'Só é permitido incluir a opção de Marca na campanha!' + #13 +
                'Para inserir outra opção, apague os itens de Marca adicionados!' , ['&Ok']);


    rdgOpcao.ItemIndex := intrdgInd;
    pSetFocus(edtCodOpc);
    Exit;

  End;

  With cdsItens2 Do
  Begin

    If Locate('CODOPC', edtCodOpc.Text, []) Then
      Edit
    Else
    Begin
      Insert;
      FieldByName('AUTINC').AsString  := '';
    End;

    FieldByName('OPCAO').AsString  := IntToStr(rdgOpcao.ItemIndex + 1);
    FieldByName('CODOPC').AsString := edtCodOpc.Text;
    FieldByName('DESOPC').AsString := edtDesOpc.Text;
    FieldByName('VLRDES').AsFloat  := fStrToFloat(edtVlrDesGen.Text);
    Post;

  End;

  pLimpaEdits(False, False, False, True);
  pSetFocus(edtCodOpc);

end;

procedure TfrmCadBonusVendas.btnCancelaItem2Click(Sender: TObject);
begin
  inherited;

  If Not pnlBonus.Enabled Then
  Begin
    pCancelarDados;
    Exit;
  End;

  If (ActiveControl.Parent = pnlGenerico) And (fEmptyStr(edtCodOpc.Text)) Then
    pCancelarDados
  Else
  Begin

    cdsItens2.Cancel;
    pLimpaEdits(False, False, False, True);
    pSetFocus(edtCodOpc);

  End;

end;

procedure TfrmCadBonusVendas.dbgItens2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin

    btnCancelaItem2.Click

  End
  Else If (Key = VK_Return) And (pnlGenerico.Enabled) Then
  Begin

    pCarregaItensAlteracao2

  End
  Else If (Key = VK_Delete) And (pnlGenerico.Enabled) Then
  Begin

    If Not cdsItens2.FieldByName('CODOPC').IsNull Then
    Try

      strGenExcluidos := strGenExcluidos + QuotedStr(cdsItens2.FieldByName('CODOPC').AsString) + ',';

      cdsItens2.Delete;

      If cdsItens2.IsEmpty Then
        pSetFocus(edtCodOpc);

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmCadBonusVendas.dbgItens2KeyDown]');
    End
    Else
      pSetFocus(edtCodOpc);

  End;

end;

procedure TfrmCadBonusVendas.rdgOpcaoClick(Sender: TObject);
begin
  inherited;

  If rdgOpcao.ItemIndex = 0 Then
  Begin

    lblOpcao.Caption    := 'Linha/Grupo:';
    edtCodOpc.MaxLength := 4;
    edtCodOpc.TamCampo  := 4;
    edtCodOpc.CompZeros := False;

  End
  Else If rdgOpcao.ItemIndex = 1 Then
  Begin

    lblOpcao.Caption    := 'Fornecedor:';
    edtCodOpc.MaxLength := 8;
    edtCodOpc.TamCampo  := 8;
    edtCodOpc.CompZeros := True;

  End
  Else
  Begin

    lblOpcao.Caption    := 'Marca:';
    edtCodOpc.MaxLength := 3;
    edtCodOpc.TamCampo  := 3;
    edtCodOpc.CompZeros := True;

  End;

  intrdgInd := rdgOpcao.ItemIndex;

end;

procedure TfrmCadBonusVendas.pgcDadosChange(Sender: TObject);
begin
  inherited;

  If (fCfgSis('SIMCAM', varBoolean)) And (pgcDados.ActivePage = tbsGenerica) Then
  Begin
    fMensagem('', 'O sistema não está configurado para trabalhar com campanha genérica!', ['&Ok']);
    pgcDados.ActivePage := tbsProdutos;
    Exit;
  End;

  If pgcDados.ActivePage = tbsGenerica Then
    rdgOpcao.ItemIndex := intrdgInd
  Else
    If (pgcDados.ActivePage = tbsProdutos) And (pnlProdutos.Enabled) Then
      pSetFocus(edtCodIte)
    Else
      pSetFocus(dbgItens);

  If fEmptyStr(edtDesBmg.Text) And (pnlBonus.Enabled) Then
  Begin
    edtCodBmg.Enabled := True;
    pSetFocus(edtCodBmg);
  End;

end;

procedure TfrmCadBonusVendas.pEscapePressed;
begin

  intOnExit := 1;

  If (ActiveControl.Parent = pnlProdutos) Then
  Begin

    btnCancelaItem.Click

  End
  Else If ActiveControl.Parent = pnlGenerico Then
  Begin

    btnCancelaItem2.Click

  End
  Else If ActiveControl.Parent = pnlDadosAdicionais Then
  Begin

    pnlDadosAdicionais.Visible := False;
    btnConfirmar.Caption       := '[ F10 ] Confirmar';

    If pgcDados.ActivePage = tbsProdutos Then
      pSetFocus(edtCodIte)
    Else
      pSetFocus(edtCodOpc)

  End
  Else If (ActiveControl.Parent = pnlBonus) And (Not edtCodBmg.Focused) Then
  Begin

    pCancelarDados

  End
  Else
    inherited;

end;

{*******************************************}
{* CONFIRMA CADASTRO DO BÕNUS              *}
{****************************************RL*}
procedure TfrmCadBonusVendas.btnConfirmarClick(Sender: TObject);
  Var
    strAutIncGer: String;
    strOpcao_   : String;
    blnGravar   : Boolean;
begin
  inherited;

  blnGravar := False;

  If (cdsItens.IsEmpty) And (cdsItens2.IsEmpty) And (fEmptyStr(strProdExcluidos) And fEmptyStr(strGenExcluidos)) Then
    Exit;

  If (fEmptyStr(objBonGer.strCodBmg)) And (cdsItens.IsEmpty And cdsItens2.IsEmpty) Then
    Exit;

  If Not pnlDadosAdicionais.Visible Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      mskDtaIni.Text := DateToStr(VS_Date);

    If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      mskDtaFin.Text := DateToStr(VS_Date);

    pnlDadosAdicionais.Visible := True;
    btnConfirmar.Caption       := '[ F10 ] Finalizar';
    pSetFocus(mskDtaIni);

    Exit;
  End;

  Try

    If Not fValidaPanel(pnlBonus, True) Then
      exit;

    If Not fValidaPanel(pnlDadosAdicionais, True) Then
      exit;

    fStartTransaction;

  {********************************************************}
  {* EXLCUIR ITENS DE BÔNUS DE PRODUTOS OU BÔNUS GENÉRICO *}
  {*****************************************************RL*}
  If Not fEmptyStr(strProdExcluidos) Then
  Begin
    strProdExcluidos := Copy(strProdExcluidos, 1, Length(strProdExcluidos) - 1);

    objBonGer.objBonDet.fDeletaBonDet(objBonGer.strCodBmg, strProdExcluidos);
  End;

  If Not fEmptyStr(strGenExcluidos) Then
  Begin
    strGenExcluidos := Copy(strGenExcluidos, 1, Length(strGenExcluidos) - 1);

    objBonGer.objBonGen.fDeletaBonGen(objBonGer.strCodBmg, objBonGer.objBonGen.strOpcao_, strGenExcluidos);
  End;

    {*******************************************}
    {* GRAVA BÔNUS                             *}
    {****************************************RL*}
    If objBonGer.fGravaBonGer(strAutIncGer,
                              edtCodBmg.Text,
                              edtDesBmg.Text,
                              edtCodRed.Text,
                              edtCodCli.Text,
                              edtObs1.Text,
                              edtObs2.Text,
                              edtObs3.Text,
                              VS_strCodEmp,
                              StrToDate(mskDtaIni.Text),
                              StrToDate(mskDtaFin.Text)
                             ) Then


    Begin

      {*******************************************}
      {* GRAVA PRODUTOS DO BÔNUS                 *}
      {****************************************RL*}
      cdsItens.First;

      While Not cdsItens.Eof Do
      Begin

        If objBonGer.objBonDet.fGravaBonDet(cdsItens.FieldByName('AUTINC').AsString,
                                            objBonGer.strCodBmg,
                                            cdsItens.FieldByName('CODITE').AsString,
                                            cdsItens.FieldByName('VLRDES').AsFloat,
                                            VS_strCodEmp
                                           ) Then
          blnGravar := True;

        cdsItens.Next;

      End;

      {*******************************************}
      {* GRAVA BÔNUS GENÉRICO                    *}
      {****************************************RL*}
      cdsItens2.First;

      If (Not fCfgSis('SIMCAM', varBoolean)) And (Not cdsItens2.IsEmpty) Then
      Begin
        cdsItens2.First;

        blnGravar := False;

        While Not cdsItens2.Eof Do
        Begin

          If rdgOpcao.ItemIndex = 0 Then
            strOpcao_ := '1'
          Else If rdgOpcao.ItemIndex = 1 Then
            strOpcao_ := '2'
          Else
            strOpcao_ := '3';

          If objBonGer.objBonGen.fGravaBonGen(cdsItens2.FieldByName('AUTINC').AsString,
                                              objBonGer.strCodBmg,
                                              strOpcao_,
                                              IIF(strOpcao_ = '1', cdsItens2.FieldByName('CODOPC').AsString, ''),
                                              IIF(strOpcao_ = '2', cdsItens2.FieldByName('CODOPC').AsString, ''),
                                              IIF(strOpcao_ = '3', cdsItens2.FieldByName('CODOPC').AsString, ''),
                                              cdsItens2.FieldByName('VLRDES').AsFloat,
                                              VS_strCodEmp
                                             ) Then
            blnGravar := True;

          cdsItens2.Next;

        End;

      End;

    End;

     If blnGravar Then
       fCommit
     Else
       fRollBack;

     pnlDadosAdicionais.Visible := False;
     btnConfirmar.Caption       := '[ F10 ] Confirmar';
     pLimpaDataSet(cdsItens);
     pLimpaDataSet(cdsItens2);
     pLimpaEdits(True, True, True, True);
     rdgOpcao.Enabled := True;

     strProdExcluidos := '';
     strGenExcluidos  := '';

     If Not edtCodBmg.Enabled Then
       edtCodBmg.Enabled := True;

     pSetFocus(edtCodBmg);

  Except
    On E: Exception Do
    Begin

      pMensagensErro(E.Message, '[TfrmCadBonusVendas.btnConfirmarClick]');

      fRollBack;

      pnlDadosAdicionais.Visible := False;
      btnConfirmar.Caption       := '[ F10 ] Confirmar';
      pLimpaDataSet(cdsItens);
      pLimpaDataSet(cdsItens2);
      pLimpaEdits(True, True, True, True);
      rdgOpcao.Enabled := True;

      strProdExcluidos := '';
      strGenExcluidos  := '';

      If Not edtCodBmg.Enabled Then
       edtCodBmg.Enabled := True;

      pSetFocus(edtCodBmg);

    End;

  End;

end;

{*******************************************}
{* CANCELA DADOS                           *}
{****************************************RL*}
procedure TfrmCadBonusVendas.pCancelarDados;
  Var
    i: Integer;
begin

  cdsItens.Cancel;
  cdsItens.EmptyDataSet;
  cdsItens2.Cancel;
  cdsItens2.EmptyDataSet;

  strProdExcluidos := '';
  strGenExcluidos  := '';

  pLimpaEdits(True, True, True, True);

  If Not (pnlBonus.Enabled) Then
  Begin

    For i := 0 To Self.ComponentCount - 1 Do
      If Components[i] is TPanel Then
      Begin
        TPanel(Components[i]).Enabled := True;

        If TPanel(Components[i]).Name = 'pnlDadosAdicionais' Then
          TPanel(Components[i]).Visible := False;
      End;

  End;

  rdgOpcao.Enabled := True;

  If Not edtCodBmg.Enabled Then
    edtCodBmg.Enabled := True;

  pSetFocus(edtCodBmg);

  If (edtCodBmg.Enabled) Then
    btnExcluir.Enabled := False
  Else
    btnExcluir.Enabled := True;

end;

{*******************************************}
{* EXCLUI BÔNUS                            *}
{****************************************RL*}
procedure TfrmCadBonusVendas.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If fMensagem('', 'Deseja excluir bônus?', ['&Sim', '&Não']) = 2 Then
    Exit;

  {*******************************************}
  {* EXCLUIR                                 *}
  {****************************************RL*}
  objBonGer.pDeletaBonus(edtCodBmg.Text);

  pCancelarDados;

  If pnlDadosAdicionais.Visible Then
  Begin
    pnlDadosAdicionais.Visible := False;
    btnConfirmar.Caption       := '[ F10 ] Confirmar';
  End;

end;

procedure TfrmCadBonusVendas.cdsItensAfterOpen(DataSet: TDataSet);
begin
  inherited;
end;

{*******************************************}
{* TOTALIZA RODAPÉ                         *}
{****************************************RL*}
procedure TfrmCadBonusVendas.dtsItensDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  lblTotDesIte.Caption := FloatToStrF(fStrToFloat(TAggregateField(cdsItens.FieldByName('AGG_TOTDES')).AsString), ffFixed, 12, 2);

end;

{*******************************************}
{* TOTALIZA RODAPÉ                         *}
{****************************************RL*}
procedure TfrmCadBonusVendas.dtsItens2DataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  lblTotDesGen.Caption := FloatToStrF(fStrToFloat(TAggregateField(cdsItens2.FieldByName('AGG_TOTDES')).AsString), ffFixed, 12, 2);

  If cdsItens2.IsEmpty Then
    rdgOpcao.Enabled := True
  Else
    rdgOpcao.Enabled := False;

end;

{*******************************************}
{* LIMPA DATASET                           *}
{****************************************RL*}
procedure TfrmCadBonusVendas.pLimpaDataSet(DataSet: TUniClientDataSet);
begin

  DataSet.EmptyDataSet;
  DataSet.Close;
  DataSet.Open;

end;

end.


