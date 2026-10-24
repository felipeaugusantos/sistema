{*
   Unit Auxiliar do Motor de escrita/leitura de layouts.
   Autor: Guilherme Borges de Freitas.
*}

unit untRTTILayout;

interface

uses Uni, RTTI, System.SysUtils, Data.DB, untFuncoesSimples;

Type
  TAlinhamento = (alEsquerda, alDireita);

  ILayout = Interface
  ['{85581A24-9644-420B-82A8-3A8EC57FB937}']
    function fGetSql : String;
    function fGetArquivoNome : String;
    procedure pSetParams(DataSet : TUniQuery);
  End;

  TCampoString = class(TCustomAttribute)
  strict private
    FAlinhamento : TAlinhamento;
    FTamanho     : Integer;
    FCompletar   : String;
  public
    constructor Create(Alinhamento : TAlinhamento; Tamanho : Integer; CompletarCom : String); Overload;
    constructor Create; Overload;
    function Formatar(DataSet : TDataSet; NomCampo : String) : String;overload;
    function Formatar(strValue: String):String;overload;

  end;


  TCampoInteger = class(TCustomAttribute)
  strict private
    FAlinhamento : TAlinhamento;
    FTamanho     : Integer;
    FCompletar   : String;
  public
    constructor Create(Alinhamento : TAlinhamento; Tamanho : Integer; CompletarCom : String); Overload;
    constructor Create; Overload;
    function Formatar(DataSet : TDataSet; NomCampo : String) : String;Overload;
    function Formatar(intValue: Integer; blnNull : Boolean):String;Overload;

  end;


  TCampoDateTime = class(TCustomAttribute)
  strict private
    FFormato : String;
  public
    constructor Create(Formato : String); overload;
    constructor Create; overload;
    function Formatar(DataSet : TDataSet; NomCampo : String) : String;Overload;
    function Formatar(dtaValue: TDateTime; blnNull : Boolean):String;Overload;

  end;


  TCampoDouble = class(TCustomAttribute)
  strict private
    FAlinhamento : TAlinhamento;
    FFormato     : String;
    FTamanho     : Integer;
    FCompletar   : String;
    FDecimalSep  : Char;
  public
    constructor Create(Alinhamento : TAlinhamento; Formato: String;
                       Tamanho : Integer; CompletarCom : String;
                       DecimalSeparator : Char); overload;
    constructor Create; overload;
    function Formatar(DataSet : TDataSet; NomCampo : String) : String;Overload;
    function Formatar(fltValue:Double; blnNull : Boolean):String;Overload;

  end;

  TNomeCampo = class(TCustomAttribute)
    strict private
      FCamNom : String;
    public
      constructor Create(strCamNom : String);
      property NomCam : String Read FCamNom;
  end;


  TDelimitador = class(TCustomAttribute)
  strict private
    FDelimitador : Char;
  public
    constructor Create(Delimitador : Char);
    Property Delimitador : Char Read FDelimitador;
  end;

  TReplaceDelimitadorToVazio = class(TCustomAttribute);

  TTipoLayoutOpc = (Importar, Exportar);

  TTipoLayout = class(TCustomAttribute)
  strict private
    FopcTipo : TTipoLayoutOpc;
  public
    constructor Create(opcTipo : TTipoLayoutOpc);
    Property opcTipo : TTipoLayoutOpc Read FopcTipo;
  end;


  {$M+}
  TLayout = Class(TInterfacedObject, ILayout )
  Public
    qryDados : TUniQuery;
    function fGetSql : String; virtual; Abstract;
    function fGetArquivoNome : String; virtual; Abstract;
    procedure pSetParams(DataSet : TUniQuery); virtual; Abstract;
    procedure Assign(objLayout : TLayout);
  End;
  {$M-}

  TLayoutClass = Class of TLayout;

implementation

{ TNomeCampo }

constructor TNomeCampo.Create(strCamNom: String);
begin
  FCamNom := strCamNom;
end;

