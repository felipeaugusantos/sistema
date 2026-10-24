unit untMesesGiro;

interface

Uses
  Classes,
  Math,
  Uni,
  untZClient,
  Controls,
  Variants,
  SysUtils,
  DB,
  untFuncoesSimples,
  untIMesesGiro,
  UniClientDataSet;

Type
  TMesAno = Record
    intMes,
    intAno: Integer;
  End;

 TMesesGiro = Class(TZClient, IMesesGiro)
    Private
      FArrMesAno: Array Of TMesAno;

      FQtdMes: Integer;
      FMarcados: Integer;
      FTestaLimite: Boolean;

      Function fSQLMeses: String;
      procedure pCriaMeses(intAnos: Integer);
      Function fRetQuantidadeMarcada: Integer;

      procedure pAfterPost(dataSet: TDataSet);
      procedure pBeforePost(dataSet: TDataSet);

      Function fGetQtdMes: Integer;
      Procedure pSetQtdMes(Value: Integer);

      Function fGetClient: TUniClientDataSet;
    Public

      constructor Create(Owner: TComponent; intAnos: Integer); Reintroduce;

      Destructor Destroy; override;

      Function fValidaMeses(intNroMes: Integer): Boolean;
      Function fRetMeses: String;
      Function fPodeMarcar: Boolean;
      Function fRetMesesNormais(intNroMes: Integer; dtaDtaBas: TDateTime): String;
      Function fSelecionaMeses(intNroMes: Integer; Var strMeses: String): Boolean;
      Function fSelecionouMesAtual: Boolean;
      Function fRetMes(intMes: Integer): Integer;
      Function fRetAno(intMes: Integer): Integer;
      Function fStrMes(intMes: Integer): String;
      Function fStrAno(intMes: Integer): String;
      Function fGetDataSource: TDataSource;

      Function fGetTestaLimite: Boolean;
      Procedure pSetTestaLimite(Value: Boolean);

      Function fGetMarcados: Integer;

      function fRetQuantidadeDias(blnConsiderarMesAtual: Boolean): Integer;

      procedure pDesmarcaTodos;
      Procedure pMarcaMeses(strMeses: String);
      Procedure pMontaDatas;
      Procedure pPost;
      Procedure pMarcaMesesIniciais;

      Property intQtdMes: Integer Read fGetQtdMes Write pSetQtdMes;
      Property intMarcados: Integer Read fGetMarcados;
      Property blnTestaLimite: Boolean Read fGetTestaLimite Write pSetTestaLimite;
      Property cdsClient: TUniClientDataSet Read fGetClient;
  End;

implementation

Uses
  DateUtils, untSelecionaMeses;

constructor TMesesGiro.Create(Owner: TComponent; intAnos: Integer);
Begin
  Inherited Create(Owner, fSQLMeses);
  pCriaMeses(intAnos);
  pAlinhaCampoCentro('VALMES');
  pAlinhaCampoCentro('VALANO');

  Self.AfterPost  := pAfterPost;
  Self.BeforePost := pBeforePost;

  FMarcados := 0;
  FTestaLimite := False;
End;

Destructor TMesesGiro.Destroy;
Begin
  Inherited;

  SetLength(FArrMesAno, 0);
End;

Function TMesesGiro.fGetQtdMes: Integer;
Begin
  Result := FQtdMes;
End;

Procedure TMesesGiro.pSetQtdMes(Value: Integer);
Begin
  FQtdMes := Value;
End;

procedure TMesesGiro.pAfterPost(dataSet: TDataSet);
Begin
  With dataSet Do
  If SameText(FieldByName('SELECI').AsString, 'S') Then
    Inc(FMarcados)
  Else
    Dec(FMarcados);
End;

procedure TMesesGiro.pBeforePost(dataSet: TDataSet);
Begin
  If FTestaLimite And SameText(dataSet.FieldByName('SELECI').AsString, 'S') And
     (Not fPodeMarcar) Then
  Begin
    dataSet.FieldByName('SELECI').AsString := 'N';
    pMensagemOk('Já foram marcados ' + IntToStr(intQtdMes) + ' meses!');
    {****************************************************}
    {*  Como vai desmarcar então incrementa em +1       *}
    {* para no momento do decremento que sera exceutado *}
    {* em TMesesGiro.pAfterPost(dataSet: TDataSet)      *}
    {* ficar com o valor correto                        *}
    {*************************************************WG*}
    FMarcados := intQtdMes + 1;
  End;
End;

procedure TMesesGiro.pDesmarcaTodos;
  Var
    intRecNo: Integer;
