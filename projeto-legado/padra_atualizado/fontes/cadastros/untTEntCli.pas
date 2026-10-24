unit untTEntCli;

interface

uses
  SysUtils, ComboBoxFocus;

Type

  TClienteEnderecoEntrega = class
  private
    FAutoInc    : String;
    FEndereco   : String;
    FReferencia : String;
    FBairro     : String;
    FCidade     : String;
    FEstado     : String;
  public
    property AutoInc    : String read FAutoInc    write FAutoInc;
    property Endereco   : String read FEndereco   write FEndereco;
    property Referencia : String read FReferencia write FReferencia;
    property Bairro     : String read FBairro     write FBairro;
    property Cidade     : String read FCidade     write FCidade;
    property Estado     : String read FEstado     write FEstado;
  end;

  TClienteEnderecoEntregaRepositorio = class
  public
    class function fGetAutoIncEnderecoEntega(AComboBoxFocus : TComboBoxFocus) : String;
    class procedure pCarregaEnderecosEntrega(ACodigoCliente : String; var AComboBoxFocus : TComboBoxFocus);
    class function fExisteCnpjEntrega(const ACNPJ, AClienteADesconsiderar, AAutoIncremADesconsiderar : String; out AClienteQueContemCNPJ : String): Boolean;
  end;

implementation

uses Uni, untFuncoesSimples;

{ TClienteEnderecoEntregaRepositorio }

class function TClienteEnderecoEntregaRepositorio.fExisteCnpjEntrega(
  const ACNPJ, AClienteADesconsiderar, AAutoIncremADesconsiderar : String; out AClienteQueContemCNPJ : String): Boolean;
  Var
    LQuery : TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    AClienteQueContemCNPJ := EmptyStr;
    LQuery.SQL.Add(' SELECT ETC_CODCLI ');
    LQuery.SQL.Add('   FROM ENTCLI ');
    LQuery.SQL.Add('  WHERE ETC_NUCNPJ = :NUCNPJ ');
    If fEmptyStr(AAutoIncremADesconsiderar) Then
    Begin
      LQuery.SQL.Add('    AND ETC_CODCLI <> :CODCLI ');
      LQuery.ParamByName('CODCLI').AsString := AClienteADesconsiderar;
    End
    Else
    Begin
      LQuery.SQL.Add('    AND AUTOINCREM <> :AUTOINC ');
      LQuery.ParamByName('AUTOINC').AsString := AAutoIncremADesconsiderar;
    End;
    LQuery.ParamByName('NUCNPJ').AsString := ACNPJ;
    LQuery.Open;
    Result := (Not LQuery.IsEmpty);
    If (Result) Then
      AClienteQueContemCNPJ := LQuery.FieldByName('ETC_CODCLI').AsString;
  Finally
    FreeAndNil(LQuery);
  End;
end;

class function TClienteEnderecoEntregaRepositorio.fGetAutoIncEnderecoEntega(AComboBoxFocus: TComboBoxFocus): String;
var LEnderecoEntrega : TClienteEnderecoEntrega;
begin
  LEnderecoEntrega := TClienteEnderecoEntrega(AComboBoxFocus.Items.Objects[AComboBoxFocus.ItemIndex]);

  if Assigned(LEnderecoEntrega) then
    Result := LEnderecoEntrega.AutoInc
  else
    Result := '';
end;

class procedure TClienteEnderecoEntregaRepositorio.pCarregaEnderecosEntrega(ACodigoCliente : String; var AComboBoxFocus : TComboBoxFocus);
var LQuery : TUniQuery;
    LEnderecoEntrega : TClienteEnderecoEntrega;
begin
  AComboBoxFocus.Items.Clear;
  AComboBoxFocus.Items.AddObject('', nil);

  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := ' SELECT ENTCLI.AUTOINCREM, ETC_ENDENT, ETC_REFENT, ETC_BAIENT, CID_NOMCID, CID_ESTADO  '+
                       '   FROM ENTCLI '+
                       '   LEFT JOIN CADCID ON ETC_CIDENT = CID_CODCID '+
                       '  WHERE ETC_CODCLI = :CODCLI ';
    LQuery.ParamByName('CODCLI').AsString := ACodigoCliente;
    LQuery.Open;
    while not(LQuery.eof) do
    begin
      LEnderecoEntrega            := TClienteEnderecoEntrega.Create;
      LEnderecoEntrega.AutoInc    := LQuery.FieldByName('AUTOINCREM').AsString;
      LEnderecoEntrega.Endereco   := LQuery.FieldByName('ETC_ENDENT').AsString;
      LEnderecoEntrega.Referencia := LQuery.FieldByName('ETC_REFENT').AsString;
      LEnderecoEntrega.Bairro     := LQuery.FieldByName('ETC_BAIENT').AsString;
      LEnderecoEntrega.Cidade     := LQuery.FieldByName('CID_NOMCID').AsString;
      LEnderecoEntrega.Estado     := LQuery.FieldByName('CID_ESTADO').AsString;

      AComboBoxFocus.Items.AddObject(LEnderecoEntrega.Endereco+' - '+
                                     LEnderecoEntrega.Referencia+' - '+
                                     LEnderecoEntrega.Bairro+' - '+
                                     LEnderecoEntrega.Cidade+' - '+
                                     LEnderecoEntrega.Estado,
                                     LEnderecoEntrega);

      LQuery.Next;
    end;

    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;
end;

end.
