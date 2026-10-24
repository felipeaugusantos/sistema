unit untFatConfPedidosItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, UITypes,
  EditFocus, DB, Uni, AppEvnts, UniClientDataSet, Mask, DBCtrls, DBEditFocus,
  untFuncFatTypes, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untLiberacao, untMsgLiberacao;

type
  TfrmFatConfPedidosItens = class(TfrmPai)
    pnlCabecalho: TPanel;
    dbgItens: TDBGridCitel;
    pnlRodape: TPanel;
    Label1: TLabel;
    edtDesIte: TEditFocus;
    Label9: TLabel;
    edtQtdIte: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    Label32: TLabel;
    lblValUni: TLabel;
    edtValUni: TEditFocus;
    btnAltValUni: TBitBtnLocked;
    lblFatCor: TLabel;
    edtFatCor: TEditFocus;
    dbeTotGer: TDBEditFocus;
    dtsDados: TDataSource;
    lblNumLot: TLabel;
    edtNumLot: TEditFocus;
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgItensDblClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtValUniEnter(Sender: TObject);
    procedure btnAltValUniClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtFatCorEnter(Sender: TObject);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fAfterScrollAnt: TDataSetNotifyEvent;
    fltValUniAnt: Double;

    fltQtdBaiIte: Double;
    fltQtdOriIte: Double;

    objLiberacao: TLiberacao;

    Procedure pAlteraValUni(fltFatCor: Double);
    procedure pAdicionaDados(DataSet: TDataSet);
    procedure pTravaItemFracionadoKey(Sender: TObject; var Key: Char);
    procedure pDeletaQtdZero;
    function fValidaLoteWMS: Boolean;
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    cdsDados: TUniClientDataSet;
    strOpcDoc: String;
    objItensPedidos: TItensPedidos;
    blnDeletouItenCp: Boolean;
    strCodCli: String;

    procedure pAlteraSaldoEstoque;    
  end;

var
  frmFatConfPedidosItens: TfrmFatConfPedidosItens;

implementation

uses untFuncoes, untfuncoesSimples, Math, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmFatConfPedidosItens }

procedure TfrmFatConfPedidosItens.pAlteraSaldoEstoque;
begin
  With cdsDados Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('ITE_SALDOS').AsFloat := fRetSaldosEmpresa(FieldByName('ITE_CODITE').AsString,
                                                             VS_strCodEmp);
      Post;

      Next;
    End;
  End;
end;

Procedure TfrmFatConfPedidosItens.pAlteraValUni(fltFatCor: Double);
begin
  cdsDados.First;
  While Not cdsDados.Eof Do
  Begin
    cdsDados.Edit;
    cdsDados.FieldByName('ITE_UNITAR').AsFloat := RoundTo(cdsDados.FieldByName('ITE_UNITAR').AsFloat * fltFatCor, -2);
    cdsDados.FieldByName('ITE_TOTITE').AsFloat := cdsDados.FieldByName('ITE_QTDITE').AsFloat * cdsDados.FieldByName('ITE_UNITAR').AsFloat;
    cdsDados.Post;

    cdsDados.Next;
  End;
End;

function TfrmFatConfPedidosItens.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strSenha : String;
    recItemPedido: TRecItemPedido;
    arrItemPedidos: TArrItemPedidos;
    objTabela    : TRegistroMsgLiberaTabela;
    objLinha     : TLinhaMsgLibera;