Begin
  DisableControls;
  intRecNo := RecNo;
  First;
  While Not Eof Do
  Begin
    Edit;
    FieldByName('SELECI').AsString := 'N';
    Post;
    Next;
  End;
  RecNo := intRecNo;
  EnableControls;
  FMarcados := 0;
End;

Function TMesesGiro.fSQLMeses: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT 99 AS VALMES, 9999 AS VALANO, "N" AS SELECI, "9999/99" AS ANOMES';
  Result := strSQL;
End;

procedure TMesesGiro.pCriaMeses(intAnos: Integer);
  Var
    intMesAtu,
    intQtdMes,
    intContador: Integer;
    dtaData: TDateTime;
Begin
  fAbreClient(True, 'TMesesGiro.pCriaMeses');
  EmptyDataSet;

  dtaData := VS_Date;

  intMesAtu := MonthOf(dtaData);
  intQtdMes := 1;

  For intContador := 1 To 12 * intAnos + 1 do
  Begin
    Append;
    FieldByName('SELECI').AsString  := 'N';
    FieldByName('VALMES').AsInteger := MonthOf(dtaData);
    FieldByName('VALANO').AsInteger := YearOf(dtaData);
    FieldByName('ANOMES').AsString  := FieldByName('VALANO').AsString + '/' +  fStrZero(FieldByName('VALMES').AsString, 2);
    Post;

    If intMesAtu = MonthOf(dtaData) Then
      Inc(intQtdMes);

    If intQtdMes > 12 Then
      Break;

    dtaData := IncMonth(dtaData, -1);
  End;
End;

Function TMesesGiro.fRetQuantidadeMarcada: Integer;
  Var
    intRecNo: Integer;
Begin
  DisableControls;
  intRecNo := RecNo;
  Filter := 'SELECI = ' + QuotedStr('S');
  Filtered :=  True;
  Result := RecordCount;
  Filtered :=  False;
  RecNo := intRecNo;
  EnableControls;
End;

Function TMesesGiro.fValidaMeses(intNroMes: Integer): Boolean;
Begin
  Result := fRetQuantidadeMarcada = intNroMes;
End;

Function TMesesGiro.fRetMeses: String;
  Var
    stlMeses: TStringList;
    stlMeses2: TStringList;
    intContador: Integer;
    intRecNo: Integer;
Begin
  stlMeses := TStringList.Create;
  stlMeses2 := TStringList.Create;

  intRecNo := RecNo;
  DisableControls;
  Filter   := 'SELECI = ' + QuotedStr('S');
  Filtered := True;
  IndexFieldNames := 'VALANO;VALMES';

  First;
  While Not Eof Do
  Begin
    stlMeses.Add(FieldByName('ANOMES').AsString);
    Next;
  End;

  For intContador := stlMeses.Count - 1 DownTo 0 Do
    stlMeses2.Add(stlMeses[intContador]);

  Result := stlMeses2.Text;

  Filtered := False;

  RecNo := intRecNo;

  EnableControls;

  FreeAndNil(stlMeses);
  FreeAndNil(stlMeses2);
End;

Function TMesesGiro.fPodeMarcar: Boolean;
Begin
  Result := FMarcados < intQtdMes;
End;

Procedure TMesesGiro.pMarcaMeses(strMeses: String);
  Var
    stlMeses: TStringList;
    intContador: Integer;
Begin
  pDesmarcaTodos;
  DisableControls;
  stlMeses := TStringList.Create;
  stlMeses.Text := strMeses;

  For intContador := 0 To stlMeses.Count - 1 Do
    If Locate('ANOMES', stlMeses[intContador], []) Then
    Begin
      Edit;
      FieldByName('SELECI').AsString  := 'S';
      Post;
    End;

  EnableControls;
  FreeAndNil(stlMeses);
End;

Function TMesesGiro.fRetMesesNormais(intNroMes: Integer; dtaDtaBas: TDateTime): String;
  Var
    dtaBaseTmp: TDateTime;
    intContador1: Integer;
    stlMeses: TStringList;
Begin
  stlMeses :=  TStringList.Create;
  Result := '';
  dtaBaseTmp := IncMonth(dtaDtaBas, -1);

  {*****************************************}
  {* GERA AS DATAS DO GIRO                 *}
  {**************************************MV*}
  For intContador1 := 0 To intNroMes -1 Do
  Begin
    stlMeses.Add(IntToStr(YearOf(dtaBaseTmp)) + '/' + fStrZero(IntToStr(MonthOf(dtaBaseTmp)), 2));
    dtaBaseTmp := IncMonth(dtaBaseTmp, -1);
  End;

  Result := stlMeses.Text;

  FreeAndNil(stlMeses);
