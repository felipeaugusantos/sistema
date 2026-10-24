unit untGravandoExecucaoResicolor2Cores;

interface

uses
  untAbstractGravandoExecucaoResicolor2, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  PostgreSQLUniProvider, StrUtils,System.Variants, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Forms,
  Vcl.Graphics, Windows;

type
  TGravandoExecucaoResicolor2Cores = class(TAbstractGravandoExecucaoResicolor2)
  Private
    FDatabase : String;
    FUser_Name: String;
    FPassword : String;
    FPort     : String;
    FServer   : String;
    FDriverID : String;
    FQryGen   : TUniQuery;
    FDDatabase  : TFDConnection;
    FDDriverLink: TFDPhysMySQLDriverLink;
    FDCursor    : TFDGUIxWaitCursor;
    FQryCores   : TFDQuery;
    function fRetUnidade(AEmbalagem : Double): String;
    function fInsertCores(): String;
    Procedure DeletarRegistros;
    function fRetFatorUnidade(AEmbalagemPadrao: Double; AEmbalagemNova: Double): Double;
    Procedure pIniciarQuerys;
  Protected
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils;

{ TGravandoExecucaoResicolor2Cores }


procedure TGravandoExecucaoResicolor2Cores.DeletarRegistros;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM RS2_CADRS2  ';
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoResicolor2Cores.Executar(const gravando: IGravando);
Var
  LQryBases     : IDataSet;
  LPlanilha     : OleVariant;
  LSheet        : OleVariant;
  LRecordCount  : Integer;
  LLinha        : Integer;
  LFator        : Double;
  LContador,
  LColorante,
  LQuantidade  : Integer;
  LMd5Key      : String;
  LCountReg    : Integer;
