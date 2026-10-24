{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Kresil *}
{**********************************************************************PH*}
unit untGravandoExecucaoKresilBases;

interface

uses
  untAbstractGravandoExecucaoKresil, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoKresilBases = class(TAbstractGravandoExecucaoKresil)
  Private
    function fRetTotalUnidade(strEmbalagem: String): Integer;
    function fRetUnidade(strEmbalagem: String; intEmb: Integer; intTotalEmb: Integer): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet; intEmb, intTotEmb: Integer); Override;
    function IsRegistroExiste(const qryOrigem: TDataSet; qryDestino: IDataSet; intEmb, intTotEmb: Integer): Boolean; Override;

  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoKresilBases }

procedure TGravandoExecucaoKresilBases.Executar(const gravando: IGravando);
Var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
  intContador: Integer;
  intEmb, intTotEmb: Integer;
begin
  For intContador := 0 To stlPath.Count - 1 Do
  Begin
    Try
      Try
        Gravando.Texto := 'Verificando Path do arquivo...';

        If Not fValidarPath(intContador) Then
        Begin
          Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
          Exit;
        End;

        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := 'Path verificado com sucesso...';
        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('KRE_CADBAS');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        If (Gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := 'Carregando Dados...';

        CarregarDados(Gravando, qryOrigem, fGetPath(intContador), qryDestino);

        Gravando.Texto := Format('Processando Arquivos: [%s]', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);
        qryOrigem.First;

        While (Not qryOrigem.Eof) Do
        Begin
          Try
            Try
              If (Gravando.Status <> sgGravando) Then
                Break;

              intTotEmb := fRetTotalUnidade(qryOrigem.FieldByName('EMBALAGEM_D').AsString);

              For intEmb := 1 To intTotEmb Do
              Begin
                If Not IsRegistroExiste(qryOrigem, qryDestino, intEmb, intTotEmb) Then
                  GravarRegistro(qryOrigem, qryDestino, intEmb, intTotEmb);
              End;

            Except
              On E: Exception Do
              Begin
                Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
              End;
            End;
          Finally
            qryOrigem.Next;
            Gravando.RegistrarProgresso(0,  qryOrigem.RecNo, qryOrigem.RecordCount);
          End;
        End;


      Except
        On E: Exception Do
        Begin
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;
      End;
    Finally
      If Assigned(qryOrigem) Then
        FreeAndNil(qryOrigem);
    End;
  End;
end;

function TGravandoExecucaoKresilBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoKresilBases.fRetTotalUnidade(
  strEmbalagem: String): Integer;
begin
  Result := 1;

  If strEmbalagem = 'BALDE' Then
    Result := 2
  Else If strEmbalagem = 'QUARTO;GALAO;BALDE' Then
    Result := 3
  Else If strEmbalagem = 'GALAO;BALDE' Then
    Result := 3;
end;

function TGravandoExecucaoKresilBases.fRetUnidade(strEmbalagem: String;
  intEmb: Integer; intTotalEmb: Integer): String;
begin
  Result := 'QT';

  If intTotalEmb = 3 Then
  Begin
    If intEmb = 1 Then
      Result := 'QT'
    Else If intEmb = 2 Then
      Result := 'GL'
    Else If intEmb = 3 Then
      Result := 'BD';
  End
  Else If (intTotalEmb = 2) And (strEmbalagem = 'BALDE') Then
  Begin
    If intEmb = 1 Then
      Result := 'GL'
    Else If intEmb = 2 Then
      Result := 'BD';
  End;
end;

function TGravandoExecucaoKresilBases.GetSqlDestino: string;
begin
  Result := '   SELECT * FROM KRE_CADBAS      ';
end;

function TGravandoExecucaoKresilBases.GetSqlOrigem(const strNomeArquivo: string;
  const stlTabelas: TStrings): string;
begin
  Result := '';
  Result := Result + '  SELECT DISTINCT                     ';
  Result := Result + '    [B.BASE] AS BASE,                 ';
  Result := Result + '    [B.PRODUTO] AS PRODUTO,           ';
  Result := Result + '    [B.EMBALAGEM_D] AS EMBALAGEM_D,   ';
  Result := Result + '    [B.EMBALAGEM] AS EMBALAGEM        ';
  Result := Result + '  FROM                                ';
  Result := Result + '    [Plan1$] AS B                     ';
  Result := Result + '  WHERE                               ';
  Result := Result + '    B.PRODUTO <> ""                   ';
end;

procedure TGravandoExecucaoKresilBases.GravarRegistro(const qryOrigem: TDataSet;
  qryDestino: IDataSet; intEmb, intTotEmb: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KRE_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_BASE__').AsString := qryOrigem.FieldByName('BASE').AsString;
  qryDestino.FieldByName('BAS_PRODUT').AsString := qryOrigem.FieldByName('PRODUTO').AsString;
  qryDestino.FieldByName('BAS_DESCRI').AsString := qryOrigem.FieldByName('PRODUTO').AsString;
  qryDestino.FieldByName('BAS_UNIDAD').AsString := fRetUnidade(qryOrigem.FieldByName('EMBALAGEM_D').AsString, intEmb, intTotEmb);

  If qryDestino.FieldByName('BAS_UNIDAD').AsString = 'QT' Then
    qryDestino.FieldByName('BAS_CONTEU').AsFloat := 800
  Else If qryDestino.FieldByName('BAS_UNIDAD').AsString = 'GL' Then
    qryDestino.FieldByName('BAS_CONTEU').AsFloat := 3200
  Else If qryDestino.FieldByName('BAS_UNIDAD').AsString = 'BD' Then
    qryDestino.FieldByName('BAS_CONTEU').AsFloat := 16000;

  qryDestino.Post;
end;

function TGravandoExecucaoKresilBases.IsRegistroExiste(
  const qryOrigem: TDataSet; qryDestino: IDataSet; intEmb, intTotEmb: Integer): Boolean;
begin
  Result := qryDestino.Locate('BAS_BASE__;BAS_PRODUT;BAS_UNIDAD', VarArrayOf([qryOrigem.FieldByName('BASE').AsString,
   qryOrigem.FieldByName('PRODUTO').AsString, fRetUnidade(qryOrigem.FieldByName('EMBALAGEM_D').AsString, intEmb, intTotEmb)]), []);
end;

end.
