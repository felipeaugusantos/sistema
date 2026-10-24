{***********************}
{* qryConIte -> CADITE *}
{********************JB*}

unit untOrdProAddItemFase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Grids,
  DBGridCitel, DBGrids, Uni, Mask, DB, AppEvnts, untOrdPro, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, QColorLabel, System.UITypes, System.Math,
  unTOrdProMonitoramento;

type
  TRetornoSaldo = (rsOk, rsErroLote, rsErroSaldo);
  TfrmOrdProAddItemFase = class(TfrmPai)
    pnlCentral: TPanel;
    dbgDados: TDBGridCitel;
    pnlSubProdutos: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    edtDesSubProduto: TEditFocus;
    edtSubProduto: TEditFocus;
    edtSubReferencia: TEditFocus;
    edtSubUnidade: TEditFocus;
    edtSubQtdIte: TEditFocus;
    pnlProdutos: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    edtDesProduto: TEditFocus;
    edtProdutos: TEditFocus;
    edtReferencia: TEditFocus;
    edtUnidade: TEditFocus;
    Label7: TLabel;
    btnConfirma: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    lblNumLot: TColorLabel;
    edtNumLot: TEditFocus;
    lblMetrag: TLabel;
    edtMetrag: TEditFocus;
    lblCodFabrica: TLabel;
    edtCodFab: TEditFocus;
    btnRelSaldoInsuficiente: TBitBtnLocked;
    pnlTituloFase: TPanel;
    lblInfLot: TLabel;
    lblSaldoLote: TLabel;
    lnlItemInativo: TLabel;
    shpInfLot: TShape;
    shpItemInativo: TShape;
    shpSaldoLote: TShape;
    procedure FormShow(Sender: TObject);
    procedure edtSubProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRelSaldoInsuficienteClick(Sender: TObject);
  private
    { Private declarations }
    qryConIte: TUniQuery;
    FobjMonitor: TOrdProMonitoramento;
    FstrAutIncFase: String;

    strCodGru : String;
    oleDadosClient : OleVariant;
    blnVENMTL : Boolean;

    procedure pCarregaSubProduto(qryConsulta: TUniQuery);
    procedure pDeletaItem;
    procedure pGravaTemporaria(strCodGru, strCodIte, strDescri: String; fltQtdIte, fltMetrag: Double; strNumLot : String);
    procedure pLimparDados;
    function fVerificaItensInativos: Boolean;

    function fValidaSaldo(strCodIte : String; fltQtdIte: Double; strNumLot : String; fltSalDis : Real; blnMensagem : Boolean = False) : Boolean;
    function fSalvarProdutoFase: Boolean;
  protected
      function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
      procedure pEscapePressed; override;

  public
    { Public declarations }
    blnApenasValida : Boolean;
    blnConfirma : Boolean;
    objOrdPro: TOrdPro;
    fltQtdApr : Double;
    strCodPro : String;
    PossuiSaldo : Boolean;
    blnStateDataSetInsertEdit: Boolean;
    procedure pChecaQuantProdutoDisponivel;
  published
    property strAutIncFase: String read FStrAutIncFase write FStrAutIncFase;
    property objMonitor: TOrdProMonitoramento read FObjMonitor write FObjMonitor;
  end;

var
  frmOrdProAddItemFase: TfrmOrdProAddItemFase;

implementation

uses untfuncoesSimples, untPesqAux, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmOrdProAddItemFase.FormShow(Sender: TObject);
var
  enuResultLot : TRetornoSaldo;
begin
  inherited;
  blnVENMTL := fCfgSis('VENMTL', varBoolean);
  qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  dbgDados.DataSource := objOrdPro.dtsIteFas;
  oleDadosClient := objOrdPro.cdsIteFas.Data;

  edtSubQtdIte.EditFormat := fMskDigitos(4);
  (objOrdPro.dtsIteFas.DataSet.FieldByName('QTDITE') As TFloatField).DisplayFormat := edtSubQtdIte.EditFormat;
