{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Sparlack *}
{***************************************************************************PH*}
unit untGravandoExecucaoSparlackColorantes;

interface

uses
  untAbstractGravandoExecucaoSparlack, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils;
type
  TGravandoExecucaoSparlackColorantes = class(TAbstractGravandoExecucaoSparlack)

  private
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

Uses untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoSparlackCores }

procedure TGravandoExecucaoSparlackColorantes.Executar(const gravando: IGravando);
var
  qryCadColDbf  : TUniQuery;
  DataDBFCol    : TUniConnection;
  DFUniProvider : TDBFUniProvider;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto := 'Path para a geração do arquivo de colorantes não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SPA_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Iniciando Geração do Cadastro de Colorantes...';

      DFUniProvider := TDBFUniProvider.Create(Nil);

      DataDBFCol := TUniConnection.Create(Nil);
      DataDBFCol.ProviderName := 'DBF';
      DataDBFCol.LoginPrompt  := False;

      DataDBFCol.Database := strPath;

      If (Not DataDBFCol.Connected) Then
        DataDBFCol.Connected := True;

      qryCadColDbf := TUniQuery.Create(Nil);
      qryCadColDbf.Connection := DataDBFCol;

      qryCadColDbf.Close;
      qryCadColDbf.SQL.Text := 'SELECT * FROM \CNTS.DBF ';
      qryCadColDbf.Open;

      Try
        Try
          if gravando.Status <> sgGravando then
            Exit;

          gravando.Texto := 'Iniciando processo de gravação do arquivo...';

          While Not qryCadColDbf.Eof Do
          Begin

            if gravando.Status <> sgGravando then
              Exit;

            If Not qryCadCol.Locate('COL_CODCOL', qryCadColDbf.Fields[2].AsString , []) Then
            Begin

              qryCadCol.Insert;

              qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SPA_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadCol.FieldByName('COL_CODCOL').AsString := qryCadColDbf.Fields[2].AsString;
              qryCadCol.FieldByName('COL_DESCRI').AsString := qryCadColDbf.Fields[3].AsString;

              If Pos(qryCadCol.FieldByName('COL_CODCOL').AsString, '844-0453_844-0550') > 0 Then
                qryCadCol.FieldByName('COL_EMBALA').AsFloat := 3785
              Else
                qryCadCol.FieldByName('COL_EMBALA').AsFloat  := 946;

              qryCadCol.Post;
            End;

            gravando.RegistrarProgresso(0, qryCadColDbf.RecNo, qryCadColDbf.RecordCount);

            qryCadColDbf.Next;
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
    If Assigned(DataDBFCol) Then FreeAndNil(DataDBFCol);
    If Assigned(qryCadColDbf) Then FreeAndNil(qryCadColDbf);
    If Assigned(DFUniProvider) Then FreeAndNil(DFUniProvider);
  End;
end;

function TGravandoExecucaoSparlackColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

end.

