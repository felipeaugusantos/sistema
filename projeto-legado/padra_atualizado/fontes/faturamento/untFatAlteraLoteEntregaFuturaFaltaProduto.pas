unit untFatAlteraLoteEntregaFuturaFaltaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, strUtils, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls, Math,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, MaskEditFocus, untCadLote,
  Data.DB, MemDS, DBAccess, Uni, untTFatReprocessarSaldoItem, UniClientDataSet;

type
  TrecProduto = record
    strAutInc: String;
    strCodPro: String;
    strNomPro: String;
    strRefere: String;
    strCodUni: String;
    fltQtdPen: Double;
    strNumLot: String;
    strMotivo: String;
    dtaPrevis: TDate;
    strCodEmp: String;
  end;

type
  TfrmFatAlteraLoteEntregaFuturaFaltaProduto = class(TfrmPaiConfirma)
    pnlInformacao: TPanel;
    pnlAlteracao: TPanel;
    lblProduto: TLabel;
    lblQuantidade: TLabel;
    lblRefere: TLabel;
    lblReferencia: TLabel;
    lblCodPro: TLabel;
    lblNomPro: TLabel;
    lblUnidade: TLabel;
    lblQtdPen: TLabel;
    lblCodUni: TLabel;
    lblNumLot: TLabel;
    edtNumLot: TEditFocus;
    lblMotivo: TLabel;
    cbbMotivo: TComboBox;
    lblPrevisao: TLabel;
    mskDtaPre: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbbMotivoChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    objCadLot: TCadLot;
    FstrCodCli: String;
    FstrCodVen: String;
    FstrNumDoc: String;
    FstrEspDoc: String;
    FstrEmpDoc: String;
    function fPesquisaLote(Sender: TObject; Var Key: Char; arrNumLot: TStringArray = Nil): Boolean;
    function fAlteraTipoEntregaFuturaItem(AAutInc, ANumLot, AMotFut: String; ADtaFut: TDate): Boolean;
    function fRetornaMotivo(AIndexMotivo: Integer): String;
    function fGravarRequisicaoCompra: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    FProduto: TrecProduto;
    { Public declarations }
    property strCodCli: String read FstrCodCli write FstrCodCli;
    property strCodVen: String read FstrCodVen write FstrCodVen;
    property strNumDoc: String read FstrNumDoc write FstrNumDoc;
    property strEspDoc: String read FstrEspDoc write FstrEspDoc;
    property strEmpDoc: String read FstrEmpDoc write FstrEmpDoc;
  end;


implementation

uses
  untFuncoesSimples, untConsultas, untPanelCxCadLote, untPnlDadosCadLote, untFuncFat,
  untFatRequisicaoCompras, untFuncoesGenerica;

{$R *.dfm}

function TfrmFatAlteraLoteEntregaFuturaFaltaProduto.fGravarRequisicaoCompra: Boolean;
  Var
    cdsMovRcd : TUniClientDataSet;
    qryMovRcd : TUniQuery;
    strCodSeq : String;
begin
  qryMovRcd := fCriaQuery();
  Try
    qryMovRcd.SQL.Add('SELECT * FROM MOVRCD WHERE FALSE');
    qryMovRcd.Open;

    cdsMovRcd := fCriaClientDatset(qryMovRcd, True);
    Try
      cdsMovRcd.Insert;
      cdsMovRcd.FieldByName('RCD_CODITE').AsString := FProduto.strCodPro;
      cdsMovRcd.FieldByName('RCD_DESITE').AsString := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [FProduto.strCodPro]);
      cdsMovRcd.FieldByName('RCD_OBSERV').AsString := 'Requisição de compra gerada através da rotina de "Alteração do Motivo da Entrega Futura';
      cdsMovRcd.FieldByName('RCD_CODEMP').AsString := VS_strCodEmp;
      cdsMovRcd.FieldByName('RCD_QTDITE').AsFloat  := FProduto.fltQtdPen;
      cdsMovRcd.Post;

      Result := TfrmFatRequisicaoCompras.
                  fGravaRequisicaoCompra(strCodSeq, strCodCli, strCodVen,
                                         EmptyStr, cdsMovRcd, False);
    Finally
      FreeAndNil(cdsMovRcd);
    End;
  Finally
    FreeAndNil(qryMovRcd);
  End;
end;

procedure TfrmFatAlteraLoteEntregaFuturaFaltaProduto.btnConfirmaClick(
  Sender: TObject);
  Var
    strRequisicaoCompra : String;
    strPedidosReqCompra : String;
    blnGravarReqCompra : Boolean;
