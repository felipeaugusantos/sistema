unit untCadastraContagemEdicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCurrencyEdit, cxCalendar,
  EditFocus, Vcl.Mask, MaskEditFocus,
  untFuncoesSimples,
  untFuncoesConsulta,
  untConsultas,
  untTypesSistema,
  untCadLote,
  untCadastroContagemLote;

type
  TfrmCadastraContagemEdicao = class(TfrmPaiConfirma)
    pnlTopo: TPanel;
    cxvItens: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxStyleRepository1: TcxStyleRepository;
    cxsZebra: TcxStyle;
    btnExcluir: TBitBtnLocked;
    cxvItensCODITE: TcxGridDBColumn;
    cxvItensDESITE: TcxGridDBColumn;
    cxvItensLOCFIS: TcxGridDBColumn;
    cxvItensQTDCON: TcxGridDBColumn;
    cxvItensDTAVAL: TcxGridDBColumn;
    Label1: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    lblLocFis: TLabel;
    edtLocFis: TEditFocus;
    lbl3: TLabel;
    mskDtaVal: TMaskEditFocus;
    Label8: TLabel;
    edtQtdIte: TEditFocus;
    cxvItensNUMLOT: TcxGridDBColumn;
    procedure cxvItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocFisExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    arrLocFis,
    arrProduto: TConsultasArray;

    strTraLoc,
    strNumLot: String;

    blnArmazem,
    blnUsaWMS,
    blnValObr,
    blnCadLoc: Boolean;

    objCadLot: TCadLot;

    Procedure pLimpaTela;

  //  procedure pCarregaContagem;

  public
    { Public declarations }
    strLocFis: String;

    objContagem: TCadastroContagemLote;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
  end;

var
  frmCadastraContagemEdicao: TfrmCadastraContagemEdicao;

implementation

{$R *.dfm}

Uses
  untConstantes,
  untMensagemTravaLote,
  untCadLoteItens;

procedure TfrmCadastraContagemEdicao.btnExcluirClick(Sender: TObject);
begin
  inherited;

  objContagem.pApagaRegistro;
end;

procedure TfrmCadastraContagemEdicao.cxvItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE: btnExcluir.Click;
    VK_RETURN: If objContagem.State = dsEdit Then
                 objContagem.Post;
               (*
               Else
               Begin
                 pCarregaContagem;
                 pSetFocus(edtCodIte);
               End; *)
  End;
end;

(*
procedure TfrmCadastraContagemEdicao.pCarregaContagem;
Begin
  If objContagem.IsEmpty Then
    Exit;

  edtCodIte.Text := objContagem.FieldByName('CODITE').AsString;
  edtDesIte.Text := objContagem.FieldByName('DESITE').AsString;
  mskDtaVal.Text := FormatDateTime('DD/MM/YYYY', objContagem.FieldByName('DTAVAL').AsDateTime);
  edtLocFis.Text := objContagem.FieldByName('LOCFIS').AsString;
  edtQtdIte.Text := FormatFloat(fMskDigitos(4), objContagem.FieldByName('DIGCON').AsFloat);
End;
*)

procedure TfrmCadastraContagemEdicao.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrProduto) And
     fValidaCampos(edtCodIte, True) Then
    self.SelectNext(ActiveControl, True, True);

end;

procedure TfrmCadastraContagemEdicao.edtLocFisExit(Sender: TObject);
begin
  inherited;

  If blnCadLoc Then
    pEdtCodSelectExit(edtLocFis, Nil, arrLocFis, Nil, Nil, 'da Localização Física');

end;

