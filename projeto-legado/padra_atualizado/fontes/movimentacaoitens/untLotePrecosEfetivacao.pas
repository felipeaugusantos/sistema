unit untLotePrecosEfetivacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  untLotePrecos, StrUtils, BitBtnLockedIncrem, ComCtrls, MemDS, DBAccess,
  Provider, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmLotePrecosEfetivacao = class(TfrmPaiOrdena)
    Label1: TLabel;
    edtCodFor: TEditFocus;
    Label2: TLabel;
    edtNumDoc: TEditFocus;
    Label3: TLabel;
    edtEspDoc: TEditFocus;
    Label4: TLabel;
    edtSerie: TEditFocus;
    Label5: TLabel;
    edtDtaEnt: TEditFocus;
    Label6: TLabel;
    edtOpeRes: TEditFocus;
    dtsPrecos: TDataSource;
    btnPesLot: TBitBtnLocked;
    Panel1: TPanel;
    pnlTitPrecos: TPanel;
    dbgPrecos: TDBGridCitel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Shape1: TShape;
    Label8: TLabel;
    Shape2: TShape;
    splPrecos: TSplitter;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    edtQtdSel: TEditFocus;
    edtQtdReg: TEditFocus;
    btnConfirma: TBitBtnLocked;
    pgbProgresso: TProgressBar;
    Label11: TLabel;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgPrecosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure btnPesLotClick(Sender: TObject);
    procedure dbgConsultaEnter(Sender: TObject);
    procedure dbgConsultaExit(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure dbgPrecosEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgPrecosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    objPreLotes: TLotePrecos;

    procedure pConfirmaBaixa(blnGravaPreIte: Boolean = False; dtaDtaAtu: TDateTime = 0);

    procedure pLimparTela;

  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean = True): Boolean; Override;    
  end;

var
  frmLotePrecosEfetivacao: TfrmLotePrecosEfetivacao;

implementation

uses  untPai, untFuncoesSimples, untFuncoes, untDllOpeProd, System.UITypes;

{$R *.dfm}