begin
  inherited;

  blnGravarReqCompra := False;
  if fVerificaCampos then
  begin
    If (fCfgSis('TRAAME', varBoolean)) And (fMotivoEntFutToIndex(FProduto.strMotivo) = 0) And (cbbMotivo.ItemIndex > 0) Then
    Begin
      strRequisicaoCompra := fRetornaRequisicaoCompra(FstrNumDoc,
                                                      FstrEspDoc,
                                                      FstrEmpDoc,
                                                      FProduto.strCodPro);
      If (Not fEmptyStr(strRequisicaoCompra)) Then
      Begin
        strPedidosReqCompra := fPedidosRequisicaoCompra(strRequisicaoCompra, VS_strCodEmp);
        If (Not fEmptyStr(strPedidosReqCompra)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este registro está vinculado à requisição de compra "'+strRequisicaoCompra+'", '+
                                'que foi vinculada ao(s) pedido(s) de compra: '+strPedidosReqCompra+'. '+
                                'Para alterar o motivo, é necessário retirar a requisição do(s) pedido(s) de compra!', ['&Ok']);
          Exit;
        End
        Else
        Begin
          If (fMensagem('ATENÇÃO!', 'Este registro está vinculado à requisição de compra "'+strRequisicaoCompra+'", '+
                                    'porém sem pedido de compra vinculado. Se alterar o motivo esta requisição será excluída. '+
                                    'Confirma a alteração?', ['&Sim', '&Não']) = 1) Then
          Begin
            pExcluiRequisicaoCompra(strRequisicaoCompra, VS_strCodEmp, Self.Name);
          End
          Else
            Exit;
        End;
      End;
    End;

    If (fCfgSis('QGRTMF', varBoolean)) And
       (fCfgSis('FALPRO', varBoolean) Or fCfgSis('FALVEN', varBoolean)) And
       (fMotivoEntFutToIndex(FProduto.strMotivo) > 0) And (cbbMotivo.ItemIndex = 0) Then
    Begin
      If (fMensagem('ATENÇÃO!', 'Se alterar o motivo será gerado uma requisição de compra. Confirma a alteração?', ['&Sim', '&Não']) = 1) Then
      Begin
        blnGravarReqCompra := True;
      End
      Else
        Exit;
    End;

    fStartTransaction;

    try
      if fAlteraTipoEntregaFuturaItem(FProduto.strAutInc, edtNumLot.Text, fRetornaMotivo(cbbMotivo.ItemIndex), StrToDateDef(mskDtaPre.Text, 0)) then
      begin
        ReprocessarItem(FProduto.strCodPro, VS_strCodEmp);

        If blnGravarReqCompra Then
        Begin
          If (Not fGravarRequisicaoCompra) Then
          Begin
            fRollBack;
            fMensagem('ATENÇÃO!', 'Erro ao gravar requisicao de compra!', ['&Ok']);
          End;
        End;

        if not edtNumLot.Visible then
        begin
          fCommit;
          fMensagem('ATENÇÃO!', 'Alteração efetuada com sucesso!', ['&Ok']);
          Exit;
        end;

        if objCadLot.fTrocarLote('MOVDET', FProduto.strAutInc, FProduto.strNumLot, edtNumLot.Text, FProduto.strCodPro, FProduto.fltQtdPen, FProduto.strCodEmp) then
        begin
          fCommit;
          fMensagem('ATENÇÃO!', 'Alteração efetuada com sucesso!', ['&Ok']);
          ModalResult := mrOk;
        end
        else
        begin
          fRollBack;
          fMensagem('ATENÇÃO!', 'Erro ao alterar o produto!', ['&Ok']);
        end;
      end
      else
      begin
        fRollBack;
        fMensagem('ATENÇÃO!', 'Erro ao alterar o produto!', ['&Ok']);
      end;
    except
      on E:Exception do
      begin
        fRollBack;
        pMensagensErro(E.Message, '');
      end;
    end;
  end;
end;

procedure TfrmFatAlteraLoteEntregaFuturaFaltaProduto.cbbMotivoChange(
  Sender: TObject);
begin
  inherited;

  case cbbMotivo.ItemIndex of
    0:begin
        mskDtaPre.Enabled := True;
        mskDtaPre.Text := DateToStr(FProduto.dtaPrevis);
      end;

    1:begin
        mskDtaPre.Enabled := False;
        mskDtaPre.Text := '31/12/9999';
      end;

    2:begin
        mskDtaPre.Enabled := True;
        mskDtaPre.Text := DateToStr(FProduto.dtaPrevis);
      end;
  end;
end;

