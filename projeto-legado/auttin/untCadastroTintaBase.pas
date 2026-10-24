unit untCadastroTintaBase;

interface

uses
  untCadastroTinta, untICadastroTintaBase, SysUtils;

Type
  TCadastroTintaBase = class(TCadastroTinta, ICadastroTintaBase)

  public
    
    function fGetCampoBase: String; virtual; abstract;
    function fGetCampoCodItem: String; virtual; abstract;
    function fGetCampoCodigo: String; virtual; abstract;
    function fGetCampoCusto: String; virtual; abstract;
    function fGetCampoDescricao: String; virtual; abstract;
    function fGetCampoMargem: String; virtual; abstract;
    function fGetCampoUnidade: String; virtual; abstract;
    function fGetCampoEmbala: String; virtual;
    function fGetCampoVenda: String; virtual; abstract;
    function fGetLabelBase: String; virtual;
    function fGetLabelCodItem: String; virtual;
    function fGetLabelCodigo: String; virtual;
    function fGetLabelCusto: String; virtual;
    function fGetLabelDescricao: String; virtual;
    function fGetLabelMargem: String; virtual;
    function fGetLabelUndiade: String; virtual;
    function fGetLabelVenda: String; virtual;
    function fGetFiltro(): String; virtual;
    function fValidaCampos(strNomeCampo: String; strValorCampo: String;
      var strRetorno: String): Boolean; override;
  End;

implementation

uses
  untFuncoesSimples;

{ TCadastroTintaBase }



function TCadastroTintaBase.fGetCampoEmbala: String;
begin
  Result := '';
end;

function TCadastroTintaBase.fGetFiltro: String;
begin
  Result := '';
end;

function TCadastroTintaBase.fGetLabelBase: String;
begin
  Result := 'Base';
end;

function TCadastroTintaBase.fGetLabelCodigo: String;
begin
  Result := 'Código';
end;

function TCadastroTintaBase.fGetLabelCodItem: String;
begin
  Result := fGetLabelCodIteCodIte;
end;

function TCadastroTintaBase.fGetLabelCusto: String;
begin
  Result := 'Custo';
end;

function TCadastroTintaBase.fGetLabelDescricao: String;
begin
  Result := 'Descrição';
end;

function TCadastroTintaBase.fGetLabelMargem: String;
begin
  Result := 'Margem';
end;

function TCadastroTintaBase.fGetLabelUndiade: String;
begin
  Result := 'Unidade';
end;

function TCadastroTintaBase.fGetLabelVenda: String;
begin
  Result := 'Venda';
end;

function TCadastroTintaBase.fValidaCampos(strNomeCampo,
  strValorCampo: String; var strRetorno: String): Boolean;
begin
  Result := True;
  If (strNomeCampo = fGetCampoCodigo) Then
  Begin
    Result := Not fEmptyStr(strValorCampo);
    strRetorno := 'O código da fórmula deve ser preenchido!';
  End
  Else If (strNomeCampo = fGetCampoBase) Then
  Begin
    Result := Not fEmptyStr(strValorCampo);
    strRetorno := 'O campo ' + fGetLabelBase + ' deve ser preenchido!';
  End
  Else If (strNomeCampo = fGetCampoUnidade) Then
  Begin
    Result := Not fEmptyStr(strValorCampo);
    strRetorno := 'O campo ' + fGetLabelUndiade + ' deve ser preenchido!';
  End
  Else If (strNomeCampo = fGetCampoDescricao) Then
  Begin
    Result := Not fEmptyStr(strValorCampo);
    strRetorno := 'O campo ' + fGetLabelDescricao + ' deve ser preenchido!';
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
  End;
end;

end.
