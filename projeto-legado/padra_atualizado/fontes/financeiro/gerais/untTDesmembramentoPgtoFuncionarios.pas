{******************************************************************
**REALIZE O DESMEMBRAMENTO POR PLANO DE CONTAS VINCULADO NA VERBA**
**************************************************MT**REQ:210129***}
unit untTDesmembramentoPgtoFuncionarios;

interface

uses Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Uni,
     StrUtils, Math, untFuncoesSimples, Variants,untTypesSistema,cxGridDBBandedTableView,
     cxGridCitel,untCadPag,untFuncoes,untCadVerbas;

Type

  TDesmembramentoPgtoFuncionarios = Class(TComponent)
  private
    LMovimentoMensal : TUniClientDataSet;
    LCodigoVerbas : String;
    LCodEmp : String;
    function RetornaCodigoVerbasGrid: String;
    function UtilizaRateioPorVerbas : Boolean;
    function FieldIndex(ACodVer: String): Integer;
    function ApenasNumeros(AString:String):Boolean;
  public
    LUtilizaRateioPorVerbas : Boolean;
    // Analitico
    function CriaClientRateio(AController:TcxGridDBBandedTableViewCitel;
                              ARecIdx: Integer; ACodEve: String; AVlrPgto: Double): TUniClientDataSet; Overload;
    // Sintetico
    function CriaClientRateio(AController:TcxGridDBBandedTableViewCitel;
                              ACodEve: String; AVlrPgto: Double): TUniClientDataSet; Overload;

    function VerbaSemPlanoDeContas: String;
    procedure CadastrarPlanoDeContaVerbas;
    Constructor Create(AMovMen : TUniClientDataSet; ACodEmp: String); reintroduce;
    Destructor Destroy; override;
  End;

implementation

{ TDesmembramentoPgtoFuncionarios }

function TDesmembramentoPgtoFuncionarios.ApenasNumeros(
  AString: String): Boolean;
Var
  i : Integer;
Begin
  Result := True;
  for i := Length(AString) downto 1 do
    if not CharInSet(AString[i], ['0'..'9']) then
      Exit(False);
end;

procedure TDesmembramentoPgtoFuncionarios.CadastrarPlanoDeContaVerbas;
  Var
    LCadastrar: Boolean;
    LCodVer : String;
    LCadVerbas: TfrmCadVerbas;
begin
  LCadastrar := True;

  While LCadastrar Do
  Begin
    LCodVer := VerbaSemPlanoDeContas;

    If fEmptyStr(LCodVer) Then
    Begin
      fMensagem('Aviso', 'Todas as verbas foram vinculadas a um plano de contas com sucesso! ' + #13 +
                         'Gere novamente o contas a pagar.', ['&O k']);
      LCadastrar := False;
      Continue;
    End;

    If (fMensagem('ATENÇÃO!','Para gerar o contas a pagar será necessário vincular um plano de contas na verba ' + LCodVer + '!' + #13 +
                  'Deseja vincular agora?',['&SIM','&NÃO'],2,True) = 2) Then
    Begin
      LCadastrar := False;
      Continue;
    End;

    pCriarFormularios(TfrmCadVerbas, LCadVerbas);
    LCadVerbas.LCodVer := Copy(LCodVer,1,3);
    LCadVerbas.ShowModal;
    pFreeAndNil(LCadVerbas);
  End;

end;

constructor TDesmembramentoPgtoFuncionarios.Create(AMovMen: TUniClientDataSet; ACodEmp: String);
begin
  LMovimentoMensal := TUniClientDataSet.Create(Nil);
  LMovimentoMensal.Data := AMovMen.Data;
  LCodigoVerbas := RetornaCodigoVerbasGrid;
  LCodEmp := ACodEmp;
  LUtilizaRateioPorVerbas := UtilizaRateioPorVerbas;
end;

function TDesmembramentoPgtoFuncionarios.CriaClientRateio(
  AController: TcxGridDBBandedTableViewCitel; ACodEve: String;
  AVlrPgto: Double): TUniClientDataSet;
  Var
    LCount,
    LRowIdx,
    LRecIdx : Integer;
    LCadVer : TUniQuery;
    LSql: String;
    LVlrVerba: Double;
    LPerCen: Double;
