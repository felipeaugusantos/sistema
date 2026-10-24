{******************************************************************************}
{* Classe responsável pela geração do cadastro de Bases da tinta Sparlack *}
{***************************************************************************PH*}
unit untGravandoExecucaoSparlackBases;

interface

uses
  untAbstractGravandoExecucaoSparlack, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils,System.Variants;
type
  TGravandoExecucaoSparlackBases = class(TAbstractGravandoExecucaoSparlack)

  private
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

    function fRetNomeUnidade(strCodUni : String ) : String;
    function fRetPeso(strCodUni : String ) : Double;
  end;

implementation

Uses untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoSparlackCores }

procedure TGravandoExecucaoSparlackBases.Executar(const gravando: IGravando);
var
  intCont       : Integer;
  // Bases
  DFUniProvider : TDBFUniProvider;
  DataDBFBas    : TUniConnection;
  qryCadBasDbf  : TUniQuery;
  // Produtos
  qryCadProDbf  : TUniQuery;
  // SubProdutos
  qryCadSubProDbf : TUniQuery;
  DataDbfSubPro   : TUniConnection;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto := 'Path para a geração do arquivo de Bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SPA_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Iniciando Geração do Cadastro de Bases...';

      DFUniProvider := TDBFUniProvider.Create(Nil);

      // Bases
      DataDBFBas := TUniConnection.Create(Nil);
      DataDBFBas.ProviderName := 'DBF';
      DataDBFBas.LoginPrompt  := False;

      DataDBFBas.Database := strPath;

      If (Not DataDBFBas.Connected) Then
        DataDBFBas.Connected := True;

      qryCadBasDbf := TUniQuery.Create(Nil);
      qryCadBasDbf.Connection := DataDBFBas;

      qryCadBasDbf.Close;
      qryCadBasDbf.SQL.Text := 'SELECT * FROM \BASES.DBF ';
      qryCadBasDbf.Open;

      // Produtos
      qryCadProDbf := TUniQuery.Create(Nil);
      qryCadProDbf.Connection := DataDBFBas;

      qryCadProDbf.Close;
      qryCadProDbf.SQL.Text := 'SELECT * FROM \PRODUCTS.DBF';
      qryCadProDbf.Open;

      // Sub Produtos
      DataDBFSubPro := TUniConnection.Create(Nil);
      DataDBFSubPro.ProviderName := 'DBF';
      DataDBFSubPro.LoginPrompt  := False;

      DataDBFSubPro.Database := strPath + '\' + qryCadProDbf.FieldByName('PATH').AsString;

      If (Not DataDBFSubPro.Connected) Then
        DataDBFSubPro.Connected := True;

      qryCadSubProDbf := TUniQuery.Create(Nil);
      qryCadSubProDbf.Connection := DataDBFSubPro;

      qryCadSubProDbf.Close;
      qryCadSubProDbf.SQL.Text := 'SELECT * FROM \SUBPRODS.DBF ';
      qryCadSubProDbf.Open;


      Try
        Try
          if gravando.Status <> sgGravando then
            Exit;

          gravando.Texto := 'Iniciando processo de gravação do arquivo...';

          qryCadSubProDbf.First;

          While Not qryCadSubProDbf.Eof Do
          Begin
            qryCadBasDbf.First;

            While Not qryCadBasDbf.Eof Do
            Begin

              if gravando.Status <> sgGravando then
                Exit;

              intCont := 0;

              qryCadBas.Close;
              qryCadBas.SQL := 'SELECT * FROM SPA_CADBAS '+
                               ' WHERE BAS_CODBAS = :CODBAS '+
                               '   AND BAS_CODUNI = :CODUNI '+
                               '   AND BAS_PRODUT = :PRODUT ';
              qryCadBas.ParamByName('CODBAS').AsString := qryCadBasDbf.Fields[2].AsString;
              qryCadBas.ParamByName('CODUNI').AsString := arrUnidades[intCont];
              qryCadBas.ParamByName('PRODUT').AsString := qryCadSubProDbf.FieldByName('DESCR').AsString;
              qryCadBas.Open;

              If qryCadBas.IsEmpty Then
              Begin
                For intCont := 1 To 3 Do
                Begin
                  qryCadBas.Insert;
                  qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SPA_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
                  qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                  qryCadBas.FieldByName('BAS_CODBAS').AsString := qryCadBasDbf.Fields[2].AsString;
                  qryCadBas.FieldByName('BAS_DESCRI').AsString := qryCadBasDbf.Fields[3].AsString;
                  qryCadBas.FieldByName('BAS_CODUNI').AsString := arrUnidades[intCont];
                  qryCadBas.FieldByName('BAS_PRODUT').AsString := qryCadSubProDbf.FieldByName('DESCR').AsString;
                  qryCadBas.Post;
                End;

              End;

              gravando.RegistrarProgresso(0, qryCadBasDbf.RecNo, qryCadBasDbf.RecordCount);

              qryCadBasDbf.Next;
            End;

            qryCadSubProDbf.Next;
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
    If Assigned(DataDBFBas) Then FreeAndNil(DataDBFBas);
    If Assigned(qryCadBasDbf) Then FreeAndNil(qryCadBasDbf);
    If Assigned(DFUniProvider) Then FreeAndNil(DFUniProvider);
  End;
end;

function TGravandoExecucaoSparlackBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoSparlackBases.fRetNomeUnidade(strCodUni: String): String;
begin
  Result := 'QUARTO';

  If strCodUni =  'GL' Then
    Result := 'GALÃO'
  Else
  If strCodUni =  'BL' Then
    Result := 'BALDE';
end;

function TGravandoExecucaoSparlackBases.fRetPeso(strCodUni: String): Double;
begin
  Result := 810;

  If strCodUni = 'GL' Then
    Result := 3240
  else
  If strCodUni = 'BL' Then
    Result := 16200;
end;

end.

