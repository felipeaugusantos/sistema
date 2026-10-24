{****************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta StarmixWeb *}
{*************************************************************************AC*}
unit untGravandoExecucaoStarmixWebCores;

interface

uses
  untAbstractGravandoExecucaoStarmixWeb, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela,
  StrUtils, untTipoCadastro, untFloatUtils, Classes;

type
  TGravandoExecucaoStarmixWebCores = class(TAbstractGravandoExecucaoStarmixWeb)
  private

  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

    procedure pGravarCadastroLinhas;

  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoStarmixWebCores }

procedure TGravandoExecucaoStarmixWebCores.Executar(const gravando: IGravando);
var
  qryInsert: IDataSet;
  intCont: Integer;
  intContador: Integer;
  blnProximo: Boolean;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto  := 'Path para a geração do arquivo não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

      pPreenchendoCdsParaGeracao(gravando);

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('STW_CADSTW', False);
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Limpando tabela de formulação';
      TAutcomTintaFactory.Get.TruncateTable('STW_CADSTW');
      gravando.Texto := 'Tabela de formulação limpa com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      qryInsert := TAutcomTintaFactory.Get.fGetDataSet;

      intContador := 0;
      blnProximo  := False;

      cdsFormulas.First;
      While Not cdsFormulas.Eof Do
      Begin
        Try
          Try
            if gravando.Status <> sgGravando then
              Exit;

            Inc(intContador);

            qryInsert.SQL := TAutcomTintaFactory.Get.GetInsert('STW_CADSTW');

            If cdsFormulas.FieldByName('PESFOR').AsFloat <= 0 Then
            Begin
              cdsFormulas.Next;
              Continue;
            End;

            qryInsert.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('STW_CADSTW', TAutcomTintaFactory.Get.GetCodEmp);
            qryInsert.ParamByName('STW_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryInsert.ParamByName('STW_CODIGO').AsString := cdsFormulas.FieldByName('CODIGO').AsString;
            qryInsert.ParamByName('STW_NOMCOR').AsString := cdsFormulas.FieldByName('NOMCOR').AsString;
            qryInsert.ParamByName('STW_OBSERV').AsString := cdsFormulas.FieldByName('OBSERV').AsString;
            qryInsert.ParamByName('STW_ANOCOR').AsString := cdsFormulas.FieldByName('ANOCOR').AsString;
            qryInsert.ParamByName('STW_PESCOR').AsFloat  := cdsFormulas.FieldByName('PESCOR').AsFloat;
            qryInsert.ParamByName('STW_PESFOR').AsFloat  := cdsFormulas.FieldByName('PESFOR').AsFloat;
            qryInsert.ParamByName('STW_DTAFOR').AsDateTime := StrToDateTime(cdsFormulas.FieldByName('DTAFOR').AsString); //converter para data
            qryInsert.ParamByName('STW_CODLIN').AsString := cdsFormulas.FieldByName('CODLIN').AsString;
            qryInsert.ParamByName('STW_DESLIN').AsString := fRetNomLin(cdsFormulas.FieldByName('CODLIN').AsString);
            qryInsert.ParamByName('STW_CODMON').AsString := cdsFormulas.FieldByName('CODMON').AsString;
            qryInsert.ParamByName('STW_MONTAD').AsString := fRetNomMon(cdsFormulas.FieldByName('CODMON').AsString);
            qryInsert.ParamByName('STW_UNIVER').AsString := cdsFormulas.FieldByName('UNIVER').AsString;

            //quantidades
            For intCont := 1 To 20 Do
            Begin
              If ((cdsFormulas.FieldByName('QTDB01').AsFloat <= 0) Or
                  (TStrUtils.fEmptyStr(cdsFormulas.FieldByName('CODB01').AsString))) Then
              Begin
                blnProximo := True;
                Break;
              End;

              If TStrUtils.fEmptyStr(cdsFormulas.FieldByName('CODB' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
              Begin
                Break;
              End;

              If (Not cdsBases.Locate('CODSEQ', cdsFormulas.FieldByName('CODB' + TStrUtils.fStrZero(intCont, 2)).AsString, [])) Then
              Begin
                blnProximo := True;
                Break;
              End;

              // tem que verificar se a primeira quantidade esta vazia
              If ((Not TStrUtils.fEmptyStr(cdsFormulas.FieldByName('CODB' + TStrUtils.fStrZero(intCont, 2)).AsString)) And
                  (cdsFormulas.FieldByName('QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0)) Then
              Begin
                blnProximo := True;
                Break;
              End;

              qryInsert.ParamByName('STW_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString :=
                cdsBases.FieldByName('CODIGO').AsString;
              qryInsert.ParamByName('STW_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  :=
                (cdsFormulas.FieldByName('QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat / 10000);
            End;


            If blnProximo Then
            Begin
              blnProximo := False;
              cdsFormulas.Next;
              Continue;
            End;


            qryInsert.ParamByName('STW_ATIVAD').AsString := 'S';
            qryInsert.ParamByName('STW_ACRMOB').AsFloat  := 0.0;
            qryInsert.ParamByName('STW_MD5KEY').AsString := GetMD5(qryInsert.ParamByName('STW_CODIGO').AsString +
                                                                   qryInsert.ParamByName('STW_NOMCOR').AsString +
                                                                   qryInsert.ParamByName('STW_OBSERV').AsString +
                                                                   qryInsert.ParamByName('STW_ANOCOR').AsString +
                                                                   qryInsert.ParamByName('STW_CODLIN').AsString +
                                                                   qryInsert.ParamByName('STW_CODMON').AsString +
                                                                   qryInsert.ParamByName('STW_UNIVER').AsString);

            qryInsert.ExecSQL;

          Except
            on E: Exception do
            begin
              gravando.Cancelar;
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          gravando.RegistrarProgresso(0, intContador, cdsFormulas.RecordCount);
        End;
        cdsFormulas.Next;
      End;
    Except
      on E: Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    pGravarCadastroLinhas;
  End;
end;

function TGravandoExecucaoStarmixWebCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

procedure TGravandoExecucaoStarmixWebCores.pGravarCadastroLinhas;
Var
  qryInsert: IDataSet;
begin
  qryInsert := TAutcomTintaFactory.Get.fGetDataSet;
  qryInsert.SQL := ' INSERT '+
                   '   INTO STW_CADLIN(AUTOINCREM, LIN_CODLIN, LIN_DESLIN) '+
                   ' VALUES("00100000000000144001", "999", "PERSONALIZADA")';
  qryInsert.ExecSQL;
end;

end.