begin

  Try
    LCadVer := fCriaQuery(Nil);
    LSql :=  'SELECT                          '+
             '  *                             '+
             'FROM                            '+
             '  CADVER                        '+
             'WHERE VER_CODVER IN ('+ fRetStrToSQLIn(LCodigoVerbas,'_') +' ) '+
             '  AND VER_CODCTA IS NOT NULL    ';

    Try
      LCadVer.Close;
      LCadVer.Sql.Clear;
      LCadVer.Sql.Add(LSql);
      LCadVer.Open;

      Result := TUniClientDataSet.Create(Self);
      pCriaClientTemporariaCtpDet('', '', '', '', '', Result);
      If Not Result.Active Then Result.Open;

      LVlrVerba := 0;
      For LCount := 0 To AController.DataController.GetSelectedCount - 1 Do
      Begin
        LRowIdx := AController.DataController.GetSelectedRowIndex(LCount);
        LRecIdx := AController.Controller.SelectedRecords[LCount].RecordIndex;

        If AController.DataController.GetRowInfo(LRowIdx).Level = AController.DataController.Groups.GroupingItemCount Then
          LRecIdx := AController.DataController.GetRowInfo(LRowIdx).RecordIndex;

        If (AController.DataController.Values[LRecIdx, LMovimentoMensal.FieldCount-3] = '') And
           (AController.DataController.Values[LRecIdx, LMovimentoMensal.FieldCount-5] > 0) Then
        Begin
          LCadVer.First;

          While (Not LCadVer.Eof) Do
          Begin
            if not VarIsNull(AController.DataController.Values[LRecIdx, FieldIndex(LCadVer.FieldByName('VER_CODVER').AsString)]) then
              LVlrVerba := AController.DataController.Values[LRecIdx, FieldIndex(LCadVer.FieldByName('VER_CODVER').AsString)];

            If LVlrVerba = 0 Then
            Begin
              LCadVer.Next;
              Continue;
            End;

            LVlrVerba := IIF(LCadVer.FieldByName('VER_DEBCRE').AsString.Equals('D'),(LVlrVerba * -1),LVlrVerba);

            If Result.Locate('CTP_CODCTA', VarArrayOf([LCadVer.FieldByName('VER_CODCTA').AsString]), []) Then
            Begin

              If Result.FieldByName('CTP_DEBCRE').AsString.Equals('D') Then
                LVlrVerba := LVlrVerba + (Result.FieldByName('CTP_VALDUP').AsFloat* - 1)
              Else
                LVlrVerba := LVlrVerba + Result.FieldByName('CTP_VALDUP').AsFloat;

              Result.Edit;

              If Not Result.FieldByName('TIPOACAO').AsString.Equals('1') Then
                Result.FieldByName('TIPOACAO').AsString := '2';
             End
             Else
            Begin
              Result.Insert;
              Result.FieldByName('TIPOACAO').AsString := '1';
            End;

            Result.FieldByName('CTP_MARDES').AsString := 'D';
            Result.FieldByName('CTP_DEBCRE').AsString := IIF((LVlrVerba < 0),'D','C');
            Result.FieldByName('CTP_CODEMP').AsString := LCodEmp;
            Result.FieldByName('CTP_CODCTA').AsString := LCadVer.FieldByName('VER_CODCTA').AsString;
            Result.FieldByName('CTA_DESCTA').AsString := fRetNomeConta(LCadVer.FieldByName('VER_CODCTA').AsString);
            Result.FieldByName('CTP_CODEVE').AsString := ACodEve;

            LVlrVerba := IIF((LVlrVerba < 0),LVlrVerba * -1,LVlrVerba);
            LPerCen   := (LVlrVerba * 100) / AVlrPgto;
            LPerCen   := IIF((LPerCen < 0),(LPerCen * -1),LPerCen);

            Result.FieldByName('CTP_FATCAL').AsFloat  := LPerCen / 100;
            Result.FieldByName('CTP_VALDUP').AsFloat  := AVlrPgto * (LPerCen / 100);;

            Result.Post;
            LCadVer.Next;
          End;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LCadVer);
  End;
end;

function TDesmembramentoPgtoFuncionarios.CriaClientRateio(AController: TcxGridDBBandedTableViewCitel;
                                                          ARecIdx:Integer; ACodEve: String; AVlrPgto: Double): TUniClientDataSet;
  Var
    LCadVer : TUniQuery;
    LSql: String;
    LVlrVerba: Double;
    LPerCen: Double;
