{*
   Unit Motor para escrita/leitura de layouts.
   Autor: Guilherme Borges de Freitas.
*}

unit untRTTIEngine;

interface

uses RTTI, untRTTILayout, untRTTISingletonCollection, System.Classes, Uni,
Vcl.StdCtrls, System.TypInfo, untFuncoesSimples, System.SysUtils, StrUtils,
Data.DB, DateUtils, System.Variants, untThreadUtils;

type

  TRTTIEngine = class(TSafeThread)
  strict private
    FMax        : Integer;
    FlblStatus  : TLabel;
    FClass      : TLayout;
    Arquivo     : TextFile;
    qryDados    : TUniQuery;
    Delimitador : String;
    FStatus     : Double;
    FTipo       : TTipoLayoutOpc;
    FUsaRTTISingletonCollection : Boolean;
    ReplaceDelimitadorToVazio : Boolean;

    procedure pSetMax(intMax : Integer);
    procedure pSetPosition(intPosition : Integer);
    procedure pSetStatus(strStatus : String);
  private
    procedure pLinhaToClass(strLinha:String);
  protected
    procedure Execute; override;
    function fRetLinha : String; virtual;
  Public
    constructor Create(classLayout : TLayout; lblStatus: TLabel; blnUsaRTTISingletonCollection : Boolean = False {Somente para Importação!!!});
    destructor Destroy; Override;

    Property fltStatus : Double Read FStatus;

  end;

implementation

{ TRTTIEngine }

constructor TRTTIEngine.Create(classLayout : TLayout; lblStatus: TLabel; blnUsaRTTISingletonCollection : Boolean = False);
  Var
    _Context  : TRttiContext;
    _Type     : TRttiType;
    _Attribute: TCustomAttribute;
begin
  inherited Create(True);
  FreeOnTerminate := False;

  FUsaRTTISingletonCollection := blnUsaRTTISingletonCollection;
  FClass          := classLayout;
  FlblStatus      := lblStatus;
  Delimitador     := '';
  ReplaceDelimitadorToVazio := False;

  _Context := TRttiContext.Create;
  _Type    := _Context.GetType(FClass.ClassType);
  For _Attribute in _Type.GetAttributes Do
  Begin
    if _Attribute Is TDelimitador then
    Begin
      Delimitador := TDelimitador(_Attribute).Delimitador;
    End

    Else
    If _Attribute Is TReplaceDelimitadorToVazio Then
    Begin
      ReplaceDelimitadorToVazio := True;
    End

    Else
    if _Attribute Is TTipoLayout then
    Begin
      FTipo := TTipoLayout(_Attribute).opcTipo;
    End;

  End;

  _Context.Free;

  If (FTipo = Exportar) Then
  Begin
    AssignFile(Arquivo, FClass.fGetArquivoNome);
    ReWrite(Arquivo);

    qryDados  := fCriaQuery(Nil);
    qryDados.SQL.Add(FClass.fGetSql);
    FClass.pSetParams(qryDados);

    pSetPosition(0);
    pSetMax(100);
    pSetStatus('Abrindo Arquivo...');

    qryDados.Open;
    pSetMax(qryDados.RecordCount);
    pSetStatus('Iniciando Exportação...');

    FClass.qryDados := Self.qryDados;
  End

  Else
  If (FTipo = Importar) Then
  Begin
    pSetPosition(0);
    pSetMax(100);
    pSetStatus('Abrindo Arquivo...');
  End;
end;

destructor TRTTIEngine.Destroy;
begin
  CloseFile(Arquivo);
  FreeAndNil(qryDados);
  FreeAndNil(FClass);
  Inherited Destroy;
end;

procedure TRTTIEngine.pSetMax(intMax: Integer);
begin
  FMax := intMax;
end;

procedure TRTTIEngine.pSetPosition(intPosition: Integer);
begin
  if intPosition > 0 then
    FStatus := intPosition / FMax * 100
  Else
    FStatus := 0;
end;

procedure TRTTIEngine.pSetStatus(strStatus: String);
begin
  if Started then
  begin
    Synchronize(
                Procedure
                Begin
                  If Assigned(FlblStatus) Then
                    FlblStatus.Caption := strStatus;
                End
    );
  end
  else If Assigned(FlblStatus) Then
    FlblStatus.Caption := strStatus;
end;

procedure TRTTIEngine.Execute;
  Var
    strLinha : String;
