unit untValidadorNFE;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Forms,
{$ENDIF}
  SysUtils, Classes, untFonteDados, untInterfaces, untUtil, StrUtils;

Type
  IValidadorNFE = Interface(IInterface)
    function fValidarEnvio(fonteDados: IFonteDados): TResultadoValidacao;
    function fValidarCancelamento(strMotivo: String): TResultadoValidacao;
  End;

  IValidadorItem = interface(IInterface)
      function fValidaDadosItem(fonteDados: IFonteDados; dadosItem: TDadosItem; resultValidacao: TResultadoValidacao): TResultadoValidacao;
  end;

Type
  TNFEValidadorItem110 = class(TInterfacedObject, IValidadorItem)
    function fValidaDadosItem(fonteDados: IFonteDados; dadosItem: TDadosItem; resultValidacao: TResultadoValidacao): TResultadoValidacao;
  end;

Type
  TNFEValidadorItem200 = class(TInterfacedObject, IValidadorItem)
    function fValidaDadosItem(fonteDados: IFonteDados; dadosItem: TDadosItem; resultValidacao: TResultadoValidacao): TResultadoValidacao;
  end;

Type
  TNFESValidadorPainelFiscal = class(TInterfacedObject, IValidadorItem)
    function fValidaDadosItem(fonteDados: IFonteDados; dadosItem: TDadosItem; resultValidacao: TResultadoValidacao): TResultadoValidacao;
  end;

Type
  TValidadorNFE = class(TInterfacedObject, IValidadorNFE)
    private
      validadorItem: IValidadorItem;
      function fEstadoIbge(const strIbgUf: String): String;
      function fValidaDadosEmitente(fonteDados: IFonteDados; resultValidacao: TResultadoValidacao): TResultadoValidacao;
      function fValidaDadosDestinatario(fonteDados: IFonteDados; resultValidacao: TResultadoValidacao): TResultadoValidacao;
      function fValidaDadosTransportadora(fonteDados: IFonteDados; resultValidacao: TResultadoValidacao): TResultadoValidacao;
      function fValidaDadosItem(fonteDados: IFonteDados; resultValidacao: TResultadoValidacao): TResultadoValidacao;

      procedure pValidaEmailDestinatario(strEmails: String; Result: TResultadoValidacao);
    public
      function fValidarEnvio(fonteDados: IFonteDados): TResultadoValidacao;
      function fValidarCancelamento(strMotivo: String): TResultadoValidacao;

      constructor Create(validadorItem: IValidadorItem);
  End;

implementation

{ TValidadorNFE }

constructor TValidadorNFE.Create(validadorItem: IValidadorItem);
begin
  Self.validadorItem := validadorItem;
end;

function TValidadorNFE.fEstadoIbge(const strIbgUf: String): String;
  Const
    arrEstadosIbge: Array[1..27] Of Array[1..2] Of String = (
      ('12', 'AC'),
      ('27', 'AL'),
      ('13', 'AM'),
      ('16', 'AP'),
      ('29', 'BA'),
      ('23', 'CE'),
      ('53', 'DF'),
      ('32', 'ES'),
      ('52', 'GO'),
      ('21', 'MA'),
      ('31', 'MG'),
      ('50', 'MS'),
      ('51', 'MT'),
      ('15', 'PA'),
      ('25', 'PB'),
      ('26', 'PE'),
      ('22', 'PI'),
      ('41', 'PR'),
      ('33', 'RJ'),
      ('24', 'RN'),
      ('11', 'RO'),
      ('14', 'RR'),
      ('43', 'RS'),
      ('42', 'SC'),
      ('28', 'SE'),
      ('35', 'SP'),
      ('17', 'TO')
    );
  Var
    intContador: Integer;
begin
  Result := '';
  For intContador := Low(arrEstadosIbge) To High(arrEstadosIbge) Do
  Begin
    If (arrEstadosIbge[intContador][1] = strIbgUf) Then
    Begin
      Result := arrEstadosIbge[intContador][2];
    End;
  End;
