{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta MazaImobiliaria *}
{*******************************************************************************PH*}
unit untGravandoExecucaoMazaImobiliariaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoMazaImobiliariaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
    function fGetValEmbalagemUnidadePadrao(strUnidadePadrao: String): Double;
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
      const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoMazaImobiliariaNovasFormulas }

constructor TGravandoExecucaoMazaImobiliariaNovasFormulas.Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
  const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;


function TGravandoExecucaoMazaImobiliariaNovasFormulas.fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI = "LA" ';
end;

function TGravandoExecucaoMazaImobiliariaNovasFormulas.fGetValEmbalagemUnidadePadrao(
  strUnidadePadrao: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT * FROM MZI_CADEMB WHERE EMB_UNIDAD = :UNIDAD   ';
  qryGen.ParamByName('UNIDAD').AsString := strUnidadePadrao;
  qryGen.Open;

  Result := qryGen.FieldByName('EMB_QTDEMB').AsFloat;
end;

function TGravandoExecucaoMazaImobiliariaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoMazaImobiliariaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm     : IDataSet;
  qryCadMZI     : IDataSet;
  qryEmb        : IDataSet;
  intCont       : Integer;
  strMd5        : String;
  fltEmbPadrao  : Double;
  fltEmbNova    : Double;
  fltFator      : Double;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM MZI_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadMZI := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('MZI_CADMZI');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      While (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        qryEmb := TAutcomTintaFactory.Get.fGetDataSet;
        qryEmb.SQL := ' SELECT BAS_CODUNI '+
                      '      , EMB_QTDEMB '+
                      '   FROM MZI_CADBAS '+
                      '  INNER JOIN CADITE     ON ITE_CODITE = BAS_CODITE '+
                      '  INNER JOIN MZI_CADEMB ON EMB_UNIDAD = BAS_CODUNI '+
                      '  WHERE BAS_PRODUT  = :PRODUT '+
                      '    AND BAS_CODBAS  = :CODBAS ';


        If Not blnGerarUnidades Then
          qryEmb.SQL := qryEmb.SQL + ' AND EMB_UNIDAD = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryEmb.SQL := qryEmb.SQL + ' AND EMB_UNIDAD <> :CODUNI ';

        If TStrUtils.fEmptyStr(strCodNfm) Then
          qryEmb.SQL := qryEmb.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_CODUNI').AsString);

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryEmb.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryEmb.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryEmb.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
        qryEmb.Open;

        Try
          Try
            begin
              qryEmb.First;

              While Not qryEmb.Eof Do
              Begin
                qryCadMZI.SQL := TAutcomTintaFactory.Get.GetInsert('MZI_CADMZI');

                qryCadMZI.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('MZI_CADMZI', TAutcomTintaFactory.Get.GetCodEmp);
                qryCadMZI.ParamByName('MZI_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
                qryCadMZI.ParamByName('MZI_CODMZI').AsString   := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
                qryCadMZI.ParamByName('MZI_COLNAM').AsString   := qryCadNfm.FieldByName('NFM_COLNAM').AsString;
                qryCadMZI.ParamByName('MZI_COLNUM').AsString   := qryCadNfm.FieldByName('NFM_COLNUM').AsString;
                qryCadMZI.ParamByName('MZI_PRODUT').AsString   := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
                qryCadMZI.ParamByName('MZI_CODUNI').AsString   := qryEmb.FieldByName('BAS_CODUNI').AsString;
                qryCadMZI.ParamByName('MZI_CODBAS').AsString   := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
                qryCadMZI.ParamByName('MZI_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
                qryCadMZI.ParamByName('MZI_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
                qryCadMZI.ParamByName('MZI_ACRMOB').AsFloat    := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

                fltEmbPadrao := fGetValEmbalagemUnidadePadrao(qryCadNfm.FieldByName('NFM_CODUNI').AsString);
                fltEmbNova   := fGetValEmbalagemUnidadePadrao(qryEmb.FieldByName('BAS_CODUNI').AsString);

                fltFator := fltEmbNova / fltEmbPadrao;

                for intCont := 1 to 20 do
                begin
                  if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                    Break;

                  if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                    Break;

                  qryCadMZI.ParamByName('MZI_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString);

                  qryCadMZI.ParamByName('MZI_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  :=    qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fltFator;

                end;

                strMd5 := '';

                strMd5 := qryCadMzi.ParamByName('MZI_CODMZI').AsString +
                          qryCadMzi.ParamByName('MZI_CODEMP').AsString +
                          qryCadMzi.ParamByName('MZI_CODUNI').AsString +
                          qryCadMzi.ParamByName('MZI_PRODUT').AsString +
                          qryCadMzi.ParamByName('MZI_COLNUM').AsString +
                          qryCadMzi.ParamByName('MZI_CODBAS').AsString ;

                qryCadMZI.ParamByName('MZI_MD5KEY').AsString := GetMD5(strMd5);

                qryCadMZI.ExecSQL;

                if not (blnGerarUnidades) then
                  Break;

                qryEmb.Next;
              End;
            end;
          Except
            on E: Exception do
            begin
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          qryCadNfm.Next;
          gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
        End;
      end;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoMazaImobiliariaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TGravandoExecucaoMazaImobiliariaNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL := 'DELETE '+
                      '  FROM MZI_CADMZI '+
                      ' WHERE MZI_CODMZI IN (SELECT NFM_CODNFM  '+
                      '                        FROM MZI_CADNFM)';
      end
      else
      begin
        qryGen.SQL := ' DELETE              ' +
                      '   FROM MZI_CADMZI   ' +
                      '  WHERE MZI_CODMZI = :CODMZI';
        qryGen.ParamByName('CODMZI').AsString := strCodNfm;
      end;

      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;


end.