begin
  Gravando.Texto := 'Validando Path de Arquivos ...';

  If Not FileExists(fGetPath) Then
  Begin
    Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath, '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Deletando registros da tabela RS2_CADRS2...';
  DeletarRegistros;
  Gravando.Texto := 'Registros deletados com sucesso...';

  Gravando.Texto := 'Path verificado com sucesso...';
  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('RS2_CADRS2');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  LQryBases := TAutcomTintaFactory.Get.fGetDataSet;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    Try
      LPlanilha := CreateOleObject('Excel.Application');
      LPlanilha.WorkBooks.open(fGetPath);
      LSheet:= LPlanilha.Workbooks[1].WorkSheets[3];
      gravando.Texto := 'Iniciando a importação do arquivo...';

      LRecordCount := LSheet.Cells.SpecialCells(11).Row;
      LLinha := 2;

      pIniciarQuerys;

      While (LLinha <= LRecordCount) Do
      Begin
        If gravando.Status <> sgGravando Then
          Break;

        LQryBases.Close;
        LQryBases.SQL :=  ' SELECT * FROM RS2_CADBAS WHERE    ';
        LQryBases.SQL := LQryBases.SQL + '  BAS_CODBAS = :CODBAS AND  ';
        LQryBases.SQL := LQryBases.SQL + '  BAS_PRODUT = :PRODUT      ';
        LQryBases.ParamByName('CODBAS').AsString := LSheet.Cells[LLinha, 8].Text;
        LQryBases.ParamByName('PRODUT').AsString := LSheet.Cells[LLinha, 6].Text;
        LQryBases.Open;
        LQryBases.First;

        FQryCores.Params.ClearValues();
        FQryCores.Params.ArraySize := LQryBases.RecordCount;
        LCountReg := 0;

        While Not LQryBases.Eof Do
        Begin
          FQryCores.ParamByName('AUTOINCREM').AsStrings[LQryBases.RecNo - 1] := TAutcomTintaFactory.Get.fRetAutoIncrem('RS2_CADRS2', TAutcomTintaFactory.Get.GetCodEmp);
          FQryCores.ParamByName('RS2_CODEMP').AsStrings[LQryBases.RecNo - 1] := TAutcomTintaFactory.Get.GetCodEmp;
          FQryCores.ParamByName('RS2_CODIGO').AsStrings[LQryBases.RecNo - 1] := LSheet.Cells[LLinha, 9].Text;
          FQryCores.ParamByName('RS2_NOMCOR').AsStrings[LQryBases.RecNo - 1] := LSheet.Cells[LLinha, 10].Text;
          FQryCores.ParamByName('RS2_COLECA').AsStrings[LQryBases.RecNo - 1] := LSheet.Cells[LLinha, 2].Text;
          FQryCores.ParamByName('RS2_CODBAS').AsStrings[LQryBases.RecNo - 1] := LSheet.Cells[LLinha, 8].Text;
          FQryCores.ParamByName('RS2_PRODUT').AsStrings[LQryBases.RecNo - 1] := LSheet.Cells[LLinha, 6].Text;
          FQryCores.ParamByName('RS2_OBSERV').AsStrings[LQryBases.RecNo - 1] := LSheet.Cells[LLinha, 27].Text;
          FQryCores.ParamByName('RS2_EMBALA').AsFloats[LQryBases.RecNo - 1] :=  LQryBases.FieldByName('BAS_EMBALA').AsFloat;
          FQryCores.ParamByName('RS2_UNIDAD').AsStrings[LQryBases.RecNo - 1] := fRetUnidade(LQryBases.FieldByName('BAS_EMBALA').AsFloat);
          FQryCores.ParamByName('RS2_ATIVAD').AsStrings[LQryBases.RecNo - 1] := 'S';

          LMd5Key := FQryCores.ParamByName('RS2_CODIGO').AsStrings[LQryBases.RecNo - 1] +
                     FQryCores.ParamByName('RS2_NOMCOR').AsStrings[LQryBases.RecNo - 1] +
                     FQryCores.ParamByName('RS2_COLECA').AsStrings[LQryBases.RecNo - 1] +
                     FQryCores.ParamByName('RS2_CODBAS').AsStrings[LQryBases.RecNo - 1] +
                     FQryCores.ParamByName('RS2_PRODUT').AsStrings[LQryBases.RecNo - 1] +
                     FQryCores.ParamByName('RS2_OBSERV').AsStrings[LQryBases.RecNo - 1] +
                     FQryCores.ParamByName('RS2_EMBALA').AsStrings[LQryBases.RecNo - 1] +
                     FQryCores.ParamByName('RS2_UNIDAD').AsStrings[LQryBases.RecNo - 1];


          LFator := fRetFatorUnidade(StrToFloat(LSheet.Cells[LLinha, 11].Text), LQryBases.FieldByName('BAS_EMBALA').AsFloat);
          LColorante := 12;
          LQuantidade := 13;

          For LContador := 1 To 6 Do
          Begin
            If TStrUtils.fEmptyStr(LSheet.Cells[LLinha, LColorante].Text) Then
            Begin
              FQryCores.ParamByName('RS2_FORM' + TStrUtils.fStrZero(LContador, 2)).AsStrings[LQryBases.RecNo - 1] := '';
              FQryCores.ParamByName('RS2_QTDC' + TStrUtils.fStrZero(LContador, 2)).AsFloats[LQryBases.RecNo - 1] := 0.0;
            End
            Else
            Begin
              FQryCores.ParamByName('RS2_FORM' + TStrUtils.fStrZero(LContador, 2)).AsStrings[LQryBases.RecNo - 1] := LSheet.Cells[LLinha, LColorante].Text;
              FQryCores.ParamByName('RS2_QTDC' + TStrUtils.fStrZero(LContador, 2)).AsFloats[LQryBases.RecNo - 1] := StrToFloat(LSheet.Cells[LLinha, LQuantidade].Text) * LFator;
            End;

            LMd5Key := LMd5Key +  FQryCores.ParamByName('RS2_FORM' + TStrUtils.fStrZero(LContador, 2)).AsStrings[LQryBases.RecNo - 1] +
                                  FQryCores.ParamByName('RS2_QTDC' + TStrUtils.fStrZero(LContador, 2)).AsStrings[LQryBases.RecNo - 1];

            Inc(LColorante, 2);
            Inc(LQuantidade, 2);
          End;

          FQryCores.ParamByName('RS2_MD5KEY').AsStrings[LQryBases.RecNo - 1] := GetMD5(LMd5Key);
          LQryBases.Next;
          Inc(LCountReg, 1);
        End;

        FQryCores.Execute(LCountReg, 0);
        Inc(LLinha);
        gravando.RegistrarProgresso(0, LLinha, LRecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Gravando.Cancelar;
      End;
    End;
  Finally
    LPlanilha.Quit;
    LPlanilha := Unassigned;
    LSheet := Unassigned;
    FreeAndNil(FQryCores);
    FreeAndNil(FDDatabase);
    FreeAndNil(FDCursor);
    FreeAndNil(FDDriverLink);
  End;
end;


function TGravandoExecucaoResicolor2Cores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoResicolor2Cores.fInsertCores: String;
Var
  LContador: Integer;
begin
  Result := ' INSERT INTO RS2_CADRS2(       ';
  Result := Result + '  AUTOINCREM,         ';
  Result := Result + '  RS2_CODEMP,         ';
  Result := Result + '  RS2_COLECA,         ';
  Result := Result + '  RS2_PRODUT,         ';
  Result := Result + '  RS2_CODBAS,         ';
  Result := Result + '  RS2_UNIDAD,         ';
  Result := Result + '  RS2_EMBALA,         ';
  Result := Result + '  RS2_CODIGO,         ';
  Result := Result + '  RS2_NOMCOR,         ';
  Result := Result + '  RS2_OBSERV,         ';
  Result := Result + '  RS2_MD5KEY,         ';

  For LContador := 1 To 6 Do
  Begin
    Result := Result + '  RS2_FORM' + TStrUtils.fStrZero(LContador, 2) + ', ';
    Result := Result + '  RS2_QTDC' + TStrUtils.fStrZero(LContador, 2) + ', ';
  End;

  Result := Result + '  RS2_ATIVAD)         ';
  Result := Result + ' VALUES(             ';
  Result := Result + '  :AUTOINCREM,         ';
  Result := Result + '  :RS2_CODEMP,         ';
  Result := Result + '  :RS2_COLECA,         ';
  Result := Result + '  :RS2_PRODUT,         ';
  Result := Result + '  :RS2_CODBAS,         ';
  Result := Result + '  :RS2_UNIDAD,         ';
  Result := Result + '  :RS2_EMBALA,         ';
  Result := Result + '  :RS2_CODIGO,         ';
  Result := Result + '  :RS2_NOMCOR,         ';
  Result := Result + '  :RS2_OBSERV,         ';
  Result := Result + '  :RS2_MD5KEY,         ';

  For LContador := 1 To 6 Do
  Begin
    Result := Result + '  :RS2_FORM' + TStrUtils.fStrZero(LContador, 2) + ', ';
    Result := Result + '  :RS2_QTDC' + TStrUtils.fStrZero(LContador, 2) + ', ';
  End;

  Result := Result + '  :RS2_ATIVAD)         ';
end;

function TGravandoExecucaoResicolor2Cores.fRetFatorUnidade(AEmbalagemPadrao: Double; AEmbalagemNova: Double): Double;
begin
  Result := AEmbalagemNova / AEmbalagemPadrao;
end;

function TGravandoExecucaoResicolor2Cores.fRetUnidade(AEmbalagem : Double): String;
begin
  If AEmbalagem < 1500 Then
    Result := 'LT'
  Else If (AEmbalagem >= 1500) And (AEmbalagem <= 5000) Then
    Result := 'GL'
  Else If AEmbalagem > 5000 Then
    Result := 'LA';
end;


procedure TGravandoExecucaoResicolor2Cores.pIniciarQuerys;
begin
  FQryGen := TAutcomTintaFactory.Get.fCriaQuery();

  FDriverID  := 'DriverID=MySQL';
  FDatabase  := 'Database=' + FQryGen.Connection.Database;
  FUser_Name := 'User_Name=' + FQryGen.Connection.Username;
  FPassword  := 'Password=' + FQryGen.Connection.Password;
  FPort      := 'Port=' + IntToStr(FQryGen.Connection.Port);
  FServer    := 'Server=' + FQryGen.Connection.Server;

  FreeAndNil(FQryGen);

  FDDatabase   := TFDConnection.Create(Nil);
  FDDriverLink := TFDPhysMySQLDriverLink.Create(Nil);
  FDCursor     := TFDGUIxWaitCursor.Create(Nil);
  FQryCores     := TFDQuery.Create(Nil);

  FDDatabase.Params.Add(FDatabase);
  FDDatabase.Params.Add(FUser_Name);
  FDDatabase.Params.Add(FPassword);
  FDDatabase.Params.Add(FPort);
  FDDatabase.Params.Add(FServer);
  FDDatabase.Params.Add(FDriverID);

  if FileExists(ExtractFilePath(Application.ExeName) + 'libmysql57.dll') then
    FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql57.dll'
  else
    FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql41.dll';

  FDDatabase.Connected := True;

  FQryCores.Connection := FDDatabase;
  FQryCores.SQL.Text   :=  fInsertCores;
end;

end.

