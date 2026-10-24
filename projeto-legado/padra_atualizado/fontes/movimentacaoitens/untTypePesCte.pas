unit untTypePesCte;

interface

uses Rtti, TypInfo,
      StrUtils, SysUtils, Uni, Db, Classes, Forms, UniClientDataSet, Math,
      untFuncoesSimples, StdCtrls, untZClient, Variants, untTypesSistema,
      untEntOutrasDespesas, untParCalculaPrecoCusto, cxProgressBar,untPesqAux,
      untEntIcmsAntecipado, Windows, XMLDoc, XMLIntf, ComCtrls,
      Generics.Collections, untPortadorFornecedor;

  Type
  TTipoPessoa = (tpessRemetente, tpessEmitente, tpessExpedidor, tpessRecebedor, tpessDestinatario, tpessTomador);
  TTipoDocumentoAnexoCTE = (tdNotaCompra, tdNotaVenda, tdNotaDevolucaoVenda, tdNotaDevolucaoCompra);
  TPessoaCTE = Record
    strCNPJ: string;
    strRAZAO_SOCIAL: string;
    strINSCRICAO_ESTADUAL: string;
    strUF: string;
    xFant: String;
    xLgr: string;
    xNro: string;
    xBairro: string;
    cMun: string;
    xMun: string;
    strCEP: string;
    strMUNICIPIO: string;
    strCODIBGE: string;
    intCodTomador: Integer;
    intTipoDocumento: Integer;
    strTipoFJ: String;
    procedure StringParaPessoaCte(const AText: String);
    function  PessoaCteParaString : String;
    function fCGCProvavelCPF(const pstrCGC: String): Boolean;
  End;

Type
  TPessoaCTEHelper = record helper for TPessoaCTE
    Const
      PESSOA_FISICA: String = 'F';
      PESSOA_JURIDICA: String = 'J';
   end;

  CONST
    arrTiposNotas : Array [0..3] Of string = ('Nota de Compra', 'Nota de Venda', 'Nota de Devolução de Venda', 'Nota de Devolução de Compra');



implementation

function EscapeQuotes(const S: String) : String;
begin
    Result := StringReplace(S, '\', '\\', [rfReplaceAll]);
    Result := StringReplace(Result, '"', '\"', [rfReplaceAll]);
end;

function ParamByNameAsString(
    const Params     : String;
    const ParamName  : String;
    var   Status     : Boolean;
    const DefValue   : String) : String;
var
    I, J  : Integer;
    Ch    : Char;
begin
    Status := FALSE;
    I := 1;
    while I <= Length(Params) do begin
        J := I;
        while (I <= Length(Params)) and (Params[I] <> '=')  do
            Inc(I);
        if I > Length(Params) then begin
            Result := DefValue;
            Exit;                  // Not found
        end;
        if SameText(ParamName, Trim(Copy(Params, J, I - J))) then begin
            // Found parameter name, extract value
            Inc(I); // Skip '='
            if (I <= Length(Params)) and (Params[I] = '"') then begin
                // Value is between double quotes
                // Embedded double quotes and backslashes are prefixed
                // by backslash
                Status := TRUE;
                Result := '';
                Inc(I);        // Skip starting delimiter
                while I <= Length(Params) do begin
                    Ch := Params[I];
                    if Ch = '\' then begin
                        Inc(I);          // Skip escape character
                        if I > Length(Params) then
                            break;
                        Ch := Params[I];
                    end
                    else if Ch = '"' then
                        break;
                    Result := Result + Ch;
                    Inc(I);
                end;
            end
            else begin
                // Value is up to semicolon or end of string
                J := I;
                while (I <= Length(Params)) and (Params[I] <> ';') do
                    Inc(I);
                Result := Copy(Params, J, I - J);
                Status := TRUE;
            end;
            Exit;
        end;
        // Not good parameter name, skip to next
        Inc(I); // Skip '='
        if (I <= Length(Params)) and (Params[I] = '"') then begin
            Inc(I);        // Skip starting delimiter
            while I <= Length(Params) do begin
                Ch := Params[I];
                if Ch = '\' then begin
                    Inc(I);          // Skip escape character
                    if I > Length(Params) then
                        break;
                end
                else if Ch = '"' then
                    break;
                Inc(I);
            end;
            Inc(I);        // Skip ending delimiter
        end;
        // Param ends with ';'
        while (I <= Length(Params)) and (Params[I] <> ';')  do
            Inc(I);
        Inc(I);  // Skip semicolon
    end;
    Result := DefValue;
end;


procedure TPessoaCTE.StringParaPessoaCte(const AText: String);
  var
    Status    : Boolean;
    Value     : String;
    AValue    : TValue;
    AContext  : TRttiContext;
    ARecord   : TRttiRecordType;
    AProperty    : TRttiField;
    APropertyName  : String;
begin
  if AText = '' then
    Exit;

  AContext := TRttiContext.Create;
  try
    ARecord := AContext.GetType(TypeInfo(TPessoaCTE)).AsRecord;
    for AProperty in ARecord.GetFields do
    begin
      APropertyName := AProperty.Name;
      Value    := ParamByNameAsString(AText, APropertyName, Status, '0');
      if Status then
      begin
         try
           case AProperty.FieldType.TypeKind of
             tkInteger: begin
                          AValue := StrToInt(Value);
                          AProperty.SetValue(@Self, AValue);
                        end;
             tkUString: begin
                            AValue := Value;
                            AProperty.SetValue(@Self, AValue);
                        end;
           end;
         except
         end;
      end;
    End;
  finally
    AContext.Free;
  end;
end;


function TPessoaCTE.fCGCProvavelCPF(const pstrCGC: String): Boolean;
  Var
    lCPF: String;
begin
  //req: 268424, cliente importanto CTE com destinatário pessoa física, porém saiu com tag de CNPJ com zeros à esquerda.
  if Not (length(pstrCGC) = 14) then
    Exit(False);

  lCPF := Copy(pstrCGC,4,14);

  Result :=  pos('000', pstrCGC) = 1;
  Result := Result and fValidaCPF(lCPF);
end;


function TPessoaCTE.PessoaCteParaString: String;
  var
    AContext  : TRttiContext;
    Aproperty    : TRttiField;
    APropertyType   : TRttiRecordType;
    APropertyName  : String;
    ApropertyValue    : TValue;
begin
  Result := '';
  AContext := TRttiContext.Create;
  try
    APropertyType := AContext.GetType(TypeInfo(TPessoaCTE)).AsRecord;
    for Aproperty in APropertyType.GetFields do begin
        APropertyName := Aproperty.Name;
        ApropertyValue := Aproperty.GetValue(@Self);
        Result := Result + APropertyName + '="' + EscapeQuotes(ApropertyValue.ToString) + '";';
    end;
  finally
      AContext.Free;
  end;
end;


end.