{ TCampoString }

constructor TCampoString.Create(Alinhamento: TAlinhamento; Tamanho: Integer;
  CompletarCom: String);
begin
  FAlinhamento := Alinhamento;
  FTamanho     := Tamanho;
  FCompletar   := CompletarCom;
end;

constructor TCampoString.Create;
begin
  FAlinhamento := alEsquerda;
  FTamanho     := 0;
  FCompletar   := '';
end;

function TCampoString.Formatar(strValue: String): String;
begin
  if (FTamanho > 0) And (FCompletar <> EmptyStr) Then
  Begin
    Case FAlinhamento Of
      alEsquerda: Result := fPadR(strValue, FTamanho, FCompletar );
      alDireita : Result := fPadL(strValue, FTamanho, FCompletar );
    End;
  End
  Else
  Begin
    if (FTamanho > 0) Then
      Result := Copy(strValue,1, FTamanho)
    Else
      Result := strValue;
  End;
end;

function TCampoString.Formatar(DataSet: TDataSet; NomCampo: String): String;
begin
  if (FTamanho > 0) And (FCompletar <> EmptyStr) Then
  Begin
    Case FAlinhamento Of
      alEsquerda: Result := fPadR(DataSet.FieldByName(NomCampo).AsString, FTamanho, FCompletar );
      alDireita : Result := fPadL(DataSet.FieldByName(NomCampo).AsString, FTamanho, FCompletar );
    End;
  End
  Else
  Begin
    if (FTamanho > 0) Then
      Result := Copy(DataSet.FieldByName(NomCampo).AsString,1, FTamanho)
    Else
      Result := DataSet.FieldByName(NomCampo).AsString;
  End;
end;

{ TCampoInteger }

constructor TCampoInteger.Create(Alinhamento: TAlinhamento; Tamanho: Integer;
  CompletarCom: String);
begin
  FAlinhamento := Alinhamento;
  FTamanho     := Tamanho;
  FCompletar   := CompletarCom;
end;

constructor TCampoInteger.Create;
begin
  FAlinhamento := alEsquerda;
  FTamanho     := 0;
  FCompletar   := '';
end;

function TCampoInteger.Formatar(intValue: Integer; blnNull : Boolean): String;
begin
  if (FTamanho > 0) And (FCompletar <> EmptyStr) Then
  Begin
    Case FAlinhamento Of
      alEsquerda: Result := fPadR( IIF(blnNull,'', IntToStr( intValue )), FTamanho, FCompletar );
      alDireita : Result := fPadL( IIF(blnNull,'', IntToStr( intValue )), FTamanho, FCompletar );
    End;
  End
  Else
  Begin
    if (FTamanho > 0) Then
      Result := Copy( IIF(blnNull,'', IntToStr( intValue )), 1, FTamanho)
    Else
      Result := IIF(blnNull,'', IntToStr( intValue ));
  End;

end;

function TCampoInteger.Formatar(DataSet: TDataSet; NomCampo: String): String;
  Var
    intValue : Integer;
begin
  If DataSet.FieldByName(NomCampo) Is TIntegerField Then
    intValue := DataSet.FieldByName(NomCampo).AsInteger
  Else
    intValue := StrToIntDef(DataSet.FieldByName(NomCampo).AsString, 0);

  if (FTamanho > 0) And (FCompletar <> EmptyStr) Then
  Begin
    Case FAlinhamento Of
      alEsquerda: Result := fPadR( IntToStr( intValue ), FTamanho, FCompletar );
      alDireita : Result := fPadL( IntToStr( intValue ), FTamanho, FCompletar );
    End;
  End
  Else
  Begin
    if (FTamanho > 0) Then
      Result := Copy( IntToStr( intValue ),1, FTamanho)
    Else
      Result := IntToStr( intValue );
  End;

end;

{ TCampoDateTime }

constructor TCampoDateTime.Create(Formato: String);
begin
  FFormato := Formato;
end;

