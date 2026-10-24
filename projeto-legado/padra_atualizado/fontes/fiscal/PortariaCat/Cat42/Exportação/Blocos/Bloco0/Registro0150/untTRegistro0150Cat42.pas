unit untTRegistro0150Cat42;

interface

uses System.Generics.Collections, System.Generics.Defaults, untTRegistroBaseCat42, untTParticipante, StrUtils, Forms;

type
  TRegistro0150 = class(TRegistroBase)
  private
    FListaParticipantes: TObjectList<TParticipante>;

    function fRetInscricaoEstadual(strEstado, strInscricaoEstadual: string): string;
    function fRetOrdenaCpfCnpj: IComparer<TParticipante>;
    function fRetIEIsentoPessoaFisica(strIE, strCPF: string): string;
  public
    procedure pGerar; override;

    property listaParticipantes: TObjectList<TParticipante> read FListaParticipantes write FListaParticipantes;
  end;

implementation

uses untFuncoes;

{ TRegistro0150Cat42 }

function TRegistro0150.fRetInscricaoEstadual(strEstado, strInscricaoEstadual: string): string;
begin
  Result := fTiraCaracEspeciais(strInscricaoEstadual, True, True, True);

  if fEmptyStr(Result) then
  begin
    if Pos(strEstado, 'BA_RJ') > 0 then
      Result := fStrZero('', 8)
    else if Pos(strEstado, 'AL_AP_AM_CE_ES_GO_MA_MS_PA_PB_PE_PI_RN_RR_SC_SE_TO') > 0 then
      Result := fStrZero('', 9)
    else if Pos(strEstado, 'PR_RS') > 0 then
      Result := fStrZero('', 10)
    else if Pos(strEstado, 'MT') > 0 then
      Result := fStrZero('', 11)
    else if Pos(strEstado, 'SP_DF') > 0 then
      Result := fStrZero('', 12)
    else if Pos(strEstado, 'AC_MG') > 0 then
      Result := fStrZero('', 13)
    else if Pos(strEstado, 'RO') > 0 then
      Result := fStrZero('', 14);
  end;

end;

function TRegistro0150.fRetIEIsentoPessoaFisica(strIE, strCPF: string): string;

  function fRetVerificaZero(strOrgao: string): Integer;
    var
      x, y: Integer;
  begin
    x:=1;
    y:=0;
    while Length(strOrgao) >= x do
    begin
      if Pos(Copy(strOrgao,x,1), '0_') > 0 then
        y:=y+1;
      Inc(x);
    end;
    Result := y;
  end;

begin
  if (not(fEmptyStr(strCPF))) then
  begin
    if Length(strIE) = fRetVerificaZero(strIE) then
      Result:= 'ISENTO';
  end
  else
  begin
    if abertura.blnEnviarIsentoParaInsEst then
    begin
      if Length(strIE) = fRetVerificaZero(strIE) then
        Result:= 'ISENTO'
      else
        Result:= strIE;
    end else
      Result:= strIE;
  end;
end;

function TRegistro0150.fRetOrdenaCpfCnpj: IComparer<TParticipante>;
  var
    criterioComparacao: TComparison<TParticipante>;
begin
  criterioComparacao := function(const L: TParticipante; const R: TParticipante): Integer
                        begin
                          if L.intCgcCpfInt > R.intCgcCpfInt then
                            Result := 1
                          else if L.intCgcCpfInt < R.intCgcCpfInt then
                            Result := -1
                          else
                            Result := 0;
                        end;

  Result := TComparer<TParticipante>.Construct(criterioComparacao);
end;

procedure TRegistro0150.pGerar;
  var
    strCnpj, strCpf, strNomeParticipante: string;
    participante: TParticipante;
begin
  inherited;

  abertura.lblOperacao.Caption := 'Gerando registro participantes...';
  abertura.progressoTela.Max := FListaParticipantes.Count;
  abertura.progressoTela.Position := 0;
  Application.ProcessMessages;

  FListaParticipantes.Sort(fRetOrdenaCpfCnpj);

  for participante in FListaParticipantes do
  begin
    if (not fEmptyStr(participante.strCgcCpf)) and (not fStringRepetida(participante.strCgcCpf)) then
    begin
      if Length(participante.strCgcCpf) >= 14 then
      begin
        {Pessoa Juridica}
        strCnpj := participante.strCgcCpf;
        strCpf := '';
      end
      else
      begin
        {Pessoa Fisica}
        strCnpj := '';
        strCpf := participante.strCgcCpf;
      end;

      strNomeParticipante := AnsiReplaceStr(
                             AnsiReplaceStr(
                             AnsiReplaceStr(
                             AnsiReplaceStr(
                             AnsiReplaceStr(
                             AnsiReplaceStr(
                             fTiraCaracEspeciais(
                             participante.strNome, False, True, True, True), 'º', ''), 'Ç', 'C'), '~', ''), 'Ø', ''), '´', ''), '°', '');

      strNomeParticipante := AnsiReplaceStr(strNomeParticipante, '?', '');
      strNomeParticipante := AnsiReplaceStr(strNomeParticipante, 'Ñ', 'N');
      strNomeParticipante := AnsiReplaceStr(strNomeParticipante, 'ñ', 'n');
      strNomeParticipante := AnsiReplaceStr(strNomeParticipante, 'ç', 'c');
      strNomeParticipante := AnsiReplaceStr(strNomeParticipante, '-', '');
      strNomeParticipante := AnsiReplaceStr(strNomeParticipante, '–', '');
      strNomeParticipante := AnsiReplaceStr(strNomeParticipante, 'ª', '');
      strNomeParticipante := AnsiReplaceStr(strNomeParticipante, 'ø', '');
      strNomeParticipante := AnsiReplaceStr(strNomeParticipante, '¨', '');
      strNomeParticipante := AnsiReplaceStr(strNomeParticipante, '"', '');

//'<','>','!','@','#','$','%','¨','&','*','(',')','_','+','=','{',
//'}','[',']','?',';',':',',','|','*','"','~','^','´','`','¨','æ',
//'Æ','ø','£','Ø','ƒ','ª','º','¿','®','½','¼','ß','µ','þ','ý','Ý'

      pInicializaLinha;

      pCampo(strTipoRegistro);                                                                                                          //001 Texto fixo contendo "0150"
      pCampo(participante.strCodigo);                                                                                                   //002 Código de identificação do participante no arquivo
      pCampo(strNomeParticipante);                                                                                                      //003 Nome pessoal ou empresarial do participante
      pCampo(participante.cidade.strCodPai);                                                                                            //004 Código do país do participante
      pCampo(strCnpj);                                                                                                                  //005 CNPJ do participante
      pCampo(strCpf);                                                                                                                   //006 CPF do participante
      pCampo(fRetIEIsentoPessoaFisica(fRetInscricaoEstadual(participante.cidade.strEstado, participante.strInscricaoEstadual),strCpf)); //007 Inscrição estadual do participante
      pCampo(participante.cidade.strCodigoIbge, False);                                                                                 //008 Código do município

      intQuantidadeGerada := intQuantidadeGerada + 1;

      abertura.progressoTela.StepBy(1);
      Application.ProcessMessages;

      pAdicionaLista;
    end;
  end;
end;

end.
