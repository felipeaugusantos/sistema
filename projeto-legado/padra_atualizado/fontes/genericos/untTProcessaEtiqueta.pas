 unit untTProcessaEtiqueta;


interface

 uses Vcl.DBCtrls, System.Classes, StdCtrls, strUtils, SysUtils, untFuncoesSimples, Uni, Forms, DB;

  Type
    TCampo = Record
      ComponentName: string;
      Valor: String;
    End;


    TProcessaEtiqueta = class
    private
      FQuery: TUniQuery;
      FForm: TForm;
      function getCampo(index: string): TCampo;
      procedure pSetInformacao(objComp: TComponent);
      function fFormataInformacao(AValue: String): string;
      function fResolveData(AValue: string): String;
      procedure AbreQuery(AIdentificador: string);

    function GetEtiquetaConfigurada: boolean;
    protected
      FEtiqueta: String;
    public
      constructor Create(AIdentificador: string; AForm: TForm = nil);
      Destructor Destroy;override;
      procedure pLeEtiqueta(AEtiqueta: string; blnPreencherCampos: Boolean = False);
      procedure pPreencheCampos;
      property Campo[index: string]: TCampo read getCampo;
      property blnEtiquetaIdentificada: boolean read GetEtiquetaConfigurada;
      procedure SetIdentificador(AIdentificador: string; AForm: TForm = nil);
   End;


implementation

uses Vcl.Mask;


{ TProcessaEtiqueta }

procedure TProcessaEtiqueta.AbreQuery(AIdentificador: string);
begin
  FQuery.SQL.Add('SELECT QUE_CODIGO,');   //Auto incremento
  FQuery.SQL.Add('       QUE_IDENTI,');   // Campo de Agrupamento identificação da Etiqueta
  FQuery.SQL.Add('       QUE_CAMPO_,');   //Campo da Leitura
  FQuery.SQL.Add('       QUE_POSINI,');   //Posiçao Inicial do Campo
  FQuery.SQL.Add('       QUE_POSFIN,');   //Posição final do campo
  FQuery.SQL.Add('       QUE_COMPON,');   //Componente de Destino
  {Sempre verificar ao definir um tipo se a classe ja comporta todas}
  FQuery.SQL.Add('       QUE_TIPINF,');   //Tipo de Campo, escrita defautl de tipos ex: string, date, integer, float
  FQuery.SQL.Add('       QUE_FORMLE,');   //Forma que esta na etiqueta : Data Formatada YYMMDD, não usar separador
  FQuery.SQL.Add('       QUE_FORMAT');    //Forma que deve ser escrita : Data: Formatada para YY/MM/DDDD
  FQuery.SQL.Add('  FROM ETIQUE');
  FQuery.SQL.Add(' WHERE QUE_IDENTI = ' + QuotedStr(UpperCase(AIdentificador)));
  FQuery.SQL.Add(' ORDER BY QUE_POSINI');
  FQuery.Open;
end;

constructor TProcessaEtiqueta.Create(AIdentificador: string; AForm: TForm = nil);
begin
  FQuery := fCriaQuery;
  SetIdentificador(AIdentificador, AForm);
end;

destructor TProcessaEtiqueta.Destroy;
begin
  FreeAndNil(FQuery);
end;

function TProcessaEtiqueta.getCampo(index: string): TCampo;
begin
  If FQuery.FieldByName('QUE_CAMPO_').AsString <> index Then
  Begin
    FQuery.First;
    If Not FQuery.Locate('QUE_CAMPO_', index, []) Then
      Exit;
  End;

  Result.ComponentName := FQuery.FieldByName('QUE_COMPON').AsString;
  Result.Valor := fFormataInformacao(Copy(FEtiqueta,
                       FQuery.FieldByName('QUE_POSINI').AsInteger,
                       FQuery.FieldByName('QUE_POSFIN').AsInteger - (FQuery.FieldByName('QUE_POSINI').AsInteger - 1)));