end;

function TValidadorNFE.fValidaDadosDestinatario(fonteDados: IFonteDados;
  resultValidacao: TResultadoValidacao): TResultadoValidacao;
  Var
    strEmailValidar: String;
    strTitCliFor   : String;
    blnVersao310   : Boolean;
begin
  Result := resultValidacao;

  If (fonteDados.fDadosGerais.strEspDoc = 'IF') Then
    Exit;

  If (fonteDados.fDadosGerais.strTip_FC = 'F') Then
    strTitCliFor := 'fornecedor'
  Else
    strTitCliFor := 'cliente';

  blnVersao310 := fVersao310(fonteDados, '55');

  If fonteDados.fDadosGerais.strEstado <> 'EX' Then
  Begin
    If Not ((objConfigInterna.strNFSeSemCpf = 'S') And
            (fonteDados.fDadosGerais.strEspDoc = 'NS') And
            (fStringRepetida(fonteDados.fDadosGerais.strCnpj))) Then
    Begin
      If fEmptyStr(fonteDados.fDadosGerais.strCnpj) Then
        Result.pAdicionarErro('CNPJ / CPF do '+strTitCliFor+' está em branco!', Nil)
      Else If (Not fValidaCnpjCpf(fonteDados.fDadosGerais.strCnpj, fonteDados)) Then
        Result.pAdicionarErro('CNPJ / CPF do '+strTitCliFor+' é inválido!', Nil);
    End;
  End;

  If fEmptyStr(fonteDados.fDadosGerais.strNomCli) Then
    Result.pAdicionarErro('Nome do '+strTitCliFor+' está em branco!', Nil)
  Else
  If (Length(fonteDados.fDadosGerais.strNomCli) > 60) And
     (Not objConfigInterna.blnEmiEnt) Then
    Result.pAdicionarErro('Nome do '+strTitCliFor+' deve ser de no máximo 60 caracteres!', Nil);

  If fEmptyStr(Trim(fonteDados.fDadosGerais.strLogradouro)) Then
    Result.pAdicionarErro('Endereço do '+strTitCliFor+' está em branco!', Nil)
  Else If (Length(Trim(fonteDados.fDadosGerais.strLogradouro)) > 60) And blnVersao310 Then
    Result.pAdicionarErro('Endereço do '+strTitCliFor+' deve ser de no máximo 60 caracteres!', Nil)
  Else If (Length(Trim(fonteDados.fDadosGerais.strLogradouro)) < 2) And blnVersao310 Then
    Result.pAdicionarErro('Endereço do '+strTitCliFor+' deve ser de no mínimo 2 caracteres!', Nil);

  If fEmptyStr(Trim(fonteDados.fDadosGerais.strBairro)) Then
    Result.pAdicionarErro('Bairro do '+strTitCliFor+' está em branco!', Nil)
  Else If (Length(Trim(fonteDados.fDadosGerais.strBairro)) > 60) And blnVersao310 Then
    Result.pAdicionarErro('Bairro do '+strTitCliFor+' deve ser de no máximo 60 caracteres!', Nil)
  Else If (Length(Trim(fonteDados.fDadosGerais.strBairro)) < 2) And blnVersao310 Then
    Result.pAdicionarErro('Bairro do '+strTitCliFor+' deve ser de no mínimo 2 caracteres!', Nil);

  If fEmptyStr(fonteDados.fDadosGerais.strNumeroEnd) Then
    Result.pAdicionarErro('O número do endereço do '+strTitCliFor+' está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosGerais.strCodIbge) Then
    Result.pAdicionarErro('Código IBGE do '+strTitCliFor+' está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosGerais.strNomeCidade) Then
    Result.pAdicionarErro('Nome da Cidade do '+strTitCliFor+' está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosGerais.strEstado) Then
    Result.pAdicionarErro('Estado do '+strTitCliFor+' está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosGerais.strCEP) Then
    Result.pAdicionarErro('CEP do '+strTitCliFor+' está em branco!', Nil);

  If (Not fEmptyStr(fonteDados.fDadosGerais.strCodIbge)) And (fonteDados.fDadosGerais.strEstado <> 'EX') Then
  Begin
    If (fEstadoIbge(fonteDados.fDadosGerais.strUfIbge) <> fonteDados.fDadosGerais.strEstado) Then
    Begin
      Result.pAdicionarErro('O Estado do '+strTitCliFor+' cadastrado no cadastro de cidades (' +
        fonteDados.fDadosGerais.strEstado + ') está diferente do cadastro IBGE (' +
        fonteDados.fDadosGerais.strUfIbge + ')!', Nil);
    End;
  End;

  If (Not fEmptyStr(fonteDados.fDadosGerais.strIES))          And
     (Not SameText(fonteDados.fDadosGerais.strIES, 'ISENTO')) Then
  Begin
    If Not fValidaIES(fonteDados.fDadosGerais.strIES,
                      fonteDados.fDadosGerais.strEstado) Then
    Begin
      Result.pAdicionarErro('Inscrição estadual (' + fonteDados.fDadosGerais.strIES +') ' +
        'inválida para o estado (' + fonteDados.fDadosGerais.strEstado + ')!', Nil);
    End;
  End;

  If (Not fEmptyStr(fonteDados.fDadosGerais.strTelefone)) And
     (Length(fonteDados.fDadosGerais.strTelefone) < 10) And
     (Not objConfigInterna.blnEmiEnt) Then
  Begin
    Result.pAdicionarErro('O Telefone do '+strTitCliFor+' não está preenchido corretamente (' + fonteDados.fDadosGerais.strTelefone + ')!', Nil);
  End;

  If fNotaFiscalServicosEletronicaDef(fonteDados) And
     fEmptyStr(fonteDados.fDadosGerais.strEmail) And
     (Not objConfigInterna.blnEmiEnt) Then
  Begin
    Result.pAdicionarErro('O E-mail NFe do '+strTitCliFor+' não está preenchido!', Nil);
  End;

  If blnVersao310 Then
  Begin
    pValidaEmailDestinatario(fonteDados.fDadosGerais.strEmail, Result);

    If (fEmptyStr(fonteDados.fDadosGerais.strEmail)) And
       (Not objConfigInterna.blnEmiEnt) Then
    Begin
      Result.pAdicionarErro('O E-mail NFe do '+strTitCliFor+' não está preenchido!', Nil);
    End
    Else
    Begin
      strEmailValidar := fonteDados.fDadosGerais.strEmail;
      If Pos(';', strEmailValidar) > 0 Then
      Begin
        strEmailValidar := Copy(strEmailValidar, 1, Pos(';', strEmailValidar)-1);
      End;
      If Length(strEmailValidar) > 60 Then
      Begin
        Result.pAdicionarErro('O E-mail NFe do '+strTitCliFor+' deve conter menos de 60 caracteres!', Nil);
      End;
    End;
  End;

  If Not fEmptyStr(fonteDados.fDadosGerais.strLogradouroEndEnt) Then
  Begin
    fonteDados.fDadosGerais.strLogradouroEndEnt := fTiraCaracEspeciais(fonteDados.fDadosGerais.strLogradouroEndEnt, False);
    If ((Length(fonteDados.fDadosGerais.strLogradouroEndEnt) < 2)   Or
        (Length(fonteDados.fDadosGerais.strLogradouroEndEnt) > 60)) And
       (blnVersao310) Then
    Begin
      pLogImp('fonteDados.fDadosGerais.strLogradouroEndEnt>' + fonteDados.fDadosGerais.strLogradouroEndEnt);
      Result.pAdicionarErro('O endereço de entrega deve conter entre 2 à 60 caracteres!', Nil);
    End;
  End;

  If Not fEmptyStr(fonteDados.fDadosGerais.strBairroEndEnt) Then
  Begin
    If ((Length(fonteDados.fDadosGerais.strBairroEndEnt) < 2)   Or
        (Length(fonteDados.fDadosGerais.strBairroEndEnt) > 60)) And
        (blnVersao310) Then
    Begin
      Result.pAdicionarErro('O bairro do endereço de entrega deve conter entre 2 à 60 caracteres!', Nil);
    End;
  End;

  If Not fEmptyStr(fonteDados.fDadosGerais.strComplementoEndEnt) Then
  Begin
    If (Length(fonteDados.fDadosGerais.strComplementoEndEnt) > 60) And
       (blnVersao310) Then
    Begin
      Result.pAdicionarErro('A referência do endereço de entrega deve conter até 60 caracteres!', Nil);
    End;
  End;
end;

function TValidadorNFE.fValidaDadosEmitente(fonteDados: IFonteDados;
  resultValidacao: TResultadoValidacao): TResultadoValidacao;
begin
  Result := resultValidacao;

  If fEmptyStr(fonteDados.fDadosEmitente.strCnpj) Then
    Result.pAdicionarErro('CNPJ do Emitente está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosEmitente.strRazao) Then
    Result.pAdicionarErro('Razão Social do Emitente está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosEmitente.strEndereco) Then
    Result.pAdicionarErro('Endereço do Emitente está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosEmitente.strNumeroEnd) Then
    Result.pAdicionarErro('Número do endereço do Emitente está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosEmitente.strBairro) Then
    Result.pAdicionarErro('Bairro do Emitente está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosEmitente.strCodIbge) Then
    Result.pAdicionarErro('Código IBGE do Emitente está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosEmitente.strNomeCidade) Then
    Result.pAdicionarErro('Nome da Cidade do Emitente está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosEmitente.strEstado) Then
    Result.pAdicionarErro('Unidade Federal do Emitente está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosEmitente.strCep) Then
    Result.pAdicionarErro('CEP do Emitente está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosEmitente.strTelefone) Then
    Result.pAdicionarErro('Telefone do Emitente está em branco!', Nil);

  If fEmptyStr(fonteDados.fDadosEmitente.strIES) Then
    Result.pAdicionarErro('Inscrição Estadual do Emitente está em branco!', Nil);

  If (fonteDados.fDadosGerais.fltTotSer > 0)                      And
     (fEmptyStr(fonteDados.fDadosEmitente.strInscricaoMunicipal)) Then
  Begin
    Result.pAdicionarErro('Inscrição Municipal do Emitente está em branco!', Nil);
  End;

  If (objConfigInterna.strEmpNFSe <> 'PREFEITURA DE SERTAOZINHO') Then
  Begin
    If (fonteDados.fDadosGerais.fltTotSer > 0) And
       (fEmptyStr(fonteDados.fDadosEmitente.strCNAEFiscal)) And
       (Not fEmptyStr(fonteDados.fDadosEmitente.strInscricaoMunicipal)) Then
    Begin
      Result.pAdicionarErro('CNAE Fiscal do Emitente está em branco!', Nil);
    End;
  End;

  If (Not fEmptyStr(fonteDados.fDadosEmitente.strCodIbge)) Then
  Begin
    If (fEstadoIbge(fonteDados.fDadosEmitente.strUfIbge) <> fonteDados.fDadosEmitente.strEstado) Then
    Begin
      Result.pAdicionarErro('O Estado do emitente cadastrado no cadastro de cidades (' +
        fonteDados.fDadosEmitente.strEstado + ') está diferente do cadastro IBGE (' +
        fonteDados.fDadosEmitente.strUfIbge + ')!', Nil);
    End;
  End;

  If fNotaFiscalServicosEletronicaDef(fonteDados) And
     fEmptyStr(fonteDados.fDadosEmitente.strEmail) Then
  Begin
    Result.pAdicionarErro('O E-mail do emitente não está preenchido!', Nil);
  End;
end;

function TValidadorNFE.fValidaDadosItem(fonteDados: IFonteDados;
  resultValidacao: TResultadoValidacao): TResultadoValidacao;
  Var
    dadosItem: TDadosItem;
begin
  Result := resultValidacao;
  fonteDados.pInicio;

  While (fonteDados.fTemDados) Do
  Begin
    dadosItem := fonteDados.fProximoItem;
    Result := validadorItem.fValidaDadosItem(fonteDados, dadosItem, Result);
  End;
end;

function TValidadorNFE.fValidaDadosTransportadora(fonteDados: IFonteDados;
  resultValidacao: TResultadoValidacao): TResultadoValidacao;
begin
  Result := resultValidacao;

  If (Not fEmptyStr(fonteDados.fDadosGerais.strCgcTra)) Then
  Begin
    If (Not fValidaCnpjCpf(fonteDados.fDadosGerais.strCgcTra, fonteDados)) Then
      Result.pAdicionarErro('CNPJ / CPF (' + fonteDados.fDadosGerais.strCgcTra + ') ' +
        'da transportadora inválido!', Nil);
  End;

  If (Not fEmptyStr(fonteDados.fDadosGerais.strIesTra))           And
     (Not SameText(fonteDados.fDadosGerais.strIesTra, 'ISENTO')) Then
  Begin

    If (Not fValidaIES(fonteDados.fDadosGerais.strIesTra,
                       fonteDados.fDadosGerais.strEstTra)) Then
    Begin
      Result.pAdicionarErro('Inscrição Estadual (' + fonteDados.fDadosGerais.strIesTra + ') da ' +
        'transportadora inválida para o estado (' + fonteDados.fDadosGerais.strEstTra + ')!', Nil);
    End;

  End;
end;

function TValidadorNFE.fValidarCancelamento(
  strMotivo: String): TResultadoValidacao;
begin
  Result := TResultadoValidacao.Create;
  If (fEmptyStr(strMotivo)) Or (Length(strMotivo) < 15) Then
  Begin
    Result.pAdicionarErro('O motivo do cancelamento deve ser preenchido com no mínimo 15 caracteres!' + #13#10 +
                          'Motivo atual: ' + strMotivo + ' (' + IntToStr(Length(strMotivo)) + ').', Nil);
  End;
end;

function TValidadorNFE.fValidarEnvio(fonteDados: IFonteDados): TResultadoValidacao;
begin
  Result := TResultadoValidacao.Create;

  If fEmptyStr(objConfig.strNfeEmp) Then
  Begin
    Result.pAdicionarErro('Código da Empresa no integrador não está configurado!', Nil);
  End;

  Result := fValidaDadosEmitente(fonteDados, Result);
  Result := fValidaDadosDestinatario(fonteDados, Result);
  Result := fValidaDadosTransportadora(fonteDados, Result);
  Result := fValidaDadosItem(fonteDados, Result);
end;

procedure TValidadorNFE.pValidaEmailDestinatario(strEmails: String;
  Result: TResultadoValidacao);
  Var
    stlEmails: TStringList;
    intContador: Integer;
    strEmailPChar: {$IF Defined(VER250) Or Defined(UNIDAC)} PWideChar {$ELSE} PAnsiChar {$IFEND};
begin
  If fEmptyStr(strEmails) Then
    Exit;

  {$IF Defined(VER250) Or Defined(UNIDAC)}
    strEmailPChar := PWideChar(strEmails);
  {$ELSE}
    strEmailPChar := PAnsiChar(strEmails);
  {$IFEND};

  stlEmails := TStringList.Create;
  ExtractStrings([';'], [], strEmailPChar, stlEmails);

  For intContador := 0 To stlEmails.Count -1 Do
  Begin
    If Length(stlEmails[intContador]) > 255 Then
    Begin
      Result.pAdicionarErro('E-mail maior que 255 caracteres: ' + stlEmails[intContador], Nil);
    End;
  End;

  FreeAndNil(stlEmails);
end;

{ TNFEValidadorItem110 }

function TNFEValidadorItem110.fValidaDadosItem(fonteDados: IFonteDados; dadosItem: TDadosItem;
  resultValidacao: TResultadoValidacao): TResultadoValidacao;
begin
  Result := resultValidacao;
  
  If fEmptyStr(dadosItem.strUnidad) Then
    Result.pAdicionarErro('Unidade do item ' + dadosItem.strCodIte + ' está em branco!', Nil);

  If fUsaUniTri(dadosItem.strClaFis) And fEmptyStr(dadosItem.strUnTrib) Then
    Result.pAdicionarErro('Unidade tributável do item ' + dadosItem.strCodIte + ' está em branco!', Nil);

  If (Not fEmptyStr(dadosItem.strClaIpi)) Then
  Begin
    If (Length(dadosItem.strClaIpi) < 8) Then
    Begin
      Result.pAdicionarErro('NCM do item ' + dadosItem.strCodIte + ' deve conter 8 digitos!', Nil);
    End;
  End;
end;

{ TNFEValidadorItem200 }

function TNFEValidadorItem200.fValidaDadosItem(fonteDados: IFonteDados; dadosItem: TDadosItem;
  resultValidacao: TResultadoValidacao): TResultadoValidacao;
begin
  Result := resultValidacao;

  If fEmptyStr(dadosItem.strUnidad) Then
    Result.pAdicionarErro('Unidade do item ' + dadosItem.strCodIte + ' está em branco!', Nil);

  If fUsaUniTri(dadosItem.strClaFis) And fEmptyStr(dadosItem.strUnTrib) Then
    Result.pAdicionarErro('Unidade tributável do item ' + dadosItem.strCodIte + ' está em branco!', Nil);

  If (Not fEmptyStr(dadosItem.strClaIpi)) Then
  Begin
    If (Length(dadosItem.strClaIpi) <> 8) And (Length(dadosItem.strClaIpi) <> 2) Then
    Begin
      Result.pAdicionarErro('NCM do item ' + dadosItem.strCodIte + ' deve conter 2 ou 8 digitos!', Nil);
    End;
  End
  Else
    Result.pAdicionarErro('NCM do item ' + dadosItem.strCodIte + ' deve ser preenchido, e deve conter 2 ou 8 digitos.', Nil);

  If (dadosItem.strEniEcb = 'S') Then
  Begin
    If (fEmptyStr(dadosItem.strIndEsc)) Then
      Result.pAdicionarErro('Item [' + dadosItem.strCodIte + '] Indicador de Produção em escala relevante (deve ser "N" ou "S")', Nil);

    If (dadosItem.strIndEsc = 'N') Then
    Begin
      If (fEmptyStr(dadosItem.strCnpFab)) Then
        Result.pAdicionarErro('Informado item [' + dadosItem.strCodIte + '] "Produzido em Escala NÃO Relevante" e não informado CNPJ do Fabricante.', Nil);

      If (Not fEmptyStr(dadosItem.strCnpFab)) And (Not fValidaCnpjCpf(dadosItem.strCnpFab, fonteDados)) Then
        Result.pAdicionarErro('Informado item [' + dadosItem.strCodIte + '] "Produzido em Escala NÃO Relevante" e informado CNPJ incorreto [' + dadosItem.strCnpFab + '].', Nil);
    End;
  End;

  If fonteDados.fDadosGerais.strEspDoc = 'IF' Then
  Begin
    If Pos(RightStr(dadosItem.strCodSit, 2), '30,70') > 0 Then
      Result.pAdicionarErro('De acordo com a nota técnica 2015.002, a CST ' + dadosItem.strCodSit + ' não é mais permitida para NFC-e. Por favor, verifique com o(a) responsável pela área fiscal.', Nil);
  End;
end;

{ TNFESValidadorPainelFiscal }

function TNFESValidadorPainelFiscal.fValidaDadosItem(fonteDados: IFonteDados; dadosItem: TDadosItem;
  resultValidacao: TResultadoValidacao): TResultadoValidacao;
begin
  Result := resultValidacao;

  If fEmptyStr(dadosItem.strTriMun) Then
    Result.pAdicionarErro('Código do Serviço prestado próprio do município está em branco (' + dadosItem.strCodIte + ')!', nil);
end;

end.