constructor TCampoDateTime.Create;
begin
  FFormato := 'yyyy-mm-dd';
end;

function TCampoDateTime.Formatar(dtaValue: TDateTime; blnNull : Boolean): String;
begin
  if blnNull Then
    Result := ''
  Else
    Result := FormatDateTime(FFormato, dtaValue);
end;

function TCampoDateTime.Formatar(DataSet: TDataSet; NomCampo: String): String;
begin
  Result := FormatDateTime(FFormato, DataSet.FieldByName(NomCampo).AsDateTime);
end;

{ TCampoDouble }

constructor TCampoDouble.Create(Alinhamento: TAlinhamento; Formato: String;
  Tamanho: Integer; CompletarCom: String; DecimalSeparator: Char);
begin
  FAlinhamento := Alinhamento;
  FFormato     := Formato;
  FTamanho     := Tamanho;
  FCompletar   := CompletarCom;
  FDecimalSep  := DecimalSeparator;
end;

constructor TCampoDouble.Create;
begin
  FAlinhamento := alDireita;
  FFormato     := '#0.00';
  FTamanho     := 0;
  FCompletar   := '0';
  FDecimalSep  := '.';
end;

function TCampoDouble.Formatar(fltValue: Double; blnNull : Boolean): String;
  Var
    OldDecSep : Char;
begin
  OldDecSep := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator:= FDecimalSep;

  If (FTamanho > 0) And (FCompletar <> EmptyStr) Then
  Begin
    Case FAlinhamento Of
      alEsquerda: Result := fPadR( IIF(blnNull,'', FormatFloat(FFormato, fltValue)), FTamanho, FCompletar );
      alDireita : Result := fPadL( IIF(blnNull,'', FormatFloat(FFormato, fltValue)), FTamanho, FCompletar );
    End;
  End
  Else
    Result := IIF(blnNull,'', FormatFloat(FFormato, fltValue));

  FormatSettings.DecimalSeparator:= OldDecSep;
end;


function TCampoDouble.Formatar(DataSet: TDataSet; NomCampo: String): String;
  Var
    OldDecSep : Char;
begin
  OldDecSep := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator:= FDecimalSep;

  If (FTamanho > 0) And (FCompletar <> EmptyStr) Then
  Begin

    If DataSet.FieldByName(NomCampo).IsNull Then
      Result := ''
    Else
    Begin
      Case FAlinhamento Of
        alEsquerda: Result := fPadR( FormatFloat(FFormato, DataSet.FieldByName(NomCampo).AsFloat), FTamanho, FCompletar );
        alDireita : Result := fPadL( FormatFloat(FFormato, DataSet.FieldByName(NomCampo).AsFloat), FTamanho, FCompletar );
      End;
    End;
  End
  Else
  If DataSet.FieldByName(NomCampo).IsNull Then
    Result := ''
  Else
    Result := FormatFloat(FFormato, DataSet.FieldByName(NomCampo).AsFloat);

  FormatSettings.DecimalSeparator:= OldDecSep;
end;

{ TDelimitador }

constructor TDelimitador.Create(Delimitador: Char);
begin
  FDelimitador := Delimitador;
end;

{ TTipoLayout }

constructor TTipoLayout.Create(opcTipo: TTipoLayoutOpc);
begin
  FopcTipo := opcTipo;
end;

{ TLayout }

procedure TLayout.Assign(objLayout: TLayout);
  Var
    _Context  : TRttiContext;
    _Type     : TRttiType;
    _Property : TRttiProperty;
begin
  If Self.ClassName <> objLayout.ClassName Then
    Raise Exception.Create('Associação não permitida para classes de outro tipo!');

  _Context := TRttiContext.Create;
  _Type    := _Context.GetType(Self.ClassType);

  For _Property in _Type.GetDeclaredProperties Do
  Begin
    _Property.SetValue(Self, _Property.GetValue(objLayout) );
  End;

  _Type.Free;
  _Context.Free;

end;

end.
