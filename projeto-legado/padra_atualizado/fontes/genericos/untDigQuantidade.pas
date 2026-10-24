unit untDigQuantidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigQuantidade = class(TfrmPai)
    pnlGeral: TPanel;
    lblTexto: TLabel;
    edtQtdDig: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaCamposInteger(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
    function fValidaCamposDouble(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  public
    { Public declarations }
    intMax: Integer;
    intMin: Integer;

    fltMax: Double;
    fltMin: Double;

    intDecimais : Integer;

    varTipVar: TVarType;
    class function fDigQuantidade(strCaption, strLabel: String; Var intQtdDig: Integer;
      intMin: Integer = -MaxInt; intMax: Integer = MaxInt): Boolean;
  end;

var
  frmDigQuantidade: TfrmDigQuantidade;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmDigQuantidade }

class function TfrmDigQuantidade.fDigQuantidade(strCaption, strLabel: String; Var intQtdDig: Integer;
  intMin: Integer = -MaxInt; intMax: Integer = MaxInt): Boolean;
begin

  Try
    pCriarFormularios(TfrmDigQuantidade, frmDigQuantidade);
    frmDigQuantidade.Caption := strCaption;
    frmDigQuantidade.lblTexto.Caption := strLabel;
    frmDigQuantidade.edtQtdDig.Text := IntToStr(intQtdDig);
    frmDigQuantidade.intMin := intMin;
    frmDigQuantidade.intMax := intMax;
    frmDigQuantidade.varTipVar := varInteger;
    Result := (frmDigQuantidade.ShowModal = mrOk);

    If Result Then
      intQtdDig := StrToIntDef(frmDigQuantidade.edtQtdDig.Text, -MaxInt);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fDigQuantidade]');
    End;
  End;

  pFreeAndNil(frmDigQuantidade);

end;

procedure TfrmDigQuantidade.FormCreate(Sender: TObject);
begin
  inherited;
  varTipVar := varInteger;
end;

function TfrmDigQuantidade.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Case varTipVar Of
    varInteger: Result := fValidaCamposInteger(Sender, blnBuscaPorChave);
    varDouble:  Result := fValidaCamposDouble(Sender, blnBuscaPorChave);
  End;
end;

function TfrmDigQuantidade.fValidaCamposDouble(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    fltValor: Double;
begin
  Result := True;
  If Sender = edtQtdDig Then
  Begin
    If fEmptyStr(edtQtdDig.Text) Then
    Begin
      fMensagem('ATENÇÃO!', lblTexto.Caption + ' deve ser informado(a)!', ['&Ok']);
      Result := FAlse;
    End
    Else
    Begin
      Try
        fltValor := fStrToFloat(edtQtdDig.Text);

        If Not fValidaEscala(edtQtdDig.Text, fltMin, fltMax) Then
        Begin
          fMensagem('ATENÇÃO!', lblTexto.Caption + ' deve estar entre ' + FloatToStrF(fltMin, ffFixed, 12, intDecimais) + ' e ' +
                                                                          FloatToStrF(fltMax, ffFixed, 12, intDecimais) + '!', ['&Ok']);
          Result := False;
        End;

        If (Result) Then
          edtQtdDig.Text := FloatToStrF(fltValor, ffFixed, 12, intDecimais);
      Except
        fMensagem('ATENÇÃO!', 'Digite um valor válido!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

function TfrmDigQuantidade.fValidaCamposInteger(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intValor: Integer;
begin
  Result := True;
  If Sender = edtQtdDig Then
  Begin
    If fEmptyStr(edtQtdDig.Text) Then
    Begin
      fMensagem('ATENÇÃO!', lblTexto.Caption + ' deve ser informado(a)!', ['&Ok']);
      Result := FAlse;
    End
    Else
    Begin
      Try
        intValor := StrToInt(edtQtdDig.Text);
        If intValor > intMax Then
        Begin
          fMensagem('ATENÇÃO!', lblTexto.Caption + ' deve ser menor que ' + IntToStr(intMax) + '!', ['&Ok']);
          Result := FAlse;
        End
        Else If (intValor < intMin) Then
        Begin
          fMensagem('ATENÇÃO!', lblTexto.Caption + ' deve ser maior que ' + IntToStr(intMin) + '!', ['&Ok']);
          Result := FAlse;
        End;
      Except
        fMensagem('ATENÇÃO!', 'Digite um valor válido!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

procedure TfrmDigQuantidade.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
  Begin
    Exit;
  End;

  ModalResult := mrOk;
end;

end.