procedure TfrmFatAlteraLoteEntregaFuturaFaltaProduto.edtNumLotKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesquisaLote(Sender, Key) Then
  Begin
    If fValidaCampos(edtNumLot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatAlteraLoteEntregaFuturaFaltaProduto.fAlteraTipoEntregaFuturaItem(
  AAutInc, ANumLot, AMotFut: String; ADtaFut: TDate): Boolean;
var
  LqryAltera: TUniQuery;
begin
  LqryAltera := fCriaQuery;

  try
    Result := False;

    LqryAltera.Close;
    LqryAltera.SQL.Clear;
    LqryAltera.SQL.Add('UPDATE MOVDET');
    LqryAltera.SQL.Add('SET DET_DTAFUT = :DTAFUT');
    LqryAltera.SQL.Add('  , DET_MOTFUT = :MOTFUT');

    if not fEmptyStr(ANumLot) then
      LqryAltera.SQL.Add('  , DET_NUMLOT = :NUMLOT');

    LqryAltera.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    if not fEmptyStr(ANumLot) then
      LqryAltera.ParamByName('NUMLOT').AsString := ANumLot;

    LqryAltera.ParamByName('MOTFUT').AsString := AMotFut;
    LqryAltera.ParamByName('AUTINC').AsString := AAutInc;
    LqryAltera.ParamByName('DTAFUT').AsDate := ADtaFut;
    LqryAltera.ExecSQL;

    Result := True;
  finally
    FreeAndNil(LqryAltera);
  end;
end;

procedure TfrmFatAlteraLoteEntregaFuturaFaltaProduto.FormCreate(
  Sender: TObject);
begin
  inherited;
  FillChar(FProduto, SizeOf(FProduto), #0);
  objCadLot := TCadLot.Create(Self);
end;

procedure TfrmFatAlteraLoteEntregaFuturaFaltaProduto.FormDestroy(
  Sender: TObject);
begin
  inherited;
  If Assigned(objCadLot) Then
    FreeAndNil(objCadLot);
end;

procedure TfrmFatAlteraLoteEntregaFuturaFaltaProduto.FormShow(Sender: TObject);
begin
  inherited;

  lblCodPro.Caption := FProduto.strCodPro;
  lblNomPro.Caption := FProduto.strNomPro;
  lblRefere.Caption := FProduto.strRefere;
  lblCodUni.Caption := FProduto.strCodUni;
  lblQtdPen.Caption := FormatFloat('#,##0.0000', FProduto.fltQtdPen);

  case AnsiIndexStr(FProduto.strMotivo, ['F','A','P']) of
    0:cbbMotivo.ItemIndex := 0;
    1:cbbMotivo.ItemIndex := 1;
    2:cbbMotivo.ItemIndex := 2;
  end;

  mskDtaPre.Text := DateToStr(FProduto.dtaPrevis);

  if fEmptyStr(FProduto.strNumLot) then
  begin
    lblNumLot.Visible := False;
    edtNumLot.Visible := False;
    pSetFocus(cbbMotivo);
  end
  else
  begin
    pSetFocus(edtNumLot);
  end;
end;

function TfrmFatAlteraLoteEntregaFuturaFaltaProduto.fPesquisaLote(
  Sender: TObject; var Key: Char; arrNumLot: TStringArray): Boolean;
var
  objfrmPnl: TPanelCxCadLote;
begin
  inherited;

  objfrmPnl := TPanelCxCadLote.Create(TfrmPnlDadosCadLote);

  Try
    objfrmPnl.strCodIte := FProduto.strCodPro;
    Result := objCadLot.fedtNumLotKeyPress(FProduto.strCodPro,
                                           Sender,
                                           Key,
                                           edtNumLot,
                                           Self,
                                           False,
                                           False,
                                           objfrmPnl,
                                           Nil,
                                           VS_strCodEmp);
  Finally
    FreeAndNil(objfrmPnl);
  End;
end;

function TfrmFatAlteraLoteEntregaFuturaFaltaProduto.fRetornaMotivo(
  AIndexMotivo: Integer): String;
begin
  Result := EmptyStr;

  case AIndexMotivo of
    0:Result := 'F';
    1:Result := 'A';
    2:Result := 'P';
  end;
end;

function TfrmFatAlteraLoteEntregaFuturaFaltaProduto.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumLot) And (edtNumLot.Visible) Then
    Begin
      If fEmptyStr(edtNumLot.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o número do lote!', ['&Ok']);
        Result := False;
      End
      Else If (edtNumLot.Text = 'A DEFINIR') Then
      Begin
        fMensagem('ATENÇÃO!', 'O lote não pode ser "A DEFINIR" !', ['&OK']);
        Result := False;
      End
      Else If Not objCadLot.fExisteLote(FProduto.strCodPro, VS_strCodEmp, edtNumLot.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Lote não encontrado!', ['&Ok']);
        Result := False;
      End
      Else If (fFormataFloat(objCadLot.qryCadLot.FieldByName('LOT_SALDOS').AsFloat, fCfgSis('DECQTD', varInteger)) < fFormataFloat(FProduto.fltQtdPen, fCfgSis('DECQTD', varInteger))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Lote sem saldo suficiente', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
