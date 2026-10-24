{******************************************************************************}
{* Classe responsável pela geração do cadastro de Cores da tinta Sparlack *}
{***************************************************************************PH*}
unit untGravandoExecucaoSparlackCores;

interface

uses
  untAbstractGravandoExecucaoSparlack, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils,Data.DB;
type
  TGravandoExecucaoSparlackCores = class(TAbstractGravandoExecucaoSparlack)

  private
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

    function fRetFator(strCodUni : String) : Double;

  end;

implementation

Uses untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoSparlackCores }

procedure TGravandoExecucaoSparlackCores.Executar(const gravando: IGravando);
var
  intCont       : Integer;
  intColorantes : Integer;
  intContCodigo : Integer;
  intContQuant  : Integer;
  slColorantes  : TStringList;

  //-> Pasta de Sub Produtos
  qryCadSubDbf  : TUniQuery;
  DataDbfSubPro : TUniConnection;
  DFUniProvider : TDBFUniProvider;

  //-> Pasta de bases
  qryCadBaseDbf  : TUniQuery;
  DataDbfBasePro : TUniConnection;

  //-> Pasta Colorantes
  qryCadColDbf  : TUniQuery;
  DataDbfColPro : TUniConnection;

  //-> Pasta do arquivo de fórmulas
  qryCadCorDbf     : TUniQuery;
  DataDbfCor       : TUniConnection;
  //-> Query SPA_CADSPA
  qryCor        : IDataSet;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto := 'Path para a geração do arquivo de Cores não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SPA_CADSPA');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Iniciando Geração do Cadastro de Cores...';

      DFUniProvider := TDBFUniProvider.Create(Nil);

      DataDbfSubPro:= TUniConnection.Create(Nil);
      DataDbfSubPro.ProviderName := 'DBF';
      DataDbfSubPro.LoginPrompt  := False;

      DataDbfSubPro.Database := strPath +'\PROD0001';

      If (Not DataDbfSubPro.Connected) Then
        DataDbfSubPro.Connected := True;

      qryCadSubDbf:= TUniQuery.Create(Nil);
      qryCadSubDbf.Connection := DataDbfSubPro;

      qryCadSubDbf.Close;
      qryCadSubDbf.SQL.Text := 'SELECT * FROM \SUBPRODS.DBF ';
      qryCadSubDbf.Open;

      Try
        Try
          if gravando.Status <> sgGravando then
            Exit;

          gravando.Texto := 'Iniciando processo de gravação do arquivo...';

          // Criação da lista de colorantes
          slColorantes                 := TStringList.Create;
          slColorantes.Delimiter       := ',';
          slColorantes.StrictDelimiter := True;


          While Not qryCadSubDbf.Eof Do
          Begin
            if gravando.Status <> sgGravando then
              Exit;

            // Carregando as Cores - Inicio
            DataDbfCor:= TUniConnection.Create(Nil);
            DataDbfCor.ProviderName := 'DBF';
            DataDbfCor.LoginPrompt  := False;

            DataDbfCor.Database := strPath +'\PROD0001\'+ qryCadSubDbf.Fields[3].AsString ;

            If (Not DataDbfCor.Connected) Then
              DataDbfCor.Connected := True;

            qryCadCorDbf:= TUniQuery.Create(Nil);
            qryCadCorDbf.Connection := DataDbfCor;

            qryCadCorDbf.Close;
            qryCadCorDbf.SQL.Text := 'SELECT * FROM \FRM.DBF ';
            qryCadCorDbf.Open;

            // Carregando as bases - Inicio
            DataDbfBasePro:= TUniConnection.Create(Nil);
            DataDbfBasePro.ProviderName := 'DBF';
            DataDbfBasePro.LoginPrompt  := False;

            DataDbfBasePro.Database := strPath;

            If (Not DataDbfBasePro.Connected) Then
              DataDbfBasePro.Connected := True;

            qryCadBaseDbf:= TUniQuery.Create(Nil);
            qryCadBaseDbf.Connection := DataDbfBasePro;

            qryCadBaseDbf.Close;
            qryCadBaseDbf.SQL.Text := 'SELECT * FROM \BASES.DBF ';
            qryCadBaseDbf.Open;

            // Carregando os colorantes

            DataDbfColPro:= TUniConnection.Create(Nil);
            DataDbfColPro.ProviderName := 'DBF';
            DataDbfColPro.LoginPrompt  := False;

            DataDbfColPro.Database := strPath;

            If (Not DataDbfColPro.Connected) Then
              DataDbfColPro.Connected := True;

            qryCadColDbf:= TUniQuery.Create(Nil);
            qryCadColDbf.Connection := DataDbfBasePro;

            qryCadCorDbf.First;

            qryCor := TAutcomTintaFactory.Get.fGetDataSet;

            While Not qryCadCorDbf.Eof Do
            Begin
              For intCont := 1 To  3 Do
              Begin
                qryCor.SQL := 'SELECT * '+
                              '  FROM SPA_CADSPA '+
                              ' WHERE SPA_CODSPA = :CODSPA '+
                              '   AND SPA_CODUNI = :CODUNI '+
                              '   AND SPA_PRODUT = :PRODUT ';

                qryCor.ParambyName('CODSPA').AsString := qryCadCorDbf.Fields[1].AsString;
                qryCor.ParambyName('PRODUT').AsString := qryCadSubDbf.Fields[2].AsString;
                qryCor.ParambyName('CODUNI').AsString := arrUnidades[intCont];

                qryCor.Open;

                If qryCor.IsEmpty Then
                Begin
                  qryCor.Insert;
                  qryCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SPA_CADSPA', TAutcomTintaFactory.Get.GetCodEmp);
                  qryCor.FieldByName('SPA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                  qryCor.FieldByName('SPA_DTACAD').AsDate   := date;
                  qryCor.FieldByName('SPA_CODSPA').AsString := qryCadCorDbf.Fields[1].AsString;
                  qryCor.FieldByName('SPA_CODUNI').AsString := arrUnidades[intCont];
                  qryCor.FieldByName('SPA_PRODUT').AsString := qryCadSubDbf.Fields[2].AsString;
                  qryCor.FieldByName('SPA_REFERE').AsString := qryCadCorDbf.Fields[1].AsString;

                  qryCor.FieldByName('SPA_DESCRI').AsString := qryCadCorDbf.Fields[1].AsString + ' ' +
                                                               qryCadSubDbf.Fields[2].AsString + ' ' +
                                                               arrUnidades[intCont];

                  If qryCadBaseDbf.Locate('ID',qryCadCorDbf.FieldByName('BASE_ID').AsString ,[]) Then
                    qryCor.FieldByName('SPA_CODBAS').AsString := qryCadBaseDbf.fields[2].AsString;

                  slColorantes.DelimitedText := qryCadCorDbf.FieldByName('FORMULA').AsString;

                  intContCodigo := 1;
                  intContQuant  := 1;

                  for intColorantes := 1 To slColorantes.Count Do
                  Begin
                    if Odd(intColorantes)Then // Código
                    Begin
                      qryCadColDbf.Close;
                      qryCadColDbf.SQL.Text := 'SELECT CODE '+
                                               '  FROM \CNTS.DBF '+
                                               ' WHERE TRIM(ID) = :ID ';
                      qryCadColDbf.ParamByName('ID').AsString := Trim(slColorantes[intColorantes-1]);
                      qryCadColDbf.Open;

                      qryCor.FieldByName('SPA_CODC'+ TStrUtils.fStrZero(intContCodigo, 2)).AsString := qryCadColDbf.fieldByName('CODE').AsString;
                      Inc(intContCodigo);
                    End
                    Else
                    Begin
                      qryCor.FieldByName('SPA_QTDC'+ TStrUtils.fStrZero(intContQuant, 2)).AsFloat  :=
                        TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(slColorantes[intColorantes-1], '.', ',')) * fRetFator(arrUnidades[intCont]);

                      Inc(intContQuant);
                    End;
                  End;

                  qryCor.FieldByName('SPA_MD5KEY').AsString := GetMD5(qryCor.FieldByName('SPA_CODSPA').AsString +
                                                                      qryCor.FieldByName('SPA_DESCRI').AsString +
                                                                      qryCor.FieldByName('SPA_PRODUT').AsString +
                                                                      qryCor.FieldByName('SPA_CODBAS').AsString +
                                                                      qryCor.FieldByName('SPA_CODUNI').AsString );
                  qryCor.Post;
                End;
              End;

              gravando.RegistrarProgresso(0, qryCadCorDbf.RecNo, qryCadCorDbf.RecordCount);

              qryCadCorDbf.Next;
            End;
            qryCadSubDbf.Next;
          End;
        Except
          on E: Exception do
          begin
            gravando.Cancelar;
            gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
          End;
        End;
      Finally
        gravando.Texto := 'Finalizado o processo de gravação do arquivo...';
      End;


    Except
      On E: Exception Do
      Begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(qryCadSubDbf)   Then FreeAndNil(qryCadSubDbf);
    If Assigned(DataDbfSubPro)  Then FreeAndNil(DataDbfSubPro);
    If Assigned(DFUniProvider)  Then FreeAndNil(DFUniProvider);
    If Assigned(qryCadBaseDbf)  Then FreeAndNil(qryCadBaseDbf);
    If Assigned(DataDbfBasePro) Then FreeAndNil(DataDbfBasePro);
    If Assigned(qryCadCorDbf)   Then FreeAndNil(qryCadCorDbf);
    If Assigned(DataDbfCor)     Then FreeAndNil(DataDbfCor);
    If Assigned(slColorantes)   Then FreeAndNil(slColorantes);
  End;
end;

function TGravandoExecucaoSparlackCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoSparlackCores.fRetFator(strCodUni: String): Double;
begin
  Result := 1;

  If (strCodUni = 'GL') Then
    Result := 4
  else
  If (strCodUni = 'BL') Then
    Result := 20;
end;

end.