//  (objOrdPro.dtsIteFas.DataSet.FieldByName('QTDTOT') As TFloatField).DisplayFormat := edtSubQtdIte.EditFormat;
  (objOrdPro.dtsIteFas.DataSet.FieldByName('SALDOS') As TFloatField).DisplayFormat := edtSubQtdIte.EditFormat;

  If fCfgSis('SLD_OI') = 'N' Then
  begin
    shpSaldoLote.Visible := False;
    lblSaldolote.Visible := False;
  end;

  blnConfirma := False;

  pSetaCodIte( edtProdutos );
  pSetaCodIte( edtSubProduto );

  btnRelSaldoInsuficiente.Enabled:= False;

  pnlTituloFase.Caption := 'Fase: ' + fCampoTabela('FAS_DESFAS', 'FASGER', ['AUTOINCREM'], [FStrAutIncFase]);
end;

function TfrmOrdProAddItemFase.fVerificaItensInativos: Boolean;
begin
  Result := True;

  objOrdPro.cdsIteFas.DisableControls;
  Try
    objOrdPro.cdsIteFas.First;
    While Not objOrdPro.cdsIteFas.Eof Do
    Begin
      If (objOrdPro.cdsIteFas.FieldByName('ITEMATIVO').AsString = 'N') Then
      Begin
        Exit(False);
      End;
      objOrdPro.cdsIteFas.Next
    End;
  Finally
    objOrdPro.cdsIteFas.First;
    objOrdPro.cdsIteFas.EnableControls;
  End;
end;

