unit untConsultaEndereco;

interface

uses
  Classes, Windows, SysUtils, Controls, ExtCtrls, SHDocVw, ShellApi, Forms, ActiveX;

Type
  TEnderecoSelecionado = class
  private
    FRua: String;
    FBairro: String;
    FCidade: String;
    FEstado: String;
    FCep: String;
  public
    property Rua: String Read FRua Write FRua;
    property Bairro: String Read FBairro Write FBairro;
    property Cidade: String Read FCidade Write FCidade;
    property Estado: String Read FEstado Write FEstado;
    property Cep: String Read FCep Write FCep;
  end;

  TConsultaEndereco = Class
  private
    blnCreateBrowser: Boolean;

    FUrl: String;
    FEndereco: String;
    FNumero: String;
    FBairro: String;
    FCidade: String;
    FEstado: String;
    FCep: String;
    FUrlConsulta: String;
    FMensagemRetorno: String;
    FBrowser :TWebBrowser;
    FpnlExibicao: TPanel;
    function GetBairro: String;
    function GetCep: String;
    function GetCidade: String;
    function GetEndereco: String;
    function GetEstado: String;
    function GetNumero: String;
    function GetUrl: String;
    procedure SetBairro(const Value: String);
    procedure SetCep(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetEndereco(const Value: String);
    procedure SetEstado(const Value: String);
    procedure SetNumero(const Value: String);
    procedure SetUrl(const Value: String);
    function GetMensagemRetorno: String;
    procedure SetMensagemRetorno(const Value: String);
    function GetUrlConsulta: String;
    procedure SetUrlConsulta(const Value: String);
    procedure pSetIEEmulation(VersaoIE : Integer);
    function GetPanelExibicao: TPanel;
    procedure SetPanelExibicao(const Value: TPanel);
    function fObtemVersaoRegistro(aVersao: Integer): Integer;
    procedure pAjustarModoCompatibilidade;
    procedure pExecutarConsultaExterna;
    function fGetEndereco(strHtml: String): String;
    function fGetCidade(strHtml: String): String;
    function fProcessaEndereco(arrEnderecoSelecionado, arrCidadeSelecionada: TArray<String>): TEnderecoSelecionado;
  public
    constructor Create(Owner: TComponent; Browser: TWebBrowSer = nil);
    destructor Destroy; override;

    function fConsultarEnderecoGoogleMaps(aEndereco, aNumero, aBairro, aCidade, aEstado: String): Boolean;

    function fRetUrlConsultaEnderecoGoogleMaps(aEndereco, aNumero, aBairro, aCidade, aEstado: String): Boolean;

    function fObtemUrlConsulta(aEndereco, aNumero, aBairro, aCidade, aEstado: String): string;
    function fGetEnderecoSelecionado: TEnderecoSelecionado;

    property Url: String read GetUrl write SetUrl;
    property Endereco: String read GetEndereco write SetEndereco;
    property Numero: String read GetNumero write SetNumero;
    property Bairro: String read GetBairro write SetBairro;
    property Cidade: String read GetCidade write SetCidade;
    property Estado: String read GetEstado write SetEstado;
    property Cep: String read GetCep write SetCep;
    property MensagemRetorno: String read GetMensagemRetorno write SetMensagemRetorno;
    function ConsultaEnderecoBrowser: TWebBrowser;
    property UrlConsulta: String read GetUrlConsulta write SetUrlConsulta;
    property PanelExibicao: TPanel read GetPanelExibicao write SetPanelExibicao;

  End;

implementation

uses
  untFuncoesSimples, Registry;

{ TConsultaEndereco }

function TConsultaEndereco.ConsultaEnderecoBrowser: TWebBrowser;
begin
  Result := FBrowser;
end;

constructor TConsultaEndereco.Create(Owner: TComponent; Browser: TWebBrowSer = nil);
begin
  Url := 'http://maps.google.com/maps?q=';

  blnCreateBrowser := False;
  if not Assigned(Browser) then
  begin
    blnCreateBrowser := True;
    FBrowser := TWebBrowSer.Create(Owner);
  end
  else
    FBrowser := Browser;

  FBrowser.Silent := True;
  FBrowser.Align := alClient;
end;

destructor TConsultaEndereco.Destroy;
begin
  inherited;

  if blnCreateBrowser then
  begin
    TWinControl(FBrowser).Parent := nil;
    FreeAndNil(FBrowser);
  end;
end;

function TConsultaEndereco.fConsultarEnderecoGoogleMaps(aEndereco, aNumero, aBairro,
  aCidade, aEstado: String): Boolean;
begin
  Result := False;
  Try

    FEndereco := fTiraCaracEspeciais(aEndereco);
    FNumero := fTiraCaracEspeciais(aNumero);
    FBairro := fTiraCaracEspeciais(aBairro);
    FCidade := fTiraCaracEspeciais(aCidade);
    FEstado := fTiraCaracEspeciais(aEstado);

    If fEmptyStr(FEndereco) Then
    Begin
      FMensagemRetorno := 'É obrigatório preencher os campos "Endereço e Cidade" para realizar a pesquisa no Google."';
      Exit;
    End;

    If fEmptyStr(FCidade) Then
    Begin
      FMensagemRetorno := 'É obrigatório preencher os campos "Endereço e Cidade" para realizar a pesquisa no Google."';
      Exit;
    End;

    pAjustarModoCompatibilidade;

    FUrlConsulta := fObtemUrlConsulta(FEndereco, FNumero, FBairro, FCidade, FEstado);

    If fEmptyStr(FUrlConsulta) Then
    Begin
      FMensagemRetorno := 'Url de consulta inválida.';
      Exit;
    End;

    FBrowser.Navigate(FUrlConsulta);
    if blnCreateBrowser then
      TWinControl(FBrowser).Parent := FpnlExibicao;
    Result := True;
  Except
    Result := False;
    pExecutarConsultaExterna;
  End;
end;

function TConsultaEndereco.fGetEnderecoSelecionado: TEnderecoSelecionado;
var
  strHtml,
  strEnderecoSelecionado,
  strCidadeSelecionada: String;

  arrEnderecoSelecionado,
  arrCidadeSelecionada: TArray<String>;
begin
  Result := nil;

  strHtml := FBrowser.OleObject.Document.documentElement.outerhtml;

  strEnderecoSelecionado := fGetEndereco(strHtml);
  if not fEmptyStr(strEnderecoSelecionado) then
  begin
    strCidadeSelecionada := fGetCidade(strHtml);

    arrEnderecoSelecionado := strEnderecoSelecionado.Split([' - ']);
    arrCidadeSelecionada := strCidadeSelecionada.Split([' - ']);

    Result := fProcessaEndereco(arrEnderecoSelecionado, arrCidadeSelecionada);
  end;
end;

function TConsultaEndereco.fGetEndereco(strHtml: String): String;
var
  intContador,
  intIni,
  intFin: Integer;
begin
  if Pos('aria-live="assertive" aria-label=', strHtml) = 0 then
    Exit;

  intIni := Pos('jsan="7.bLNnBd,7.PFiNHe" jsinstance="0">', strHtml) + Length('jsan="7.bLNnBd,7.PFiNHe" jsinstance="0">');
  intFin := 0;
  for intContador := intIni to Length(strHtml) do
  begin
    if Copy(strHtml, intContador, 6) = '</div>' then
    begin
      intFin := intContador;
      Break;
    end;
  end;

  Result := Copy(strHtml,
                 intIni,
                 intFin-intIni);
end;

function TConsultaEndereco.fGetCidade(strHtml: String): String;
var
  intContador,
  intIni,
  intFin: Integer;
begin
  intIni := Pos('jsan="7.bLNnBd" jsinstance="*1">', strHtml) + Length('jsan="7.bLNnBd" jsinstance="*1">');
  intFin := 0;
  for intContador := intIni to Length(strHtml) do
  begin
    if Copy(strHtml, intContador, 6) = '</div>' then
    begin
      intFin := intContador;
      Break;
    end;
  end;

  Result := Copy(strHtml,
                 intIni,
                 intFin-intIni);
end;

function TConsultaEndereco.fProcessaEndereco(arrEnderecoSelecionado, arrCidadeSelecionada: TArray<String>): TEnderecoSelecionado;
begin
  Result := TEnderecoSelecionado.Create;

  if Length(arrEnderecoSelecionado) > 0 then
    Result.Rua := arrEnderecoSelecionado[0];

  if Length(arrEnderecoSelecionado) > 1 then
    Result.Bairro := arrEnderecoSelecionado[1];

  if Length(arrCidadeSelecionada) > 1 then
  begin
    Result.Cidade := arrCidadeSelecionada[0];

    if arrCidadeSelecionada[1].Contains(',') then
    begin
      Result.Estado := Copy(arrCidadeSelecionada[1], 0, Pos(',', arrCidadeSelecionada[1])-1);
      Result.Cep := Trim(Copy(arrCidadeSelecionada[1], Pos(',', arrCidadeSelecionada[1])+1, Length(arrCidadeSelecionada[1])));
    end
    else
      Result.Estado := arrCidadeSelecionada[1];
  end
  else if Length(arrCidadeSelecionada) = 1 then
  begin
    if arrCidadeSelecionada[0].Contains(',') then
    begin
      Result.Estado := Copy(arrCidadeSelecionada[0], 0, Pos(',', arrCidadeSelecionada[0])-1);
      Result.Cep := Trim(Copy(arrCidadeSelecionada[0], Pos(',', arrCidadeSelecionada[0])+1, Length(arrCidadeSelecionada[0])));
    end
    else
      Result.Estado := arrCidadeSelecionada[0];
  end;
end;

function TConsultaEndereco.fRetUrlConsultaEnderecoGoogleMaps(aEndereco, aNumero, aBairro, aCidade, aEstado: String): Boolean;
begin

  Result := False;

  Try

    FEndereco := fTiraCaracEspeciais(aEndereco);
    FNumero   := fTiraCaracEspeciais(aNumero);
    FBairro   := fTiraCaracEspeciais(aBairro);
    FCidade   := fTiraCaracEspeciais(aCidade);
    FEstado   := fTiraCaracEspeciais(aEstado);

    If fEmptyStr(FEndereco) Then
    Begin
      FMensagemRetorno := 'É obrigatório preencher os campos "Endereço e Cidade" para realizar a pesquisa no Google."';
      Exit;
    End;

    If fEmptyStr(FCidade) Then
    Begin
      FMensagemRetorno := 'É obrigatório preencher os campos "Endereço e Cidade" para realizar a pesquisa no Google."';
      Exit;
    End;

    FUrlConsulta := fObtemUrlConsulta(FEndereco, FNumero, FBairro, FCidade, FEstado);

    If fEmptyStr(FUrlConsulta) Then
    Begin
      FMensagemRetorno := 'Url de consulta inválida.';
      Exit;
    End;

    Result := True;

  Except
    Result := False;
    pExecutarConsultaExterna;
  End;

end;

procedure TConsultaEndereco.pExecutarConsultaExterna;
begin
  pBrowserNavigate(PChar(FUrlConsulta));
end;

function TConsultaEndereco.fObtemUrlConsulta(aEndereco, aNumero, aBairro,
  aCidade, aEstado: String): string;
begin
  FUrlConsulta := FUrl;

  If Not fEmptyStr(aEndereco) Then
    FUrlConsulta := FUrlConsulta + aEndereco + ',';

  If Not fEmptyStr(aNumero) Then
    FUrlConsulta := FUrlConsulta + aNumero + ',';

  If Not fEmptyStr(aBairro) Then
    FUrlConsulta := FUrlConsulta + aBairro + ',';

  If Not fEmptyStr(aCidade) Then
    FUrlConsulta := FUrlConsulta + aCidade + IIF(Not fEmptyStr(aEstado), '-'+aEstado, '');

  Result := FUrlConsulta;
end;

function TConsultaEndereco.GetBairro: String;
begin
  Result := FBairro;
end;

function TConsultaEndereco.GetCep: String;
begin
  Result := FCep;
end;

function TConsultaEndereco.GetCidade: String;
begin
  Result := FCidade;
end;

function TConsultaEndereco.GetEndereco: String;
begin
  Result := FEndereco;
end;

function TConsultaEndereco.GetEstado: String;
begin
  Result := FEstado;
end;

function TConsultaEndereco.GetMensagemRetorno: String;
begin
  Result := FMensagemRetorno;
end;

function TConsultaEndereco.GetNumero: String;
begin
  Result := FNumero;
end;

function TConsultaEndereco.GetPanelExibicao: TPanel;
begin
  Result := FpnlExibicao;
end;

function TConsultaEndereco.GetUrl: String;
begin
  Result := FUrl;
end;

function TConsultaEndereco.GetUrlConsulta: String;
begin
  Result := FUrlConsulta;
end;

procedure TConsultaEndereco.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TConsultaEndereco.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure TConsultaEndereco.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TConsultaEndereco.SetEndereco(const Value: String);
begin
  FEndereco := Value;
end;

procedure TConsultaEndereco.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TConsultaEndereco.SetMensagemRetorno(const Value: String);
begin
  FMensagemRetorno := Value;
end;

procedure TConsultaEndereco.SetNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure TConsultaEndereco.SetPanelExibicao(const Value: TPanel);
begin
  FpnlExibicao := Value;
end;

procedure TConsultaEndereco.SetUrl(const Value: String);
begin
  FUrl := Value;
end;

procedure TConsultaEndereco.SetUrlConsulta(const Value: String);
begin
  FUrlConsulta := Value;
end;

function TConsultaEndereco.fObtemVersaoRegistro(aVersao: Integer): Integer;
begin
  Case aVersao Of
    7  : Result := 7000;
    8  : Result := 8888;
    9  : Result := 9999;
    10 : Result := 10001;
    11 : Result := 11001;
    Else
      Result := 11001;
  End;
end;

procedure TConsultaEndereco.pAjustarModoCompatibilidade;
Var
  RegVersaoIE: TRegistry;
  VersaoAtual: Integer;
Begin
  RegVersaoIE := TRegistry.Create;
  Try
    RegVersaoIE.RootKey := HKEY_LOCAL_MACHINE;
    RegVersaoIE.OpenKey('SOFTWARE\Microsoft\Internet Explorer\Version Vector',False);
    VersaoAtual := StrToIntDef(RegVersaoIE.ReadString('IE'), 11);
    pSetIEEmulation(VersaoAtual);
  Except
    RegVersaoIE.CloseKey;
    RegVersaoIE.Free;
    MensagemRetorno := 'Não foi possível adicionar o modo de compatibilidade automaticamente. ';
  End;
end;

procedure TConsultaEndereco.pSetIEEmulation(VersaoIE : Integer);
Var
  Reg: TRegistry;
  Versao : Integer;
  VersaoAtual: Integer;
Begin
  Versao := fObtemVersaoRegistro(VersaoIE);
  Reg := TRegistry.Create;
  Try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey('SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION\',False);
    Try
      VersaoAtual := Reg.ReadInteger(ExtractFileName(ParamStr(0)));
      If VersaoAtual < Versao Then
        Reg.WriteInteger(ExtractFileName(ParamStr(0)), Versao);
    Except
      Reg.WriteInteger(ExtractFileName(ParamStr(0)), Versao);
    End;
  Finally
    Reg.CloseKey;
    Reg.Free;
  End;
End;

end.
