unit untCadastroTintaBaseAutomotiva;

interface

uses
  untCadastroTinta, untICadastroTintaBaseAutomotiva;

Type
  TCadastroTintaBaseAutomotiva = class(TCadastroTinta, ICadastroTintaBaseAutomotiva)
  public
    function fGetCampoCodItem: String; virtual; abstract;
    function fGetCampoCodigo: String; virtual; abstract;
    function fGetCampoCusto: String; virtual; abstract;
    function fGetCampoDescricao: String; virtual; abstract;
    function fGetCampoEmbalagem: String; virtual; abstract;
    function fGetCampoMargem: String; virtual; abstract;
    function fGetCampoPesoEspecifico: String; virtual; abstract;
    function fGetCampoVenda: String; virtual; abstract;
    function fGetLabelCodItem: String; virtual;
    function fGetLabelCodigo: String; virtual;
    function fGetLabelCusto: String; virtual;
    function fGetLabelDescricao: String; virtual;
    function fGetLabelEmbalagem: String; virtual;
    function fGetLabelMargem: String; virtual;
    function fGetLabelPesoEspecifico: String; virtual;
    function fGetLabelVenda: String; virtual;
    function fValidaCampos(strNomeCampo: String; strValorCampo: String;
      var strRetorno: String): Boolean; override;
    function fGetSqlUpdateCnvMl(): string; virtual; abstract;

  End;

implementation

uses
  untFuncoesSimples, SysUtils;

{ TCadastroTintaBaseAutomotiva }

function TCadastroTintaBaseAutomotiva.fGetLabelCodigo: String;
begin
  Result := 'Código';
end;

function TCadastroTintaBaseAutomotiva.fGetLabelCodItem: String;
begin
  Result := fGetLabelCodIteCodIte;
end;

function TCadastroTintaBaseAutomotiva.fGetLabelCusto: String;
begin
  Result := 'Custo';
end;

function TCadastroTintaBaseAutomotiva.fGetLabelDescricao: String;
begin
  Result := 'Descrição';
end;

function TCadastroTintaBaseAutomotiva.fGetLabelEmbalagem: String;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaBaseAutomotiva.fGetLabelMargem: String;
begin
  Result := 'Margem';
end;

function TCadastroTintaBaseAutomotiva.fGetLabelPesoEspecifico: String;
begin
  Result := 'Peso Específico';
end;

function TCadastroTintaBaseAutomotiva.fGetLabelVenda: String;
begin
  Result := 'Venda';
end;

function TCadastroTintaBaseAutomotiva.fValidaCampos(strNomeCampo,
  strValorCampo: String; var strRetorno: String): Boolean;
begin
  Result := True;
  If (strNomeCampo = fGetCampoCodigo) Then
  Begin
    Result := Not fEmptyStr(strValorCampo);
    strRetorno := 'O código da base deve ser preenchida!';
  End
  Else If (strNomeCampo = fGetCampoDescricao) Then
  Begin
    Result := Not fEmptyStr(strValorCampo);
    strRetorno := 'A descrição deve ser preenchida!';
  End
  Else If (strNomeCampo = fGetCampoEmbalagem) Then
  Begin
    If fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A embalagem deve ser preenchida!';
    End
    Else If fStrToFloat(strValorCampo) <= 0 Then
    Begin
      Result := False;
      strRetorno := 'A embalagem deve ser maior que zero!';
    End;
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
  End
  Else If (strNomeCampo = fGetCampoCodItem) Then
  Begin
    If Not fEmptyStr(strValorCampo) Then
    Begin
      If Not fProdutoCadastrado(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := Format('O produto %s não está cadastrado', [strValorCampo]);
      End
    End;
  End
  Else If (strNomeCampo = fGetCampoPesoEspecifico) Then
  Begin
    If fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'O peso específico deve ser preenchido!';
    End
    Else If fStrToFloat(strValorCampo) <= 0 Then
    Begin
      Result := False;
      strRetorno := 'O peso específico deve ser maior que zero!';
    End;
  End;
end;

end.