function TfrmLotePrecosEfetivacao.fAbreConsulta(blnLike: Boolean): Boolean;
begin
  Result := inherited fAbreConsulta(blnLike);

  If Result Then
  Begin
    TFloatField(cdsConsulta.FieldByName('ITE_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    TFloatField(cdsConsulta.FieldByName('ITE_UNITAR')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    TFloatField(cdsConsulta.FieldByName('ITE_TOTITE')).DisplayFormat := fMskDigitos(2);
    TFloatField(cdsConsulta.FieldByName('ITE_VALIPI')).DisplayFormat := fMskDigitos(2);
    TFloatField(cdsConsulta.FieldByName('ITE_VALRET')).DisplayFormat := fMskDigitos(2);
  End;
  
end;

function TfrmLotePrecosEfetivacao.fGetSql(blnLike: Boolean): String;
begin
  Result := objPreLotes.fMontaSqlItens;
end;

procedure TfrmLotePrecosEfetivacao.FormShow(Sender: TObject);
begin
  inherited;
  objPreLotes := TLotePrecos.Create(Self);
  cdsConsulta.AfterOpen := objPreLotes.pAfterOpenLotePrecos;

  dtsPrecos.DataSet := objPreLotes.cdsPrecos;

  fAbreConsulta(True);
  
  pLimparTela;
end;

procedure TfrmLotePrecosEfetivacao.btnConfirmaClick(Sender: TObject);
  Var
    strOpcoes: String;
    dtaDtaAtu: TDateTime;
    intOpcaoSel: Integer;
begin
  inherited;

  If (cdsConsulta.RecordCount = 0) Or
     (stlListSelecao.Count    = 0) Then
  Begin
    fMensagem('','Nenhum Registro Selecionado !',['&O K']);
    Exit;
  End;

  strOpcoes := '';
  strOpcoes := strOpcoes + fPadR('Selecione a opção desejada:', 60) + #13#10;
  strOpcoes := strOpcoes + fPadR('', 60) + #13#10;
  strOpcoes := strOpcoes + fPadR('Efetivar: Realiza a baixa e agenda atualização preço.', 60) + #13#10;
  strOpcoes := strOpcoes + fPadR('Baixar..: Realiza a baixa sem agendar atualização preço.', 60) + #13#10;
  strOpcoes := strOpcoes + fPadR('Cancelar: Cancela a operação.', 60);
  
  intOpcaoSel := fMensagem('',strOpcoes, ['&Efetivar','&Baixar', '&Cancelar'], 1, False, 2);

  dtaDtaAtu := VS_Date;

  Case intOpcaoSel Of

    1: Begin
         If ffrmData(dtaDtaAtu, '', 'Digite a Data para a Atualização de Preços', VS_Date) Then
           pConfirmaBaixa(True, dtaDtaAtu);
       End;

    2: pConfirmaBaixa;

  End;

end;

procedure TfrmLotePrecosEfetivacao.pConfirmaBaixa(blnGravaPreIte: Boolean = False; dtaDtaAtu: TDateTime = 0);
  Var
    intContador : Integer;
    strProPri: String;
begin

  pnlInfo.Caption   := 'Processando registros, Aguarde...';
  pnlBotoes.Enabled := False;

  Application.ProcessMessages;

  pgbProgresso.Visible := True;

  With cdsConsulta Do
  Begin
    DisableControls;

    If blnGravaPreIte Then
      strProPri := fRetSequencial('PROPRI', VS_strCodEmp)
    Else
      strProPri := '';

    pgbProgresso.Max := stlListSelecao.Count;

    For intContador := 0 To stlListSelecao.Count -1 Do
    Begin
      Filtered  := False;
      Filter := 'AUTOINCREM = ' + stlListSelecao[IntContador];
      Filtered  := True;

      If RecordCount > 0 Then
        objPreLotes.pBaixarLotePrecos(cdsConsulta, strProPri, blnGravaPreIte, dtaDtaAtu);

      pgbProgresso.Position := Succ(intContador);

      Application.ProcessMessages;      
    End;

    Filter   := '';
    Filtered := False;

    EnableControls;

  End;

  pnlInfo.Caption   := '';
  pnlBotoes.Enabled := True;

  pgbProgresso.Visible := False;  

  pLimparTela;

  fMensagem('', 'Operação concluída com sucesso!', ['&Ok']);

  If blnGravaPreIte And (dtaDtaAtu <= VS_Date) Then
    pOpeProd(AltEfetivacaoPrecos);

end;

procedure TfrmLotePrecosEfetivacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pDestravarTodosLocksConexaoAtual;
end;

procedure TfrmLotePrecosEfetivacao.FormCreate(Sender: TObject);
begin
  inherited;
  btnConfirma.Align  := alLeft;
  btnMudaOrdem.Align := alLeft;
  btnPesquisar.Align := alLeft;
  btnMarcar.Align    := alLeft;
  btnDesmarcar.Align := alLeft;
  btnSair.Align      := alLeft;

  blnSempreRelerBanco   := False;
  blnSelecionaComEnter  := False;
  blnSelecionaComEspaco := True;
end;

procedure TfrmLotePrecosEfetivacao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
  Begin
    If dbgPrecos.Focused Then
      pSetFocus(dbgConsulta)

    Else If dbgConsulta.Focused Then
      pLimparTela

    Else
      inherited;

    Exit;
  End;

  inherited;

  If Key = VK_F10 Then
    btnConfirma.Click;

  If Key = VK_F6 Then
    btnMarcar.Click;

  If Key = VK_F7 Then
    btnDesmarcar.Click;

  If Key = VK_F1 Then
    btnPesLot.Click;

  If cdsConsulta.Active Then
  Begin
    edtQtdReg.Text := IntToStr(cdsConsulta.RecordCount);
    edtQtdSel.Text := IntToStr(stlListSelecao.Count);
  End;

end;

procedure TfrmLotePrecosEfetivacao.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  pDesmarcaTodos;
end;

procedure TfrmLotePrecosEfetivacao.btnMarcarClick(Sender: TObject);
begin
  inherited;
  If cdsConsulta.Active Then
    pMarcaTodos;
end;

procedure TfrmLotePrecosEfetivacao.btnPesLotClick(Sender: TObject);
  Var
    strKeyLck: String;
begin
  inherited;
  If objPreLotes.fPesquisarLotes(Self) Then
  Begin
    fAbreConsulta(True);

    With cdsConsulta Do
    If (FieldByName('LTP_CODEMP').AsString <> VS_strCodEmp) And
       (Pos(FieldByName('LTP_CODEMP').AsString, fRetEmpresasUsamPrecoMatriz) <= 0) Then
    Begin
      pMensagemOk('A Loja ' + FieldByName('LTP_CODEMP').AsString + '-' + fRetNomeEmpresaSelec(FieldByName('LTP_CODEMP').AsString) +
                  ' está configurada para não utilizar preços da matriz. Verifique o cadastro de empresas ou efetive os preços na própria loja.');

      pLimparTela;
    End Else
    Begin
      pDestravarTodosLocksConexaoAtual;

      strKeyLck := 'LOTE_PRECOS_' + cdsConsulta.FieldByName('LTP_NUMDOC').AsString +
                                    cdsConsulta.FieldByName('LTP_CODEMP').AsString +
                                    cdsConsulta.FieldByName('LTP_ESPDOC').AsString +
                                    cdsConsulta.FieldByName('LTP_CODFOR').AsString +
                                    cdsConsulta.FieldByName('LTP_SERIE_').AsString;

      If Not fLock_Unlock(strKeyLck, True, False) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse documento está sendo utilizado em outra estação: ' + fGetHostLock(strKeyLck + '%'), ['&Ok']);
        pLimparTela;
      End Else
      Begin
        pSetFocus(dbgConsulta);
        edtNumDoc.Text := cdsConsulta.FieldByName('LTP_NUMDOC').AsString;
        edtEspDoc.Text := cdsConsulta.FieldByName('LTP_ESPDOC').AsString;
        edtSerie.Text  := cdsConsulta.FieldByName('LTP_SERIE_').AsString;
        edtCodFor.Text := cdsConsulta.FieldByName('LTP_CODFOR').AsString;
        edtOpeRes.Text := cdsConsulta.FieldByName('LTP_OPERES').AsString;
        edtDtaEnt.Text := cdsConsulta.FieldByName('LTP_DTAENT').AsString;

        edtCodFor.Text := edtCodFor.Text  + '-' + fRetNomFornecedor(edtCodFor.Text);
        edtOpeRes.Text := edtOpeRes.Text  + '-' + fRetNomeOperador(edtOpeRes.Text);
      End;
    End;
  End
  Else
  Begin
    pLimparTela;
  End;
end;

procedure TfrmLotePrecosEfetivacao.pLimparTela;
begin
  pnlTitPrecos.Caption := 'PREÇOS DO PRODUTO:';

  edtNumDoc.Clear;
  edtEspDoc.Clear;
  edtSerie.Clear;
  edtDtaEnt.Clear;
  edtOpeRes.Clear;
  edtCodFor.Clear;
  edtQtdSel.Clear;
  edtQtdReg.Clear;

  If cdsConsulta.Active Then
  Begin
    cdsConsulta.EmptyDataSet;
    objPreLotes.pAtualizaCdsPrecos(cdsConsulta);
  End;

  pDesmarcaTodos;
  cdsConsulta.Close;

  pDestravarTodosLocksConexaoAtual;

  pSetFocus(btnPesLot);
end;

procedure TfrmLotePrecosEfetivacao.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  pnlTitPrecos.Caption := 'PREÇOS DO PRODUTO: ' + DataSet.FieldByName('ITE_DESCRI').AsString;
  objPreLotes.pAtualizaCdsPrecos(DataSet);
end;

procedure TfrmLotePrecosEfetivacao.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If (cdsConsulta.Active) And
     (dbgConsulta.Canvas.Brush.Color = clHighlight) And
     (stlListSelecao.IndexOf(QuotedStr(cdsConsulta.FieldByName('AUTOINCREM').AsString)) > -1) Then
  Begin
    dbgConsulta.Canvas.Font.Color := clLime;
    dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

procedure TfrmLotePrecosEfetivacao.dbgConsultaEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'PRESSIONE [ ESPAÇO ] PARA MARCAR/DESMARCAR O PRODUTO...';
end;

procedure TfrmLotePrecosEfetivacao.dbgConsultaExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmLotePrecosEfetivacao.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  With cdsConsulta Do
  Begin
    If (Key = VK_SPACE) And (RecNo < RecordCount)Then
      RecNo := RecNo + 1;
  End;

  If (Key = VK_RETURN) Then
    pSetFocus(dbgPrecos);  

end;

procedure TfrmLotePrecosEfetivacao.dbgPrecosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  var
    DataSet: TDataSet;
begin
  inherited;
  DataSet := dbgPrecos.DataSource.DataSet;

  If DataSet.FieldByName('TITULO').AsString = 'S' Then
  Begin
    dbgPrecos.Canvas.Brush.Color := clSilver;
    dbgPrecos.Canvas.FillRect(Rect);
    dbgPrecos.Canvas.Font.Color := clBlack;

    If Column.FieldName = 'DESCRI' Then
      dbgPrecos.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, DataSet.FieldByName('DESCRI').AsString);
  End;

  If (Column.FieldName = 'CAMALT') Then
  Begin
    If (DataSet.FieldByName('CAMALT').AsString = 'S') Then
      dbgPrecos.Canvas.Brush.Color := clRed;

    dbgPrecos.Canvas.FillRect(Rect);
  End;
end;

procedure TfrmLotePrecosEfetivacao.dbgPrecosEnter(Sender: TObject);
begin
  inherited;
  If dbgPrecos.DataSource.DataSet.Active Then
    dbgPrecos.DataSource.DataSet.RecNo := 2;
end;

procedure TfrmLotePrecosEfetivacao.dbgPrecosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: objPreLotes.pAlterarPrecoMargem(cdsConsulta);
  End;
end;

end.
