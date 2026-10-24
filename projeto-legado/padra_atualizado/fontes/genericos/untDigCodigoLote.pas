unit untDigCodigoLote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, AppEvnts,
  untCadLote, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  System.StrUtils, untFuncFatTypes;

type
  TfrmDigCodigoLote = class(TfrmPai)
    pnlCentral: TPanel;
    lblNumLot: TLabel;
    edtNumLot: TEditFocus;
    Label10: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label2: TLabel;
    edtCodEmp: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    objCadLot: TCadLot;
    fltQtdEnt: Double;
    strMotFut: String;
    strDesLot: String;
    strUltLot: String;
    function fValidaSaldoRequeLote(strMotFut, strCodIte, strCodEmp, strNumLot: String; fltQteEnt: Double): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnLiberou : Boolean;
    OperacaoOrigemFaturamento: TOperacaoFaturamento;
    procedure pSetMotFut(const strValue: string);
    procedure pSetQtdEnt(const strValue: Double);
  end;


implementation

uses untFuncoesSimples, untFuncFat, untMsgLiberacao;

{$R *.dfm}

{ TfrmEntDigEmail }

procedure TfrmDigCodigoLote.edtNumLotKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If objCadLot.fedtNumLotKeyPress(edtCodIte.Text, Sender, Key,
       edtNumLot, Self, False, True) Then
  Begin
    If fValidaCampos(edtNumLot, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmDigCodigoLote.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(objCadLot);
end;

procedure TfrmDigCodigoLote.FormCreate(Sender: TObject);
begin
  inherited;

  blnLiberou := False;
  objCadLot := TCadLot.Create(Self);
  lblNumLot.Caption := objCadLot.strTitLab + ':';
  strDesLot := objCadLot.strDescri;
  fltQtdEnt :=  0;
  strMotFut := '';
  Self.Caption := AnsiReplaceStr(Self.Caption, '<DESLOT>', strDesLot);
  OperacaoOrigemFaturamento := ofIndefinido;
  pSetaCodIte(edtCodIte);
end;

procedure TfrmDigCodigoLote.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumLot);
  SetForegroundWindow(edtNumLot.Handle);
end;

function TfrmDigCodigoLote.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtNumLot) Then
  Begin

    If (Not fEmptyStr(edtNumLot.Text)) And
       (Not objCadLot.fExisteLote(edtCodIte.Text, edtCodEmp.Text, edtNumLot.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', objCadLot.strTitLab + ' não encontrado!', ['&Ok']);
      Result := False;
    End
    Else If fEmptyStr(edtNumLot.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O ' + objCadLot.strTitLab + ' deve ser informado!', ['&Ok']);
      Result := False;
    End
    Else If Pos('A DEFINIR', edtNumLot.Text) > 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O ' + strDesLot + ' não pode ser A DEFINIR!', ['&Ok']);
      Result := False;
    End
    Else If Pos('GARANTIA', edtNumLot.Text) > 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido utilizar o lote "'+ strDesLot + '" no faturamento pois ele é um lote de controle interno da rotina de Garantia.'+#13+
                            'Selecione um lote válido para continuar.', ['&Ok']);
      Result := False;
    End
    Else If (strUltLot <> edtNumLot.Text) And
            (Not fValidaSaldoRequeLote(strMotFut, edtCodIte.Text, edtCodEmp.Text, edtNumLot.Text, fltQtdEnt)) Then
    Begin
      Result := False;
    End
    Else
      strUltLot := edtNumLot.Text;

  End;

end;

function TfrmDigCodigoLote.fValidaSaldoRequeLote(strMotFut, strCodIte, strCodEmp,
  strNumLot: String; fltQteEnt: Double): Boolean;
 Var
   fltQtdLot: Double;
   objMsg   : TMensagemLiberacao;
   strNTrava: String;
   strTipTra : String;
begin
  Result := True;

  If (fltQteEnt > 0) Then
  Begin
    fltQtdLot := objCadLot.fSaldoLote(strCodIte, strCodEmp, strNumLot);

    If (fltQteEnt > fltQtdLot) Then
    Begin
      strTipTra := fTravaSaldoVN(False, True, strMotFut, 'N', OperacaoOrigemFaturamento);

      blnLiberou := False;

      If Pos(strTipTra, 'A_T_') > 0 Then
      Begin
        If (strTipTra = 'T') Then
        Begin
          objMsg := TMensagemLiberacao.Create(Self);
          try
            objMsg.pAddTexto('Liberação de produto com '+strDesLot+' sem saldo - (Baixa de Entrega Futura)!');
            objMsg.pAddTextoCaption('Produto'            , edtCodIte.Text + '-' + edtDesIte.Text                          , 16);
            objMsg.pAddTextoCaption('Marca'              , fRetNomMarcaItem(strCodIte)                                    , 16);
            objMsg.pAddTextoCaption(strDesLot            , strNumLot                                                      , 16);
            objMsg.pAddTextoCaption('Qtd. Entregar'      , FloatToStrF(fltQteEnt, ffNumber, 12, 4)                        , 16);
            objMsg.pAddTextoCaption('Saldo ' + strDesLot ,  FloatToStrF(fltQtdLot, ffNumber, 12, 4)                       , 16);
            objMsg.pAddTextoCaption('Empresa'            , strCodEmp +' - '+ Copy(fRetNomeEmpresaSelec(strCodEmp), 1, 50) , 16);

            Result := fSenhaLiberacaoSemSaldoVN(strLoginUsuarioLogado,
                                                strLoginUsuarioLogado,
                                                strNTrava,
                                                Nil,
                                                objMsg,
                                                edtCodIte.Text + '-' + edtDesIte.Text,
                                                True,
                                                '',
                                                False,
                                                False,
                                                '',
                                                True,
                                                False);
          finally
            FreeAndNil(objMsg);
          end;
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Produto ' + edtCodIte.Text + '-' + edtDesIte.Text + ' não possui saldo suficiente no ' +
                                 strDesLot + ' informado!', ['&OK']);
        End;

        If Result Then
          blnLiberou := True;
      End;

    End;

  End;
end;

procedure TfrmDigCodigoLote.pSetMotFut(const strValue: string);
begin
  strMotFut := strValue;
end;

procedure TfrmDigCodigoLote.pSetQtdEnt(const strValue: Double);
begin
  fltQtdEnt := strValue;
end;

procedure TfrmDigCodigoLote.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

end.