End;

Function TMesesGiro.fSelecionaMeses(intNroMes: Integer; Var strMeses: String): Boolean;
  Var
    frmSelecionaMeses: TfrmSelecionaMeses;
Begin
  intQtdMes := intNroMes;
  pMarcaMeses(strMeses);
  pCriarFormularios(TfrmSelecionaMeses, frmSelecionaMeses);
  FTestaLimite := True;
  frmSelecionaMeses.cdsMeses := Self;
  Result := frmSelecionaMeses.ShowModal = mrOk;
  FTestaLimite := False;

  If Result Then
    strMeses := fRetMeses
  Else
    pMarcaMeses(strMeses);

  FreeAndNil(frmSelecionaMeses);
End;

Function TMesesGiro.fSelecionouMesAtual: Boolean;
Begin
  Result := False;
  DisableControls;
  Filter   := 'SELECI = ' + QuotedStr('S');
  Filtered := True;
  IndexFieldNames := 'VALANO;VALMES';

  Last;
  If Not IsEmpty Then
  Begin
    Result := (YearOf(VS_Date)  = FieldByName('VALANO').AsInteger) And
              (MonthOf(VS_Date) = FieldByName('VALMES').AsInteger);
  End;

  Filtered := False;
  EnableControls;
End;

Procedure TMesesGiro.pMontaDatas;
  Var
    intContador: Integer;
    intRecNo: Integer;
Begin
  SetLength(FArrMesAno, FQtdMes);

  DisableControls;

  intRecNo := RecNo;

  Filter   := 'SELECI = ' + QuotedStr('S');
  Filtered := True;
  IndexFieldNames := 'VALANO;VALMES';

  intContador := 0;
  First;
  While Not Eof Do
  Begin
    FArrMesAno[intContador].intMes :=  FieldByName('VALMES').AsInteger;
    FArrMesAno[intContador].intAno :=  FieldByName('VALANO').AsInteger;
    Inc(intContador);

    If intContador = FQtdMes then
      Break;

    Next;
  End;

  Filtered := False;

  RecNo := intRecNo;

  EnableControls;
End;

Function TMesesGiro.fRetMes(intMes: Integer): Integer;
Begin
  Result := FArrMesAno[Pred(intMes)].intMes;
End;

Function TMesesGiro.fRetAno(intMes: Integer): Integer;
Begin
  Result := FArrMesAno[Pred(intMes)].intAno;
End;

Function TMesesGiro.fStrMes(intMes: Integer): String;
Begin
  Result := fStrZero(fRetMes(intMes), 2);
End;

Function TMesesGiro.fStrAno(intMes: Integer): String;
Begin
  Result := IntToStr(fRetAno(intMes));
End;

Procedure TMesesGiro.pPost;
Begin
  If State = dsEdit Then
    Post;
End;

Function TMesesGiro.fGetDataSource: TDataSource;
Begin
  Result := dtsSource;
End;

function TMesesGiro.fRetQuantidadeDias(blnConsiderarMesAtual: Boolean): Integer;
  Var
    intContador: Integer;
Begin
  Result := 0;
  If blnConsiderarMesAtual then
    Result := Result + DayOfTheMonth(VS_Date) - 1;

  For intContador := 1 To FQtdMes Do
  Begin
    if (Not blnConsiderarMesAtual) And
       (YearOf(VS_Date)  = fRetAno(intContador)) And
       (MonthOf(VS_Date) = fRetMes(intContador)) Then
      Result := Result + DayOfTheMonth(VS_Date) - 1
    Else
      Result := Result + DaysInAMonth(fRetAno(intContador), fRetMes(intContador));
  End;
End;

Procedure TMesesGiro.pMarcaMesesIniciais;
  Var
    intContador: Integer;
Begin
  DisableControls;

  IndexFieldNames := 'VALANO;VALMES';

  intContador := 0;
  Last;
  Prior;
  While Not Eof Do
  Begin
    Edit;
    FieldbyName('SELECI').AsString := 'S';
    Post;

    Inc(intContador);

    If intContador = FQtdMes then
      Break;

    Prior;
  End;

  First;

  EnableControls;
End;

Function TMesesGiro.fGetClient: TUniClientDataSet;
Begin
  Result := Self;
End;

Function TMesesGiro.fGetTestaLimite: Boolean;
Begin
  Result := FTestaLimite;
End;

Procedure TMesesGiro.pSetTestaLimite(Value: Boolean);
Begin
  FTestaLimite := Value;
End;

Function TMesesGiro.fGetMarcados: Integer;
Begin
  Result := FMarcados;
End;

end.