begin

  Result := True;

  With dbgItens.DataSource.DataSet Do
  Begin
    fltQtdBaiIte := FieldByName('ITE_QTDBAI').AsFloat;
    fltQtdOriIte := FieldByName('ITE_QTDORI').AsFloat;

    If (strOpcDoc = 'OV') And Assigned(objItensPedidos) Then
    Begin
      arrItemPedidos := objItensPedidos[FieldByName('AUTOINCREM').AsInteger];

      fltQtdBaiIte := 0;
      fltQtdOriIte := 0;

      For recItemPedido In arrItemPedidos Do
      Begin
        fltQtdBaiIte := fltQtdBaiIte + recItemPedido.fltQtdBai;
        fltQtdOriIte := fltQtdOriIte + recItemPedido.fltQtdOri;
      End;
    End;
  End;

  If (Sender = edtQtdIte) Then
  Begin

    If (fEmptyStr(edtQtdIte.Text)) Then
    Begin
      edtQtdIte.Text := '0,00';
    End
    Else If (fStrToFloat(edtQtdIte.Text) < 0) Then
    Begin
      fMensagem('', 'A quantidade deve ser maior que Zero! ' +
                FloatToStrF(fltQtdBaiIte, ffFixed, 12, 2), ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtQtdIte.Text) > fltQtdOriIte - fltQtdBaiIte) Then
    Begin
      fMensagem('', 'Não é permitido digitar uma quantidade maior que ' +
                FloatToStrF(fltQtdOriIte - fltQtdBaiIte, ffFixed, 12, 2), ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtQtdIte.Text) > fltQtdOriIte) Then
    Begin
      fMensagem('', 'Não é permitido digitar uma quantidade maior que ' +
                    FloatToStrF(fltQtdOriIte, ffFixed, 12, 2), ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = edtValUni) And edtValUni.Enabled Then
  Begin

    If (fStrToFloat(edtValUni.Text) < 0) Then
    Begin
      fMensagem('', 'O Valor unitário deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End

    Else If fltValUniAnt <> fStrToFloat(edtValUni.Text) Then
    Begin

      If ffrmSenha(strSenha,'Alteração do valor unitário') Then
      Begin

        If strSenha <> fCfgSis('SENVRU') Then
        Begin
          edtValUni.Text := FloatToStrF(fltValUniAnt, ffFixed, 12, 4);
          Result := False;
        End
        Else
          fltValUniAnt := fStrToFloat(edtValUni.Text);

      End
      Else
      Begin
        edtValUni.Text := FloatToStrF(fltValUniAnt, ffFixed, 12, 4);
        Result := False;
      End;

    End;

  End

  Else If (Sender = edtFatCor) And edtFatCor.Visible Then
  Begin

    If (fStrToFloat(edtFatCor.Text) < 0) Then
    Begin
      fMensagem('', 'O Fator de correção do valor unitário deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End

    Else
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Alteração do valor unitário dos itens na Confirmação de Pedido.');
      objLiberacao.objMsgLibera.pAddSeparador(75);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'      , strCodCli + ' - ' + fRetNomCliente(strCodCli), 15);
      objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ'     , fRetCgcCpf(strCodCli), 15);
      objLiberacao.objMsgLibera.pAddTextoCaption('Nome Fantasia', fRetNomFantasia(strCodCli), 15);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna('', 'Pedido'   , 12, alEsquerda, teAmbos);
      objLinha.pAddColuna('', 'Esp'      , 03, alEsquerda, teAmbos);
      objLinha.pAddColuna('', 'Emp'      , 03, alEsquerda, teAmbos);
      objLinha.pAddColuna('', 'Nº'       , 03, alDireita,  teAmbos);
      objLinha.pAddColuna('', 'Código'   , fTamCodIte + 1, alDireita,  teAmbos);
      objLinha.pAddColuna('', 'Descrição', 30, alEsquerda, teAmbos);
      objLinha.pAddColuna('', 'Lote'     , 20, alEsquerda, teAmbos);
      objLinha.pAddColuna('', 'Saldo'    , 10, alDireita,  teAmbos);
      objLinha.pAddColuna('', 'Qtde'     , 10, alDireita,  teAmbos);
      objLinha.pAddColuna('', 'Unitário' , 10, alDireita,  teAmbos);
      objLinha.pAddColuna('', 'Total'    , 10, alDireita,  teAmbos);
      objTabela.lstLinhas.Add(objLinha);

      cdsDados.First;
      while not cdsDados.Eof do
      begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Pedido'   , cdsDados.FieldByName('ITE_NUMORC').AsString, 12, alEsquerda, teAmbos);
        objLinha.pAddColuna('Esp'      , cdsDados.FieldByName('ITE_ESPORC').AsString, 03, alEsquerda, teAmbos);
        objLinha.pAddColuna('Emp'      , cdsDados.FieldByName('ITE_EMPORC').AsString, 03, alEsquerda, teAmbos);
        objLinha.pAddColuna('Nº'       , cdsDados.FieldByName('ITE_SEQIND').AsString, 03, alDireita,  teAmbos);
        objLinha.pAddColuna('Código'   , cdsDados.FieldByName('ITE_CODITE').AsString, fTamCodIte + 1, alDireita,  teAmbos);
        objLinha.pAddColuna('Descrição', cdsDados.FieldByName('ITE_DESITE').AsString, 30, alEsquerda, teAmbos);
        objLinha.pAddColuna('Lote'     , cdsDados.FieldByName('ITE_NUMLOT').AsString, 20, alEsquerda, teAmbos);
        objLinha.pAddColuna('Saldo'    , FormatFloat('#,##0.00', cdsDados.FieldByName('ITE_SALDOS').AsFloat), 10, alDireita,  teAmbos);
        objLinha.pAddColuna('Qtde'     , FormatFloat('#,##0.00', cdsDados.FieldByName('ITE_QTDITE').AsFloat), 10, alDireita,  teAmbos);
        objLinha.pAddColuna('Unitário' , FormatFloat('#,##0.00', cdsDados.FieldByName('ITE_UNITAR').AsFloat), 10, alDireita,  teAmbos);
        objLinha.pAddColuna('Total'    , FormatFloat('#,##0.00', cdsDados.FieldByName('ITE_TOTITE').AsFloat), 10, alDireita,  teAmbos);
        objTabela.lstLinhas.Add(objLinha);

        cdsDados.Next;
      end;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.strDirAce := 'SENVRU';
      objLiberacao.strSenLib := fCfgSis('SENVRU');
      objLiberacao.blnManterCompatibilidadeSenCfg := not fEmptyStr(objLiberacao.strSenLib);
      objLiberacao.strMsgSen := 'Senha para alteração do valor unitário dos itens na Confirmação de Pedido.';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      If objLiberacao.fLibera Then
        pAlteraValUni(fStrToFloat(edtFatCor.Text))
      Else
        Result := False
    End;

    edtFatCor.Visible := FALSE;
    lblFatCor.Visible := FALSE;

  End;

end;

procedure TfrmFatConfPedidosItens.btnCancelaItemClick(Sender: TObject);
begin
  inherited;

  If edtNumLot.Visible Then
    cdsDados.Cancel;

  edtQtdIte.Enabled := False;
  edtValUni.Enabled := False;
  edtNumLot.Enabled := False;
  pAdicionaDados(cdsDados);
  pSetFocus(dbgItens);
end;

procedure TfrmFatConfPedidosItens.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If edtNumLot.Visible Then
  Begin
    If not fExisteLote(edtNumLot.Text,
                       cdsDados.FieldByName('ITE_CODITE').AsString,
                       VS_strCodEmp) Then
    Begin
      pMensagemOk('O lote informado não existe. Verifique!');
      pSetFocus(edtNumLot);
    End
    Else
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('ITE_NUMLOT').AsString := edtNumLot.Text;
      cdsDados.Post;

      btnCancelaItem.Click;
    End;
  End;

  If (dbgItens.DataSource.DataSet.FieldByName('ITE_TIPFIN').AsString = 'V') And
     (dbgItens.DataSource.DataSet.FieldByName('ITE_DESFIN').AsFloat > 0) Then
  Begin
    pMensagemOk('Pedido com Desconto Financeiro em Valor não pode ser faturado parcialmente.');
    btnCancelaItem.Click;
  End
  Else If (fVerificaCampos) Then
  Begin
    With dbgItens.DataSource.DataSet Do
    Begin
      Edit;
      FieldByName('ITE_TOTCUS').AsFloat := fStrToFloat(edtQtdIte.Text) * FieldByName('ITE_PRECUS').AsFloat;
      FieldByName('ITE_QTDITE').AsFloat := fStrToFloat(edtQtdIte.Text);
      FieldByName('ITE_UNITAR').AsFloat := fStrToFloat(edtValUni.Text);
      FieldByName('ITE_TOTITE').AsFloat := fStrToFloat(edtQtdIte.Text) * FieldByName('ITE_UNITAR').AsFloat;
      Post;

      If (strOpcDoc = 'OV') And Assigned(objItensPedidos) Then
      Begin
        objItensPedidos.pAcertaQuantidadeItem(FieldByName('AUTOINCREM').AsInteger, fStrToFloat(edtQtdIte.Text));
      End;
    End;      

    btnCancelaItem.Click;

  End;

end;

procedure TfrmFatConfPedidosItens.btnConfirmaClick(Sender: TObject);

  Function fPossuiSomenteBrinde: Boolean;
  begin
    If (dbgItens.DataSource.DataSet.RecordCount = 0) Then
      Result := False
    Else
      Result := True;

    dbgItens.DataSource.DataSet.DisableControls;
    dbgItens.DataSource.DataSet.First();

    While (Not dbgItens.DataSource.DataSet.Eof) Do Begin
      If (dbgItens.DataSource.DataSet.FieldByName('ITE_QTDITE').AsFloat > 0) And
        (dbgItens.DataSource.DataSet.FieldByName('ITE_BRINDE').AsString <> 'S') Then Begin
        Result := False;
        Break;
      End;

      dbgItens.DataSource.DataSet.Next();
    End;

    dbgItens.DataSource.DataSet.EnableControls;
  end;

begin
  inherited;

  If edtNumLot.Visible Then
  Begin
    If fValidaLoteWMS Then
    Begin
      fMensagem('ATENÇÃO', 'Não é permitido lote "A DEFINIR" utilizando rotina de WMS.', ['&Ok']);
      Exit;
    End;
  End;

  If (fStrToFloat(dbeTotGer.Text) <= 0) And (Not fPossuiSomenteBrinde()) Then
  Begin
    fMensagem('', 'É necessário selecionar pelo menos um produto para confirmar!', ['&Ok']);
    Exit;
  End;

  pDeletaQtdZero;

  Close;
  ModalResult := mrOk;
end;

procedure TfrmFatConfPedidosItens.edtNumLotKeyPress(Sender: TObject;
  var Key: Char);
Var
  qryCadLot: TUniQuery;
  arrLotes: TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    Try
      qryCadLot := fCriaQuery;
      If fPesqLoteFat(Self, edtNumLot,
                      fCfgSis('DECUNI'),
                      cdsDados.FieldByName('ITE_CODITE').AsString,
                      false, false,
                      qryCadLot, Key, arrLotes) Then
      Begin
        cdsDados.edit;
        edtNumLot.Text := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
        cdsDados.post;
      End;
    Finally
      FreeAndNil(qryCadLot);
    End;
  End;

end;

procedure TfrmFatConfPedidosItens.FormShow(Sender: TObject);
begin
  inherited;
  fAfterScrollAnt := cdsDados.AfterScroll;
  cdsDados.AfterScroll := pAdicionaDados;
  pAdicionaDados(cdsDados);

  btnAltValUni.Visible := Not fEmptyStr(fCfgSis('SENVRU'));

  dtsDados.DataSet := cdsDados;
  blnDeletouItenCp := False;

  lblNumLot.Visible := ((strOpcDoc = 'OV') And fUsaRotinaWMS(VS_strCodEmp));
  edtNumLot.Visible := lblNumLot.Visible;

  TFloatField(cdsDados.FieldByName('ITE_SALDOS')).DisplayFormat := '#,##0.000';
end;

procedure TfrmFatConfPedidosItens.pAdicionaDados(DataSet: TDataSet);
begin
  edtDesIte.Text := DataSet.FieldByName('ITE_CODITE').AsString + ' - ' +
                    DataSet.FieldByName('ITE_DESITE').AsString;
  edtQtdIte.Text := FloatToStrF(DataSet.FieldByName('ITE_QTDITE').AsFloat, ffFixed, 12, 2);
  edtValUni.Text := FloatToStrF(DataSet.FieldByName('ITE_UNITAR').AsFloat, ffFixed, 12, 4);
  edtNumLot.Text := DataSet.FieldByName('ITE_NUMLOT').AsString;
end;

procedure TfrmFatConfPedidosItens.dbgItensDblClick(Sender: TObject);
begin
  inherited;

  If fCfgSis('QTDPAR', varBoolean) And Not fUsaRotinaWMS Then
  Begin

    {********************************}
    {* TRAVA ITEM FRACIONADO OU NAO *}
    {*****************************JB*}
    If Not fItemFracionado(dbgItens.DataSource.DataSet.FieldByName('ITE_CODUNI').AsString) Then
      edtQtdIte.OnKeyPress := pTravaItemFracionadoKey
    Else
      edtQtdIte.OnKeyPress := Nil;

    edtQtdIte.Enabled := True;
    pSetFocus(edtQtdIte);
  End;

  If Not fEmptyStr(fCfgSis('SENVRU')) Then
  Begin
    edtValUni.Enabled := True;
    If Not edtQtdIte.Enabled Then
      pSetFocus(edtValUni);
  End;

  If edtNumLot.Visible Then
    edtNumLot.Enabled := True;

end;

procedure TfrmFatConfPedidosItens.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Assigned(cdsDados) And cdsDados.Active And Not cdsDados.IsEmpty Then
  Begin
    If ((cdsDados.RecNo Mod 2) = 0) And (dbgItens.Canvas.Brush.Color <> clHighLight) Then
    Begin
      dbgItens.Canvas.Brush.Color := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
      dbgItens.Canvas.FillRect(Rect);
      dbgItens.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    End;
  End;
end;

procedure TfrmFatConfPedidosItens.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    dbgItensDblClick(dbgItens)
  Else If (Key = VK_ESCAPE) Then
    btnSair.Click
  Else If (Key = VK_DELETE) Then
  Begin
    If (Not dbgItens.DataSource.DataSet.IsEmpty) Then
    Begin
      dbgItens.DataSource.DataSet.Delete;
      blnDeletouItenCp := True;
    End;
  End;
end;

procedure TfrmFatConfPedidosItens.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsDados.AfterScroll := fAfterScrollAnt;
end;

procedure TfrmFatConfPedidosItens.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmFatConfPedidosItens.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objLiberacao);
end;

procedure TfrmFatConfPedidosItens.pEscapePressed;
begin

  If ((ActiveControl).Parent = pnlCabecalho) Then
  Begin
    btnCancelaItem.Click;
  End
  Else
  Begin
    inherited;
  End;

end;

procedure TfrmFatConfPedidosItens.edtValUniEnter(Sender: TObject);
begin
  inherited;
  fltValUniAnt := fStrToFloat(edtValUni.Text);
end;

procedure TfrmFatConfPedidosItens.btnAltValUniClick(Sender: TObject);
begin
  inherited;

  If Not btnAltValUni.Visible Then
    Exit;

  edtFatCor.Visible := TRUE;
  lblFatCor.Visible := TRUE;
  pSetFocus(edtFatCor);
end;

procedure TfrmFatConfPedidosItens.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_ESCAPE : If (ActiveControl) = edtFatCor Then
                Begin
                  edtFatCor.Visible := FALSE;
                  lblFatCor.Visible := FALSE;
                  Key := 0;
                End

                Else inherited;

    VK_F4     : btnAltValUni.Click;

    VK_F10    : Begin
                  Key := 0;
                  btnConfirma.Click;
                End;

    Else        inherited;
  End;

end;

procedure TfrmFatConfPedidosItens.edtFatCorEnter(Sender: TObject);
begin
  inherited;

  edtFatCor.Text := FloatToStrF(0, ffFixed, 12, 2);
end;

procedure TfrmFatConfPedidosItens.pTravaItemFracionadoKey(Sender: TObject; var Key: Char);
Begin

  If CharInSet(Key, [',','.','-']) Then
    Key := #0;

End;

procedure TfrmFatConfPedidosItens.pDeletaQtdZero;
  Var
    blnFiltered: Boolean;
Begin

  With cdsDados Do
  Begin
    DisableControls;

    blnFiltered := Filtered;

    Filtered := False;

    First;

    While Not Eof Do
    Begin
      If FieldByName('ITE_QTDITE').AsFloat = 0 Then
      Begin
        Delete;
      End
      Else
      Begin
        Next;
      End;
    End;

    Filtered := blnFiltered;

    EnableControls;
  End;

End;

function TfrmFatConfPedidosItens.fValidaLoteWMS: Boolean;
Var
  cdsLotes: TUniClientDataSet;
begin

  Try
    cdsLotes := TUniClientDataSet.Create(nil);
    cdsLotes.Data := cdsDados.Data;

    With cdsLotes Do
    Begin
      Filtered := False;
      Filter   := 'ITE_NUMLOT = '+QuotedStr('A DEFINIR');
      Filtered := True;

      Result := (RecordCount > 0);
    End;
  Finally
    FreeAndNil(cdsLotes);
  End;

end;

end.

