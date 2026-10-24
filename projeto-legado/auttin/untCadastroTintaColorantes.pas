unit untCadastroTintaColorantes;

interface

uses
  untCadastroTinta ,untICadastroTintaColorantes, SysUtils;

Type
  TCadastroTintaColorantes = class(TCadastroTinta, ICadastroTintaColorantes)
  public
    function fGetCampoCodigo: String; virtual; abstract;
    function fGetCampoCusto: String; virtual; abstract;
    function fGetCampoDescricao: String; virtual; abstract;
    function fGetCampoItem: String; virtual; abstract;
    function fGetCampoMargem: String; virtual; abstract;
    function fGetCampoVenda: String; virtual; abstract;
    function fGetLabelCodigo: String; virtual;
    function fGetLabelCusto: String; virtual;
    function fGetLabelItem: String; virtual;
    function fGetLabelMargem: String; virtual;
    function fGetLabelVenda: String; virtual;
    function fValidaCampos(strNomeCampo: String; strValorCampo: String;
     var strRetorno: String): Boolean; override;
    procedure pAtualizaFatorTintometrico; virtual;
  End;

implementation

uses
  untFuncoesSimples;

{ TCadastroTintaColorantes }

function TCadastroTintaColorantes.fGetLabelCodigo: String;
begin
  Result := 'Código';
end;

function TCadastroTintaColorantes.fGetLabelCusto: String;
begin
  Result := 'Custo';
end;

function TCadastroTintaColorantes.fGetLabelItem: String;
begin
  Result := 'Item';
end;

function TCadastroTintaColorantes.fGetLabelMargem: String;
begin
  Result := 'Margem';
end;

function TCadastroTintaColorantes.fGetLabelVenda: String;
begin
  Result := 'Venda';
end;

function TCadastroTintaColorantes.fValidaCampos(strNomeCampo,
  strValorCampo: String; var strRetorno: String): Boolean;
begin
  Result := True;

  If (strNomeCampo = fGetCampoCodigo) Then
  Begin
    Result := Not fEmptyStr(strValorCampo);
    strRetorno := 'O código deve ser preemchido!';
  End
  Else If (strNomeCampo = fGetCampoCusto) Then
  Begin
    If (fEmptyStr(strValorCampo)) Then
    Begin
      Result := False;
      strRetorno := Format('O campo %s deve ser preenchido!', [fGetLabelCusto]);
    End
    Else If (fStrToFloat(strValorCampo) < 0) Then
    Begin
      Result := False;
      strRetorno := Format('O campo %s deve ser maior ou igual a zero!!', [fGetLabelCusto]);
    End;
  End
  Else If (strNomeCampo = fGetCampoMargem) Then
  Begin
    If (fEmptyStr(strValorCampo)) Then
    Begin
      Result := False;
      strRetorno := Format('O campo %s deve ser preenchido!', [fGetLabelMargem]);
    End
    Else If (fStrToFloat(strValorCampo) < 0) Then
    Begin
      Result := False;
      strRetorno := Format('O campo %s deve ser maior ou igual a zero!!', [fGetLabelMargem]);
    End;
  End
  Else If (strNomeCampo = fGetCampoVenda) Then
  Begin
    If (fEmptyStr(strValorCampo)) Then
    Begin
      Result := False;
      strRetorno := Format('O campo %s deve ser preenchido!', [fGetLabelVenda]);
    End
    Else If (fStrToFloat(strValorCampo) < 0) Then
    Begin
      Result := False;
      strRetorno := Format('O campo %s deve ser maior ou igual a zero!!', [fGetLabelVenda]);
    End;
  End;
end;

procedure TCadastroTintaColorantes.pAtualizaFatorTintometrico;
begin

end;

end.
