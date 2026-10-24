unit untTLiberacaoValorBoleto;

interface
uses
  untTypesSistema;

Type
  TRecParametrosLiberacaoValorBoleto = Record
    strNumDoc: String;
    strSerDoc: String;
    strCodFor: String;
    strNomFor: String;
    strCodOpe: String;
    strCodDig: String;

    fltValorRetencoes: Double;
    fltValorDocumento: Double;
    fltTotAdiantamento: Double;
    fltValorContabil: Double;
    fltBonificacao: Double;

    blnAcessoViaPreNota: Boolean;
    arrDuplicata: TarrDuplicataPointer;
    constructor Create(pstrNumDoc, pstrSerDoc: String);
    procedure pInicializar;
  end;

Type
  TLiberacaoValorBoleto = Class
  private
    fltTotDocumento,
    fltTotBoletos,
    fltTotDuplicatas: Double;
    RecParametrosLiberacaoValorBoleto: TRecParametrosLiberacaoValorBoleto;
    function fTotalBoleto: Double;
    function fTotalDuplicatas: Double;
    function fLiberarValorBoleto: Boolean;overload;
  protected
    procedure SetRecParametrosLiberacaoValorBoleto(Value: TRecParametrosLiberacaoValorBoleto);

  public
    class function fLiberarValorBoleto(recParametrosLiberacaoValorBoleto: TRecParametrosLiberacaoValorBoleto):Boolean;overload;
  end;

implementation

uses
  untLiberacao, System.SysUtils, untFuncoesSimples, Math;
{ TLiberacaoValorBoleto }

function TLiberacaoValorBoleto.fLiberarValorBoleto: Boolean;
Var
  objLiberacao: TLiberacao;
  intCont: Integer;
  strLin: String;
Begin

  Result := fltTotBoletos > 0;
  Result := Not (Result and (RoundTo(fltTotBoletos,-2) <> RoundTo(recParametrosLiberacaoValorBoleto.fltValorDocumento -
                                                                   recParametrosLiberacaoValorBoleto.fltValorRetencoes,-2)));

  if Result then
    Exit;

  objLiberacao := TLiberacao.Create;
  Try

      If RecParametrosLiberacaoValorBoleto.fltBonificacao > 0 Then
        objLiberacao.objMsgLibera.pAddTexto('VALOR DOS BOLETOS FIFERENTE DO VALOR CONTABIL DA NOTA FISCAL, DEVIDO A ITENS BONIFICADOS')
      Else
        objLiberacao.objMsgLibera.pAddTexto('VALOR DOS BOLETOS DIFERENTE DO VALOR CONTABIL DA NOTA FISCAL');

      objLiberacao.objMsgLibera.pAddSeparador(65);

      objLiberacao.objMsgLibera.pAddTextoCaption('Documento:'  ,
                                                 RecParametrosLiberacaoValorBoleto.strNumDoc + 'NF' +
                                                 RecParametrosLiberacaoValorBoleto.strSerDoc, 20);
      objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor:' ,
                                                  RecParametrosLiberacaoValorBoleto.strCodFor + '-' +
                                                  RecParametrosLiberacaoValorBoleto.strNomFor, 13);
      objLiberacao.objMsgLibera.pAddSeparador(65);

      objLiberacao.objMsgLibera.pAddTextoCaption('Vr.Contabil:' ,
                                                 FormatFloat('#,##0.00',
                                                             RecParametrosLiberacaoValorBoleto.fltValorDocumento) , 13);
      objLiberacao.objMsgLibera.pAddTextoCaption('Soma das Parcelas :',
                                                 FormatFloat('#,##0.00',
                                                             Self.fltTotDuplicatas) , 13);

      If RecParametrosLiberacaoValorBoleto.fltBonificacao > 0 Then
        objLiberacao.objMsgLibera.pAddTextoCaption('Soma dos Itens Bonificados:',
                                                   FormatFloat('#,##0.00',
                                                               RecParametrosLiberacaoValorBoleto.fltBonificacao) , 26);

      If RecParametrosLiberacaoValorBoleto.fltTotAdiantamento > 0 Then
        objLiberacao.objMsgLibera.pAddTextoCaption('Total de Adiantamento:',
                                                   FormatFloat('#,##0.00',
                                                               RecParametrosLiberacaoValorBoleto.fltTotAdiantamento) , 13);
      objLiberacao.objMsgLibera.pAddSeparador(65);
      objLiberacao.objMsgLibera.pAddTextoCaption('Parcelas:'  ,'' ,10);

      If Assigned(RecParametrosLiberacaoValorBoleto.ArrDuplicata) Then
      Begin
        For intCont := 0 To High(RecParametrosLiberacaoValorBoleto.ArrDuplicata^) Do
        Begin
          if fEmptyStr(RecParametrosLiberacaoValorBoleto.ArrDuplicata[intCont].dtaDtaVen) Then
            Break;

          strLin := FormatDateTime('dd/mm/yyyy', StrToDate(RecParametrosLiberacaoValorBoleto.ArrDuplicata[intCont].dtaDtaVen)) + ' ' +
          fPadL(FormatFloat('#,##0.00', RecParametrosLiberacaoValorBoleto.ArrDuplicata[intCont].curValor),10);

          objLiberacao.objMsgLibera.pAddTextoCaption(strLin ,'' ,65);
          strLin := '';
        End;
      End;

      objLiberacao.objMsgLibera.pAddTextoCaption(strLin ,'' ,65);
      objLiberacao.strDirAce := 'LBRBOL';
      objLiberacao.strMsgSen := 'VALOR DOS BOLETOS DIFERENTE DO VALOR CONTABIL DA NOTA FISCAL s';
      objLiberacao.strCodOpe := RecParametrosLiberacaoValorBoleto.strCodOpe;
      objLiberacao.strCodDig := RecParametrosLiberacaoValorBoleto.strCodDig;
      Result :=  objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