begin
  Try

    LCadVer := fCriaQuery(Nil);
    LSql :=  'SELECT                          '+
             '  *                             '+
             'FROM                            '+
             '  CADVER                        '+
             'WHERE VER_CODVER IN ('+ fRetStrToSQLIn(LCodigoVerbas,'_') +' ) '+
             '  AND VER_CODCTA IS NOT NULL    ';
    Try
      LCadVer.Close;
      LCadVer.Sql.Clear;
      LCadVer.Sql.Add(LSql);
      LCadVer.Open;

      Result := TUniClientDataSet.Create(Self);
      pCriaClientTemporariaCtpDet('', '', '', '', '', Result);

      If Not Result.Active Then
        Result.Open;

      LVlrVerba := 0;
      While (Not LCadVer.Eof) Do
      Begin
        if not VarIsNull(AController.DataController.Values[ARecIdx, FieldIndex(LCadVer.FieldByName('VER_CODVER').AsString)]) then
          LVlrVerba := AController.DataController.Values[ARecIdx, FieldIndex(LCadVer.FieldByName('VER_CODVER').AsString)];

        If LVlrVerba = 0 Then
        Begin
          LCadVer.Next;
          Continue;
        End;

        LVlrVerba := IIF(LCadVer.FieldByName('VER_DEBCRE').AsString.Equals('D'),(LVlrVerba * -1),LVlrVerba);

        If Result.Locate('CTP_CODCTA', VarArrayOf([LCadVer.FieldByName('VER_CODCTA').AsString]), []) Then
        Begin

          If Result.FieldByName('CTP_DEBCRE').AsString.Equals('D') Then
            LVlrVerba := LVlrVerba + (Result.FieldByName('CTP_VALDUP').AsFloat* - 1)
          Else
            LVlrVerba := LVlrVerba + Result.FieldByName('CTP_VALDUP').AsFloat;

          Result.Edit;

          If Not Result.FieldByName('TIPOACAO').AsString.Equals('1') Then
            Result.FieldByName('TIPOACAO').AsString := '2';
        End
        Else
        Begin
          Result.Insert;
          Result.FieldByName('TIPOACAO').AsString := '1';
        End;

        Result.FieldByName('CTP_MARDES').AsString := 'D';
        Result.FieldByName('CTP_DEBCRE').AsString := IIF((LVlrVerba < 0),'D','C');
        Result.FieldByName('CTP_CODEMP').AsString := LCodEmp;
        Result.FieldByName('CTP_CODCTA').AsString := LCadVer.FieldByName('VER_CODCTA').AsString;
        Result.FieldByName('CTA_DESCTA').AsString := fRetNomeConta(LCadVer.FieldByName('VER_CODCTA').AsString);
        Result.FieldByName('CTP_CODEVE').AsString := ACodEve;

        LVlrVerba := IIF((LVlrVerba < 0),LVlrVerba * -1,LVlrVerba);
        LPerCen   := (LVlrVerba * 100) / AVlrPgto;
        LPerCen   := IIF((LPerCen < 0),(LPerCen * -1),LPerCen);

        Result.FieldByName('CTP_FATCAL').AsFloat  := LPerCen / 100;
        Result.FieldByName('CTP_VALDUP').AsFloat  := AVlrPgto * (LPerCen / 100);;

        Result.Post;
        LCadVer.Next;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;


  Finally
    FreeAndNil(LCadVer);
  End;

end;

destructor TDesmembramentoPgtoFuncionarios.Destroy;
begin
  inherited;
end;

function TDesmembramentoPgtoFuncionarios.FieldIndex(ACodVer: String): Integer;
  Var
    LCount : Integer;
    LCodVer: String;
begin
  Result  := 0;
  LCodVer := '';
  for LCount := 0 to LMovimentoMensal.FieldDefs.Count - 1 do
  begin
    LCodVer := Copy(LMovimentoMensal.Fields[LCount].FullName,1,3);
    If ApenasNumeros(LCodVer) Then
    Begin
      If (LCodVer = ACodVer) Then
        Result := LCount;
    End;
  end;
end;

function TDesmembramentoPgtoFuncionarios.RetornaCodigoVerbasGrid: String;
  Var
    LCount : Integer;
    LCodVer: String;
begin
  Result  := '';
  LCodVer := '';
  for LCount := 0 to LMovimentoMensal.FieldDefs.Count - 1 do
  begin
    LCodVer := Copy(LMovimentoMensal.Fields[LCount].FullName,1,3);
    If ApenasNumeros(LCodVer) Then
      Result := Concat(Result,LCodVer,'_');
  end;
end;

function TDesmembramentoPgtoFuncionarios.UtilizaRateioPorVerbas: Boolean;
  Var
    LCadVer : TUniQuery;
    LSql: String;
begin
  Result := False;
  Try
    LCadVer := fCriaQuery(Nil);
    LSql :=  'SELECT                          '+
             '  *                             '+
             'FROM                            '+
             '  CADVER                        '+
             'WHERE VER_CODVER IN ('+ fRetStrToSQLIn(LCodigoVerbas,'_') +' ) '+
             '  AND VER_CODCTA IS NOT NULL    ';
    Try
      LCadVer.Close;
      LCadVer.Sql.Clear;
      LCadVer.Sql.Add(LSql);
      LCadVer.Open;

      Result := Not LCadVer.IsEmpty And (fCfgSis('DESPFU', varBoolean));;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;


  Finally
    FreeAndNil(LCadVer);
  End;

end;

function TDesmembramentoPgtoFuncionarios.VerbaSemPlanoDeContas: String;
  Var
    LCadVer : TUniQuery;
    LSql: String;
begin
  Result := '';
  Try
    LCadVer := fCriaQuery(Nil);
    LSql :=  'SELECT                          '+
             '  *                             '+
             'FROM                            '+
             '  CADVER                        '+
             'WHERE VER_CODVER IN ('+ fRetStrToSQLIn(LCodigoVerbas,'_') +' ) '+
             '  AND VER_CODCTA IS NULL       ';
    Try
      LCadVer.Close;
      LCadVer.Sql.Clear;
      LCadVer.Sql.Add(LSql);
      LCadVer.Open;
      If Not LCadVer.IsEmpty Then
        Result := Concat(LCadVer.FieldByName('VER_CODVER').AsString,' - ', LCadVer.FieldByName('VER_DESVER').AsString) ;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;


  Finally
    FreeAndNil(LCadVer);
  End;

end;

end.