end;

function TProcessaEtiqueta.GetEtiquetaConfigurada: boolean;
begin
  Result := Not FQuery.IsEmpty;
end;

procedure TProcessaEtiqueta.pLeEtiqueta(AEtiqueta: string; blnPreencherCampos: Boolean = False);
begin
  If (FEtiqueta = AEtiqueta) And (Not((blnPreencherCampos) And Assigned(FForm))) Then
    exit;
  FEtiqueta := AEtiqueta;

  If (blnPreencherCampos) And Assigned(FForm) Then
    pPreencheCampos;
end;


function TProcessaEtiqueta.fFormataInformacao(AValue: string): string;
var defVal: Double;
begin
  Result := AValue;
  If AValue = '' Then
    Exit;

  If UpperCase(Trim(FQuery.FieldByName('QUE_TIPINF').AsString)) = 'STRING' Then
    Exit
  Else If (UpperCase(Trim(FQuery.FieldByName('QUE_TIPINF').AsString)) = 'FLOAT') Or
          (UpperCase(Trim(FQuery.FieldByName('QUE_TIPINF').AsString)) = 'INTEGER') Then
  Begin
    defVal := fStrToFloat(Result, 0);
    Result := FormatFloat(FQuery.FieldByName('QUE_FORMAT').AsString, defVal);
  End
  Else If (UpperCase(Trim(FQuery.FieldByName('QUE_TIPINF').AsString)) = 'DATE') Then
    Result := fResolveData(Result);
end;


function TProcessaEtiqueta.fResolveData(AValue: string): String;
var formaOriginal,
    sMes,
    sAno,
    sDia: string;
    i: integer;
    dtaDef: TDateTime;

begin
  If AValue = '' Then
    Exit;
  formaOriginal := UpperCase(FQuery.FieldByName('QUE_FORMLE').AsString);
  For i := 0 To Length(formaOriginal) Do
  Begin
    If formaOriginal[i] = 'Y' Then
      sAno := sAno + AValue[i]
    Else If formaOriginal[i] = 'M' Then
      sMes := sMes + AValue[i]
    Else If formaOriginal[i] = 'D' Then
      sDia := sDia + AValue[i];
  End;

  Result := sDia+'/'+sMes+'/'+sAno;
  TryStrToDate(Result, dtaDef);

  Result :=  FormatDateTime(FQuery.FieldByName('QUE_FORMAT').AsString, dtaDef);
end;

procedure TProcessaEtiqueta.pSetInformacao(objComp: TComponent);
var
  strValue: String;
Begin

  strValue := getCampo(FQuery.FieldByName('QUE_CAMPO_').AsString).Valor;
  If strValue = '' Then
    Exit;
  If objComp is TEdit Then
    TEdit(objComp).Text := strValue
  Else If objComp is TDBEdit Then
  Begin
    If TDBEdit(objComp).DataSource.DataSet.State in dsEditModes Then
      TDBEdit(objComp).Field.Value := strValue;
  End
  Else If objComp is TMaskEdit Then
    TMaskEdit(objComp).Text := strValue;
End;

procedure TProcessaEtiqueta.SetIdentificador(AIdentificador: string;
  AForm: TForm);
begin
  FForm := AForm;
  If AIdentificador <> '' Then
    AbreQuery(AIdentificador);
end;

procedure TProcessaEtiqueta.pPreencheCampos;
var objComp: TComponent;
begin
  FQuery.First;
  If FEtiqueta = '' Then
    Exit;
  While not FQuery.Eof Do
  Begin
    If FQuery.FieldByName('QUE_COMPON').AsString <> '' Then
    Begin
      objComp := FForm.FindComponent(FQuery.FieldByName('QUE_COMPON').AsString);
      If Assigned(objComp) Then
        pSetInformacao(objComp);
    End;
    FQuery.Next;
  End;
end;

end.