begin
  pLog('TRTTIEngine.Execute');
  If (FTipo = Exportar) Then
  Begin
    pSetStatus('Exportando Dados...');
    With qryDados Do
    Begin
      First;
      While Not Eof Do
      Begin
        strLinha := fRetLinha;
        WriteLn(Arquivo, strLinha);
        pSetPosition(RecNo);
        Next;
      End;
    End;
  End

  Else
  If (FTipo = Importar) Then
  Begin

    AssignFile(Arquivo, FClass.fGetArquivoNome);
    Reset(Arquivo);
    pSetStatus('Iniciando Importação...');

    pSetPosition(0);
    pSetMax(FileSize(Arquivo));

    While not Eof(Arquivo) Do
    Begin
      Readln(Arquivo, strLinha);
      pLinhaToClass(strLinha);
      pSetPosition( FilePos(Arquivo) );
    End;

  End;

  Inherited;

end;

procedure TRTTIEngine.pLinhaToClass(strLinha : String);
  Var
    _Context  : TRttiContext;
    _Type     : TRttiType;
    _Property : TRttiProperty;
    //_Attribute: TCustomAttribute;
    propInfo  : PPropInfo;

    strLinTmp : String;
    strValue  : String;

  function fEmptyStrLocal(strString : String) : Boolean;
  begin
    Result := False;
    strString := AnsiReplaceStr(strString, #10, '');
    strString := AnsiReplaceStr(strString, #13, '');
    If AnsiReplaceText(strString, ' ', '') = '' Then
      Result := True;
  end;

Begin
  strLinTmp := strLinha;

  {***********************************************************************}
  {* QUANDO A CLASSE DE IMPORTAÇÃO TEM DELIMITADOR, ENTÃO É IMPORTADO*****}
  {* NA ORDEM DAS PROPRIEDADES PROCURANDO SEMPRE PELO PROXIMO DELIMITADOR*}
  {***********************************************************************}
  If Not fEmptyStrLocal(Delimitador) Then
  Begin
    _Context := TRttiContext.Create;
    _Type    := _Context.GetType(FClass.ClassType);

    For _Property in _Type.GetDeclaredProperties Do
    Begin
      If Pos(Delimitador, strLinTmp) > 0 then
      Begin
        strValue  := Copy(strLinTmp, 1, Pos(Delimitador, strLinTmp) -1);
        strLinTmp := Copy(strLinTmp, Pos(Delimitador, strLinTmp) +1, Length(strLinTmp) );
      End
      Else
      Begin
        strValue  := Copy(strLinTmp, 1, Length(strLinTmp) );
        strLinTmp := '';
      End;

      propInfo := GetPropInfo(FClass, _Property.Name);
      Case propInfo^.PropType^.Kind Of
        tkString ,
        tkUString,
        tkWString,
        tkLString: SetPropValue(FClass, _Property.Name,  strValue );

        tkInt64: SetPropValue(FClass, _Property.Name,  StrToInt64Def(Trim(strValue),0) );
        tkInteger: SetPropValue(FClass, _Property.Name,  StrToIntDef(trim(strValue),0) );

        tkFloat  : Begin
                     If (Pos('/', Trim(strValue)) > 0) or (Pos('-', Trim(strValue)) > 0) Then
                     Begin
                       If (Pos('/', Trim(strValue)) = 5) or (Pos('-', Trim(strValue)) = 5) Then
                         strValue := Copy(Trim(strValue),9,2)+ '/' + Copy(Trim(strValue),6,2) + '/'+ Copy(Trim(strValue),1,4);

                       SetPropValue(FClass, _Property.Name,  StrToDateDef(Trim(strValue),0) );

                     End
                     Else
                       SetPropValue(FClass, _Property.Name,  fStrToFloat(ReplaceStr( strValue, '.', ',' )) );
                   End;

        Else       SetPropValue(FClass, _Property.Name, strValue );

      End;

    End;

    If FUsaRTTISingletonCollection Then
      TRTTISingletonCollection.Instance.pAdd( FClass );

    _Context.Free;

  End;


End;

function TRTTIEngine.fRetLinha: String;
  Var
    strLinha  : String;
    strAuxili : Variant;

    blnNull   : Boolean;
    strNomCam : String;
    Campo     : TCustomAttribute;

    _Context  : TRttiContext;
    _Type     : TRttiType;
    _Property : TRttiProperty;
    _Attribute: TCustomAttribute;
begin
  strLinha := '';
  _Context := TRttiContext.Create;
  _Type    := _Context.GetType(FClass.ClassType);

  For _Property in _Type.GetDeclaredProperties Do
  Begin
    blnNull   := False;
    strNomCam := '';
    Campo     := Nil;

    For _Attribute in _Property.GetAttributes Do
    Begin
      if _Attribute Is TNomeCampo then
      Begin
        strNomCam := TNomeCampo(_Attribute).NomCam;
      End;

      if (_Attribute Is TCampoString) Or
         (_Attribute Is TCampoInteger) Or
         (_Attribute Is TCampoDateTime) Or
         (_Attribute Is TCampoDouble) Then
      Begin
        Campo := _Attribute;
      End;

    End;

    Try
      If (not fEmptyStr(strNomCam)) And (Not qryDados.FieldByName(strNomCam).IsNull) Then
      Begin
        blnNull := False;
        If ReplaceDelimitadorToVazio And (Campo Is TCampoString) Then
        Begin
          strAuxili := qryDados.FieldByName(strNomCam).Value;
          strAuxili := ReplaceStr( varToStr(strAuxili), Delimitador, '');
          SetPropValue(FClass, _Property.Name, strAuxili);
        End
        Else
        Begin
          Try
            SetPropValue(FClass, _Property.Name, qryDados.FieldByName(strNomCam).Value)
          Except
            On E: Exception Do
            Begin
              Raise Exception.Create('SetPropValue('+_Property.Name+', '+qryDados.FieldByName(strNomCam).AsString+') - ' + E.Message);
            End;
          End;
        End;
      End
      Else
      Begin
        // Quando não tem o nome do campo, então é valor fixo determinado no get da propriedade;
        If (not fEmptyStr(strNomCam)) Then
          blnNull := True;

        If Campo Is TCampoString Then
          SetPropValue(FClass, _Property.Name, '')
        Else
          SetPropValue(FClass, _Property.Name, 0);
      End;

      If Campo Is TCampoString Then
        strLinha := strLinha + TCampoString(Campo).Formatar( GetPropValue(FClass, _Property.Name) ) + Delimitador
      Else
      If Campo Is TCampoInteger Then
         strLinha := strLinha + TCampoInteger(Campo).Formatar( GetPropValue(FClass, _Property.Name ), blnNull ) + Delimitador
      Else
      If Campo Is TCampoDateTime Then
        strLinha := strLinha + TCampoDateTime(Campo).Formatar( GetPropValue(FClass, _Property.Name), blnNull ) + Delimitador
      Else
      If Campo Is TCampoDouble Then
        strLinha := strLinha + TCampoDouble(Campo).Formatar( GetPropValue(FClass, _Property.Name), blnNull ) + Delimitador;

{
     Esse modelo foi abandonado por inqto, pois utilizando o modelo acima, é possivel criar eventos utilizando
     os gets e sets das propriedades, permitindo tratar os campos caso necessário.
     a Principio foi feito assim para suprir a necessidade de tirar os caracteres especiais (formatação) dos
     campos de CNPJ, porem alem dessa caso, agora é possível fazer uma infinidade de tratamento.

     Nas classes Destinadas as notaçoes de campos, não foi descontinuado o metodo formatar antigo, caso necessario
     utilizar a maneira anterior, pode ser criado uma nova notação para forçar a utilização anterior, porem acredito
     não ter tal necessidade, de qualquer forma vou deixar o codigo comentado.
     Guilherme.


     If Campo Is TCampoString Then
        strLinha := strLinha + TCampoString(Campo).Formatar(qryDados, strNomCam) + Delimitador
      Else
      If Campo Is TCampoInteger Then
         strLinha := strLinha + TCampoInteger(Campo).Formatar(qryDados, strNomCam) + Delimitador
      Else
      If Campo Is TCampoDateTime Then
        strLinha := strLinha + TCampoDateTime(Campo).Formatar(qryDados, strNomCam) + Delimitador
      Else
      If Campo Is TCampoDouble Then
        strLinha := strLinha + TCampoDouble(Campo).Formatar(qryDados, strNomCam) + Delimitador;
 }
     Except
       On E : Exception Do
         pMensagensErro(e.Message,'TRTTIEngine.fRetLinha');
     End;


  End;
  Result := strLinha;

  _Context.Free;

end;

end.