class function TLiberacaoValorBoleto.fLiberarValorBoleto(
  recParametrosLiberacaoValorBoleto: TRecParametrosLiberacaoValorBoleto): Boolean;
  Var
    objLiberacaoValorBoleto: TLiberacaoValorBoleto;

begin
  objLiberacaoValorBoleto := Nil;
  Try
    objLiberacaoValorBoleto := TLiberacaoValorBoleto.Create;
    objLiberacaoValorBoleto.SetRecParametrosLiberacaoValorBoleto(recParametrosLiberacaoValorBoleto);
    Result := objLiberacaoValorBoleto.fLiberarValorBoleto;
  Finally
    if Assigned(objLiberacaoValorBoleto) then
      FreeAndNil(objLiberacaoValorBoleto);
  End;
end;

function TLiberacaoValorBoleto.fTotalBoleto: Double;
begin
  Result := fltTotDuplicatas + RecParametrosLiberacaoValorBoleto.fltTotAdiantamento;
end;

function TLiberacaoValorBoleto.fTotalDuplicatas: Double;
Var
  intContador: integer;
Begin
  Result := 0;

  If Not Assigned(RecParametrosLiberacaoValorBoleto.ArrDuplicata) Then
    Raise Exception.Create('Duplicatas nao informadas para a liberacao de valor de boleto. ' +
                           'Documento ' + RecParametrosLiberacaoValorBoleto.strNumDoc +
                           ' serie ' + RecParametrosLiberacaoValorBoleto.strSerDoc + '.');

  For intContador := 0 To High(RecParametrosLiberacaoValorBoleto.ArrDuplicata^) Do
    Result := Result + RecParametrosLiberacaoValorBoleto.ArrDuplicata[intContador].curValor;
end;

procedure TLiberacaoValorBoleto.SetRecParametrosLiberacaoValorBoleto(
  Value: TRecParametrosLiberacaoValorBoleto);
begin
  RecParametrosLiberacaoValorBoleto := Value;
  fltTotDuplicatas := fTotalDuplicatas;
  fltTotBoletos := fTotalBoleto;

  if RecParametrosLiberacaoValorBoleto.blnAcessoViaPreNota then
    fltTotDocumento := RecParametrosLiberacaoValorBoleto.fltValorContabil
  else
    fltTotDocumento := RecParametrosLiberacaoValorBoleto.fltValorDocumento;
end;

{ TRecParametrosLiberacaoValorBoleto }

constructor TRecParametrosLiberacaoValorBoleto.Create(pstrNumDoc,
  pstrSerDoc: String);
begin
  pInicializar;
  strNumDoc := pstrNumDoc;
  strSerDoc := pstrSerDoc;
end;

procedure TRecParametrosLiberacaoValorBoleto.pInicializar;
begin
  strNumDoc := EmptyStr;
  strSerDoc := EmptyStr;
  strCodFor := EmptyStr;
  strNomFor := EmptyStr;
  strCodOpe := EmptyStr;
  strCodDig := EmptyStr;

  fltValorDocumento := 0;
  fltTotAdiantamento := 0;
  fltValorContabil := 0;
  fltValorRetencoes := 0;
  blnAcessoViaPreNota := False;
  arrDuplicata := nil;
end;

end.

