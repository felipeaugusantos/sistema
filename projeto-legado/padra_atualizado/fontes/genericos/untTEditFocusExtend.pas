unit untTEditFocusExtend;

interface

  uses SysUtils, EditFocus, Winapi.Messages, Vcl.Controls, System.Classes, Vcl.Graphics, System.UITypes;

  Type
    TOnBuscaReferencia = procedure (const AText: String; var AReferencia: string; var erro: Boolean) of object;
    TEditFocus = class(EditFocus.TEditFocus)
    private
      FTextEmpty: String;
      FValorOriginal: String;
      FFontDefault : TFont;
      blnEmpty : Boolean;
      procedure SetTextEmpty(const Value: String);
    protected
      FOnBuscaReferencia: TOnBuscaReferencia;
      procedure Change; override;
     	procedure DoExit; override;
      procedure DoEnter; override;
      procedure pSetaVazio;
      procedure KeyPress(var Key: Char); override;
    public
      Referencia: String;
      strTabela: String;
      strCampo: String;
      strCampoReferencia: String;
      blnLimpouValor: Boolean;
      constructor Create(AOwner: TComponent); override;
      procedure LimparConteudo;
      destructor Destroy; override;
      property TextEmpty: String read FTextEmpty write SetTextEmpty;
      property OnBuscaReferencia: TOnBuscaReferencia read FOnBuscaReferencia write FOnBuscaReferencia;
      function fEmptyStr: Boolean;
      procedure pValidaCampoParaCarregarReferencia;

   End;


implementation

uses
  untFuncoesSimples;

{ TEditFocus }

procedure TEditFocus.Change;
begin
  inherited;
  If FTextEmpty = '' Then
  Begin
    Referencia := '';
    Exit;

  End;

  If (Text = '') And (Not blnEmpty) Then
    pSetaVazio
  Else If (blnEmpty) Or (((Length(Text) > Length(FTextEmpty)) And (Pos(Uppercase(FTextEmpty), UpperCase(Text)) > 0)) Or
                          (Length(Text) < Length(FTextEmpty))) Then
  Begin
    Referencia := '';
    Font.Color := FFontDefault.Color;
    Font.Style := FFontDefault.Style;
    blnEmpty := False;
    If (Length(Text) > Length(FTextEmpty)) And (Pos(Uppercase(FTextEmpty), UpperCase(Text)) > 0) Then
    Begin
      Text := StringReplace(UpperCase(Text),  UpperCase(FTextEmpty), '', []);
      SetSelStart(Length(Text));
    End;
  End;


end;


constructor TEditFocus.Create(AOwner: TComponent);
begin
  inherited;
  FFontDefault := TFont.Create;
  FFontDefault.Color := Font.Color;
  FFontDefault.Style := Font.Style;
end;

destructor TEditFocus.Destroy;
begin
  FreeAndNil(FFontDefault);
  inherited;
end;


procedure TEditFocus.DoEnter;
begin
  inherited;
  blnLimpouValor := False;
  FValorOriginal:= Self.Text;
end;

procedure TEditFocus.DoExit;
begin
  inherited;
  if fEmptyStr then
  Begin
    pSetaVazio;
    If FValorOriginal <> '' Then
      If FValorOriginal <> TextEmpty Then
       blnLimpouValor := True;
    blnEmpty := False;
  End;
end;

function TEditFocus.fEmptyStr: Boolean;
begin
  Result :=  (Text = '') Or (upperCase(Text) = upperCase(FTextEmpty));
end;

procedure TEditFocus.KeyPress(var Key: Char);
var
 blnConsulta: Boolean;
begin
  If FTextEmpty = '' Then
  Begin
    inherited;
    Exit;
  End;


  blnConsulta := fEntraCons(Key);


  If (Text = '') And (Not blnEmpty) Then
    pSetaVazio
  Else If blnEmpty Then
  Begin
    Text := '';

    Font.Color := FFontDefault.Color;
    Font.Style := FFontDefault.Style;

    blnEmpty := False;
  End;
  inherited;
  If blnConsulta and (Text = '') Then
    pSetaVazio


end;

procedure TEditFocus.pSetaVazio;
begin
  If Not blnEmpty Then
  Begin
    Text := TextEmpty;
    Font.Color := clGrayText;
    Font.Style := [fsBold];
    blnEmpty := True;
    Referencia := '';
  End;

end;

procedure TEditFocus.pValidaCampoParaCarregarReferencia;
var blnErro: Boolean;
begin
  blnErro := False;
  If (Text = '') Or ((strTabela = '') Or (strCampo = '') Or (strCampoReferencia = '')) Then
    Referencia := ''
  Else
  Begin
    Referencia := '';
    If Assigned(FOnBuscaReferencia) Then
    Begin
      FOnBuscaReferencia( Text, Referencia, blnErro);
      If blnErro Then
      Begin
        Self.Text := '';
        Referencia := '';
      End;
    End
    Else If Referencia = '' Then
      Referencia := fCampoTabela(strCampoReferencia, strTabela, [strCampo], [Text] );
  End;
end;

procedure TEditFocus.LimparConteudo;
begin
  If FTextEmpty <> '' Then
  BEgin
    blnEmpty := False;
    pSetaVazio;
  End;
  blnLimpouValor := False;

end;

procedure TEditFocus.SetTextEmpty(const Value: String);
begin
  FTextEmpty := Value;
  If Value <> '' Then
    pSetaVazio;
end;


end.