procedure TfrmCadastraContagemEdicao.edtLocFisKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocFis, Nil, Nil, Key, arrLocFis) And
     fValidaCampos(edtLocFis, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadastraContagemEdicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If fPergunta('Confirma a gravação da contagem?') Then
    Begin
      If Not objContagem.fAdicionaContagemExterna Then
        Action := caNone;
    End

    Else Action := caNone;

  End Else
  Begin

    If (Not objContagem.IsEmpty) And
       (Not fPergunta('A contagem não foi salva. Deseja abandonar a tarefa?')) Then
      Action := caNone;

  End;

end;

procedure TfrmCadastraContagemEdicao.FormCreate(Sender: TObject);
begin
  inherited;

  blnVerificaCampos := False;

  strLocFis  := '';
  blnCadLoc  := fCfgSis('CADLOC', varBoolean);
  blnArmazem := fCfgSis('CTLEST') = '2';
  strTraLoc  := fCfgSIs('TRALOC');

  blnUsaWMS := fUsaRotinaWMS;

  objCadLot := TCadLot.Create(Self);

  objContagem := TCadastroContagemLote.Create(Self);

  cxvItens.DataController.DataSource := objContagem.dtsSource;
end;

procedure TfrmCadastraContagemEdicao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
  End;

end;

procedure TfrmCadastraContagemEdicao.FormShow(Sender: TObject);
begin
  inherited;

  pLimpaTela;

  objContagem.fIniciaLotes(strLocFis);
end;

Procedure TfrmCadastraContagemEdicao.pLimpaTela;
Begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtQtdIte.Text := '';

  edtLocFis.Text := strLocFis;
  mskDtaVal.Text := '31/12/9999';

  pSetFocus(edtCodIte);
End;

function TfrmCadastraContagemEdicao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtCodIte Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        Result := False;
        pMensagemOk('Informe a código do produto!');
      End Else
      Begin

        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

        If fEmptyStr(edtDesIte.Text) Then
        Begin
          Result := False;
          pMensagemOk('Produto não encontrdado!');
        End;

      End;

      If Result Then
        blnValObr := (fRetValObrProduto(edtCodIte.text) = 'S') Or blnUsaWMS;

    End

    Else If Sender = mskDtaVal Then
    Begin

      If blnValObr Then
      Begin

        If fEmptyDate(mskDtaVal.Text) Then
        Begin
          Result := False;
          pMensagemOk('Informe a data de validade!');
        End

        Else If blnBuscaPorChave Or fEmptyStr(strNumLot) Then
        Begin
          mskDtaVal.Text := FormatDateTime('DD/MM/YYYY', StrToDateDef(mskDtaVal.Text, 0));

          strNumLot := TfrmCadLoteItens.fGetNumeroLoteInclusaoRapidaWMS(mskDtaVal.Text, edtCodIte.Text);

          If objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp, strNumLot, False {blnSalPos}, False {blnSoAtivo}) Then
          Begin
            Result := False;
            pMensagemOk('Já existe o lote ' + strNumLot + ' calculado pela validade ' + mskDtaVal.Text + ' para o item ' + edtCodIte.Text + '!');
          End;

        End;

      End;

      If Result Then
      Begin
        if not (fUsaRotinaWMS and (fCfgSis('TPLREC', varString) <> 'N')) then
        begin
          If blnBuscaPorChave And objContagem.FindKey([edtCodIte.text, StrToDateDef(mskDtaVal.Text, 0)]) Then
          Begin
            edtLocFis.Text := objContagem.FieldByName('LOCFIS').AsString;
            edtQtdIte.Text := FormatFloat(fMskDigitos(4), objContagem.FieldByName('DIGCON').AsFloat);
          End;
        end;
      End;

    End

    Else If Sender = edtLocFis Then
    Begin

      If blnCadLoc Then
      Begin

        If fEmptyStr(edtLocFis.Text) Then
        Begin
          Result := False;
          pMensagemOk('Informe a localização física!');
        End

        Else If fEmptyStr(fRetNomLocFisica(edtLocFis.Text)) Then
        Begin
          Result := False;
          pMensagemOk('Localização física não encontrada!');
        End;
      End;
    End

    Else If Sender = edtQtdIte Then
    Begin

      If fEmptyStr(edtQtdIte.Text) Then
      Begin
        Result := False;
        pMensagemOk('Informe a quantidade contada!');
      End

      Else If fStrToFloat(edtQtdIte.Text) < 0 Then
      Begin
        Result := False;
        pMensagemOk('A quantidade deve ser menor ou igual a zero!');
      End
      else if fUsaRotinaWMS and (fCfgSis('TPLREC', varString) <> 'N') then
      begin
        if not objCadLot.fValidaLocalizacaoItemUnica(edtCodIte.Text, edtLocFis.Text, '', IIF(fEmptyDate(mskDtaVal.Text), 0, StrToDateDef(mskDtaVal.Text, 0))) then
        begin
          Result := False;
          if objCadLot.blnColVal then
            pMensagemOk('Não é possível cadastrar mais de um lote para o mesmo item, na mesma localização, com a mesma data de validade!')
          else
            pMensagemOk('Não é possível cadastrar mais de um lote para o mesmo item, na mesma localização!');

        end;
      end;

      If Result And blnBuscaPorChave And fVerificaCampos Then
      Begin
        Result := objContagem.fAdicionaRegistro(edtCodIte.Text, edtDesIte.Text, edtLocFis.Text, strNumLot,
                                        fStrToFloat(edtQtdIte.Text), IIF(fEmptyDate(mskDtaVal.Text), 0, StrToDateDef(mskDtaVal.Text, 0)));

        If Result Then
        Begin
          pLimpaTela;
          blnMudarFoco := False;
        End;

      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.