procedure TfrmOrdProAddItemFase.edtNumLotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrNumLot : TConsultasArray;
begin
  inherited;
  If fPesqLoteItens(Self, edtNumLot, edtSubProduto, fCfgSis('DECUNI'), Nil, Key, arrNumLot) Then
  Begin
    If fValidaCampos(edtNumLot, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmOrdProAddItemFase.edtSubProdutoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    Try
      if fPesqItem(conIteSimples, Self, edtSubProduto, edtDesSubProduto, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
      Begin
        if fValidaCampos(edtSubProduto, True) then
          SelectNext(ActiveControl, True, True);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmOrdProItensEstrut.edtSubProdutoKeyPress]');
      End;
    End;
  End;

end;


function TfrmOrdProAddItemFase.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtSubProduto) Then
    Begin

      If (fEmptyStr(edtSubProduto.Text)) Then
      Begin
        If blnValidaIndividual Then
        Begin
          Result := False;
          fMensagem('', 'Digite o código do Sub-Produto!', ['&OK']);
        End;

        If (Not objOrdPro.cdsIteFas.IsEmpty) Then
        Begin
          pSetFocus(dbgDados);
          blnMudarFoco := False;
        End

      End
      Else If (edtSubProduto.Text = edtProdutos.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Sub. Produto não pode ser igual a Estrutura!',['&OK']);
        Result := False;
      End
      Else
      Begin

        If Not fEmptyStr(edtSubProduto.Text) Then
          pCarregaSubProduto(qryConIte);

        If (blnValidaIndividual) And (objOrdPro.cdsIteFas.Locate('ITESUB', edtSubProduto.Text, [])) Then
        Begin
          edtSubQtdIte.Text     := FloatToStrF(objOrdPro.cdsIteFas.FieldByName('QTDITE').AsFloat, ffFixed, 12, 4);
        End;

        If fEmptyStr(edtDesSubProduto.Text) And (Not fEmptyStr(edtSubProduto.Text))  Then
        Begin
          fMensagem('AVISO','Código do Produto não encontrado.', ['&O K']);
          Result := False;
        End;

      End;

      If Result Then
      Begin
        edtNumLot.Visible := fExisteLote(edtSubProduto.Text);
        lblNumLot.Visible := edtNumLot.Visible;
        If blnVENMTL Then
        Begin
          edtMetrag.Visible := fPossuiMetragem(edtSubProduto.Text);
          lblMetrag.Visible := edtMetrag.Visible;
          If Not edtMetrag.Visible Then
            edtMetrag.Text := '0';
        End

      End;

    End

    Else
    If (Sender = edtSubQtdIte) Then
    Begin

      If Not fEmptyStr(edtSubProduto.Text) Then
      Begin

        If fEmptyStr(edtSubQtdIte.Text) Then
        Begin
          fMensagem('ATENÇÃO','Digite a quantidade do produto!',['&O K']);
          Result := False;
        End
        Else
        If fStrToFloat(edtSubQtdIte.Text) <= 0.00 Then
        Begin
          fMensagem('ATENÇÃO','A quantidade do produto deve ser maior que Zero !',['&O K']);
          Result := False;
        End;

      End;

    End

    Else
    If (Sender = edtNumLot) And edtNumLot.Visible Then
    Begin

      if fExisteLote(edtSubProduto.Text) Then
      Begin
        If fEmptyStr(edtNumLot.Text) Then
        Begin
          Result := False;
          fMensagem('', 'O lote do produto deve ser preenchido!', ['&OK']);
        End
        Else if Not fExisteLote(edtNumLot.Text, edtSubProduto.Text, VS_strCodEmp) Then
        Begin
          Result := False;
          fMensagem('', 'O lote do produto informado não é válido!', ['&OK']);
        End;

      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;


procedure TfrmOrdProAddItemFase.pCarregaSubProduto(qryConsulta: TUniQuery);
begin

  pPesquisaCadIte(qryConsulta, qryConsulta, edtSubProduto.Text, '');
  With qryConsulta Do
  Begin
    strCodGru := qryConsulta.FieldByName('ITE_CODGRU').AsString;
//    strCusIte := fRetCustoItem(edtSubProduto.Text);
    edtDesSubProduto.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    edtSubReferencia.Text := qryConsulta.FieldByName('ITE_REFERE').AsString;
    edtSubUnidade.Text    := qryConsulta.FieldByName('ITE_CODUNI').AsString;
  End;

end;

procedure TfrmOrdProAddItemFase.pChecaQuantProdutoDisponivel;
var
  enuResultLot : TRetornoSaldo;
begin
  PossuiSaldo:= True;

  qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  dbgDados.DataSource := objOrdPro.dtsIteFas;
  oleDadosClient := objOrdPro.cdsIteFas.Data;

  edtSubQtdIte.EditFormat := fMskDigitos(4);
  (objOrdPro.dtsIteFas.DataSet.FieldByName('QTDITE') As TFloatField).DisplayFormat := edtSubQtdIte.EditFormat;
  (objOrdPro.dtsIteFas.DataSet.FieldByName('QTDTOT') As TFloatField).DisplayFormat := edtSubQtdIte.EditFormat;
  (objOrdPro.dtsIteFas.DataSet.FieldByName('SALDOS') As TFloatField).DisplayFormat := edtSubQtdIte.EditFormat;

  If fCfgSis('SLD_OI') = 'N' Then
  begin
    shpSaldoLote.Visible := False;
    lblSaldolote.Visible := False;
  end;

  blnConfirma := False;
end;

procedure TfrmOrdProAddItemFase.pDeletaItem;
begin
  If Not objOrdPro.cdsIteFas.IsEmpty Then
    objOrdPro.cdsIteFas.Delete;
end;


procedure TfrmOrdProAddItemFase.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If Not pnlProdutos.Visible Then
    Exit;

  If Not fVerificaCampos Then
  Begin
    pSetFocus(edtSubProduto);
    Exit;
  End;

  If (fEmptyStr(edtSubProduto.Text)) Then
    Exit;

  pGravaTemporaria(strCodGru, edtSubProduto.Text, edtDesSubProduto.Text, fStrToFloat( edtSubQtdIte.Text ), fStrToFloat( edtMetrag.Text ), edtNumLot.Text);
//  pAtualizaTemporaria(1);
  pLimparDados;
  pSetFocus(edtSubProduto);
  btnConfirma.Enabled := True;
//  btnComentario.Enabled := True;
//  fVerificaLotes;

end;

procedure TfrmOrdProAddItemFase.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimparDados;
  pSetFocus(edtSubProduto);

end;

function TfrmOrdProAddItemFase.fValidaSaldo(strCodIte : String; fltQtdIte: Double; strNumLot : String; fltSalDis : Real; blnMensagem : Boolean = False) : Boolean;
var
  strMensagem : String;
Begin
  If fCfgSis('SLD_OI') = 'N' Then
  begin
    Result := True;
    Exit;
  end;

  if (objOrdPro.blnGopSub and fItemEstrutura(strCodIte)) then
  begin
    Result := True;
    Exit;
  end;

  Result := RoundTo((fltQtdIte * fltQtdApr ),-4) <= RoundTo(fltSalDis,-4);
  If Not Result And blnMensagem Then
  begin
    strMensagem := 'Saldo indisponível para o lote selecionado!' + #13 +
                   'A quantidade necessária para produzir as '+ FormatFloat('#,##0.00', fltQtdApr) + ' unidades é de: ' + FormatFloat('#,##0.00', fltQtdIte * fltQtdApr) + #13 +
                   'Quantidade disponível: ' + FormatFloat('#,##0.00', fltSalDis);

    if fCfgSis('SLD_OI') = 'T' then
      fMensagem('', strMensagem, ['&OK'])
    else
    begin
      Result := fMensagem('', strMensagem + #13 +  'Deseja continuar?', ['&Sim', '&Não']) = 1;
    end;
  end;
end;

procedure TfrmOrdProAddItemFase.pGravaTemporaria(strCodGru, strCodIte, strDescri: String; fltQtdIte, fltMetrag: Double; strNumLot : String);
  Var
    blnLocate : Boolean;
    strVarNumLot : String;
    fltSaldo  : real;
begin
  With objOrdPro.cdsIteFas Do
    blnLocate := Locate('ITESUB', edtSubProduto.Text, []);

  strVarNumLot := strNumLot;
  If fEmptyStr(strNumLot) Then
    strVarNumLot := fCampoTabela('LOT_NUMLOT', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_PRIPRO'], [strCodIte, VS_strCodEmp, 'S']);


  //recalcula o saldo disponível
  fltSaldo := fRetornaSaldoDisponivel(strCodIte, False, True, strVarNumLot);
  if blnLocate then fltSaldo := fltSaldo + objOrdPro.fRetornaSaldoReservadoOrdPro(strCodIte,strCodPro, strVarNumLot);

  // Se for a validação do lote tem que validar o estoque.
  If Not fValidaSaldo(strCodIte, fltQtdIte, strNumLot, fltSaldo, True) Then
    Exit;

  With objOrdPro.cdsIteFas Do
  If blnLocate Then
  Begin
    Edit;
    FieldByName('CODITE').AsString  := edtProdutos.Text;
    FieldByName('ITESUB').AsString  := strCodIte;
    FieldByName('QTDITE').AsFloat   := fltQtdIte;
    FieldByName('METRAG').AsFloat   := fltMetrag;
    //FieldByName('NUMLOT').AsString  := strVarNumLot;
    FieldByName('SALDOS').AsFloat   := fltSaldo;
    FieldByName('CODFAB').AsString  := fRetCodFabrica(strCodIte);
    Post;
  End
  Else
  Begin
    Insert;
    FieldByName('CODITE').AsString  := edtProdutos.Text;
    FieldByName('ITESUB').AsString  := strCodIte;
    FieldByName('UNIDAD').AsString  := edtUnidade.Text;
    FieldByName('QTDITE').AsFloat   := fltQtdIte;
    FieldByName('METRAG').AsFloat   := fltMetrag;
    //FieldByName('NUMLOT').AsString  := strVarNumLot;
    //FieldByName('LOTQTD').AsInteger := fCampoTabela('COUNT(*)', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP'], [strCodIte, VS_strCodEmp], False);
    //FieldByName('CONLOT').AsString  := fCampoTabela('ITE_CONLOT', 'CADITE', ['ITE_CODITE'], [strCodIte]);
    FieldByName('REFERE').AsString  := edtSubReferencia.Text;
    FieldByName('SALDOS').AsFloat   := fltSaldo;
    FieldByName('CODFAB').AsString  := fRetCodFabrica(strCodIte);

    If Not fEmptyStr(strCodIte) Then
      FieldByName('DESITE').AsString  := edtDesSubProduto.Text
    Else
      FieldByName('DESITE').AsString  := strDescri;

    Post;
  End;

end;


procedure TfrmOrdProAddItemFase.pLimparDados;
begin
  edtSubProduto.Clear;
  edtDesSubProduto.Clear;
  edtSubReferencia.Clear;
  edtSubUnidade.Clear;
  edtSubQtdIte.Clear;
  edtSubQtdIte.Text := '0,00';
  edtNumLot.Clear;
  btnRelSaldoInsuficiente.Enabled := False;
end;


procedure TfrmOrdProAddItemFase.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaItensInativos Then
  Begin
    pMensagemOk('Há item inativo, ajustar!');
    Exit;
  End;

  If fSalvarProdutoFase Then
    btnSair.Click;
end;

function TfrmOrdProAddItemFase.fSalvarProdutoFase: Boolean;
var
  qryIns: TUniQuery;
begin
  qryIns := fCriaQuery;
  Try
    Try
      qryIns.SQL.Clear;
      qryIns.SQL.Add('DELETE FROM DETPRO WHERE DOP_SEQFAS = :SEQFAS');
      qryIns.ParamByName('SEQFAS').AsString := FStrAutIncFase;
      qryIns.ExecSQL;

      qryIns.SQL.Clear;
      qryIns.SQL.Add('INSERT INTO DETPRO (AUTOINCREM, PRD_SEQFAS, PRD_CODITE, PRD_METRAG, PRD_QTDITE, PRD_CODEMP) ');
      qryIns.SQL.Add('            VALUES (:AUTINC, :SEQFAS, :CODITE, :METRAG, :QTDITE, :CODEMP)                   ');


      objOrdPro.cdsIteFas.First;
      While Not objOrdPro.cdsIteFas.Eof Do
      Begin
        qryIns.ParamByName('AUTINC').AsString := fRetAutoIncrem('FASPRD', VS_StrCodEmp);
        qryIns.ParamByName('SEQFAS').AsString := FStrAutIncFase;
        qryIns.ParamByName('CODITE').AsString := objOrdPro.cdsIteFas.FieldByName('CODITE').AsString;
        qryIns.ParamByName('METRAG').AsFloat  := objOrdPro.cdsIteFas.FieldByName('METRAG').AsFloat;
        qryIns.ParamByName('QTDITE').AsFloat  := objOrdPro.cdsIteFas.FieldByName('QTDITE').AsFloat;
        qryIns.ParamByName('CODEMP').AsString := VS_StrCodEmp;
        qryIns.ExecSQL;

        objOrdPro.cdsIteFas.Next;
      End;

      Result := True;

    Except On
      E:Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmOrdProAddItemFase.fSalvarProdutoFase]');
      End;
    End;

  Finally
    FreeAndNil(qryIns);
  End;
end;

procedure TfrmOrdProAddItemFase.btnRelSaldoInsuficienteClick(Sender: TObject);
begin
  inherited;
  If blnStateDataSetInsertEdit Then
  Begin
    objOrdPro.fValidaSaldoLotesSubItens(fltQtdApr, True, True);
  End
  Else
  Begin
    objOrdPro.strCodPro:= strCodPro;
    objOrdPro.fVerificaEstoqueLote(fltQtdApr, True);
  End;
end;

procedure TfrmOrdProAddItemFase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Not blnConfirma Then
    objOrdPro.cdsIteFas.Data := oleDadosClient;

  objOrdPro.cdsIteFas.Filter := '';
  objOrdPro.cdsIteFas.Filtered := True;

end;

procedure TfrmOrdProAddItemFase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_DELETE :
    begin
      If pnlProdutos.Visible Then
        pDeletaItem;
    end;

    VK_F10    :
    begin
      Key := 0;
      if btnConfirma.Enabled Then btnConfirma.Click;
    end;
  End;

end;

procedure TfrmOrdProAddItemFase.dbgDadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  With TDBGridCitel(Sender) Do
  Begin
    if (DataSource = Nil) Or (Not DataSource.DataSet.Active) Or (DataSource.DataSet.RecordCount <= 0) Then
      Exit;

    If DataSource.DataSet.FieldByName('ITEMATIVO').AsString = 'N' Then
    Begin
      Canvas.Brush.Color := shpItemInativo.Brush.Color;
    End
    Else If (DataSource.DataSet.FindField('CONLOT') <> Nil) And (DataSource.DataSet.FieldByName('CONLOT').AsString = 'S') Then
    Begin
      If (DataSource.DataSet.FindField('NUMLOT') <> Nil) And fEmptyStr(DataSource.DataSet.FieldByName('NUMLOT').AsString) Then
          Canvas.Brush.Color := shpInfLot.Brush.Color;
    End
    Else
    Begin
      If fUsaRotinaWMS or ((DataSource.DataSet.FindField('LOTQTD') <> Nil) and (DataSource.DataSet.FieldByName('LOTQTD').AsInteger > 0))  Then
      begin
          If (DataSource.DataSet.FindField('NUMLOT') <> Nil) Then
            If fEmptyStr(DataSource.DataSet.FieldByName('NUMLOT').AsString)  Then
              Canvas.Brush.Color := shpInfLot.Brush.Color;
      end;
    End;


    {If (Canvas.Brush.Color <> shpInfLot.Brush.Color) And (Canvas.Brush.Color <> shpItemInativo.Brush.Color) Then
    begin
      If (fCfgSis('SLD_OI') <> 'N') Then
      begin
        If Not fValidaSaldo(DataSource.DataSet.FieldByName('ITESUB').AsString, DataSource.DataSet.FieldByName('QTDITE').AsFloat, DataSource.DataSet.FieldByName('NUMLOT').AsString, DataSource.DataSet.FieldByName('SALDOS').AsFloat) Then
        Begin
          If not btnRelSaldoInsuficiente.Enabled Then
            btnRelSaldoInsuficiente.Enabled:= True;
          Canvas.Brush.Color := shpSaldoLote.Brush.Color;
        End;
      end;
    end; }

    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmOrdProAddItemFase.dbgDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If pnlProdutos.Visible Then
  begin
    If (Key = VK_Return) Then
    Begin

      If (objOrdPro.cdsIteFas.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 subproduto!', ['&Ok']);
      End
      Else
      Begin

        edtSubProduto.Text    := objOrdPro.cdsIteFas.FieldByName('ITESUB').AsString;
        edtDesSubProduto.Text := objOrdPro.cdsIteFas.FieldByName('DESITE').AsString;
        edtSubReferencia.Text := objOrdPro.cdsIteFas.FieldByName('REFERE').AsString;
        edtSubUnidade.Text    := objOrdPro.cdsIteFas.FieldByName('UNIDAD').AsString;
        edtMetrag.Text        := objOrdPro.cdsIteFas.FieldByName('METRAG').AsString;
        edtSubQtdIte.Text     := FloatToStrF(objOrdPro.cdsIteFas.FieldByName('QTDITE').AsFloat, ffFixed, 12, 4);
//        edtNumLot.Text        := objOrdPro.cdsIteFas.FieldByName('NUMLOT').AsString;
        pSetFocus(edtSubProduto);

      End;

    End
    Else If (Key = VK_ESCAPE) Then
    Begin
      edtSubProduto.Clear;
      edtDesSubProduto.Clear;
      edtSubReferencia.Clear;
      edtSubUnidade.Clear;
      edtSubQtdIte.Text := '0,00';
      edtNumLot.Clear;
      pSetFocus(edtSubProduto);
    End;
  end;



end;

procedure TfrmOrdProAddItemFase.pEscapePressed;
begin

  If (ActiveControl.Parent = pnlSubProdutos) Then
    inherited

end;

end.


