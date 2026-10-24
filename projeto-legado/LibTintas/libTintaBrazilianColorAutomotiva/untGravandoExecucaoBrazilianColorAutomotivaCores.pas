{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta BrazilianColorAutomotiva *}
{**********************************************************************PH*}
unit untGravandoExecucaoBrazilianColorAutomotivaCores;

interface

uses
  untAbstractGravandoExecucaoBrazilianColorAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela, ADODB,
  StrUtils, untTipoCadastro, untFloatUtils, Classes, Math, Uni;

type
  TGravandoExecucaoBrazilianColorAutomotivaCores = class(TAbstractGravandoExecucaoBrazilianColorAutomotiva)
  private
    _Connection : TADOConnection;

  public

    constructor Create(const strCodNfm: string = '');
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoBrazilianColorAutomotivaCores }

constructor TGravandoExecucaoBrazilianColorAutomotivaCores.Create(const strCodNfm: string);
begin
  inherited Create();
end;

procedure TGravandoExecucaoBrazilianColorAutomotivaCores.Executar(const gravando: IGravando);
Var
  QryComposicao          : TADODataSet;
  fltPesoConcentradoCheio: Double;
  fltPesoDiluente        : Double;
  fltPesoConcentrado     : Double;
  fltFatorConcentrado    : Double;
  fltValorMultiplicante  : Double;
begin
  Try
    Try

      gravando.Texto := 'Verificando path dos arquivos...';

      if not FileExists(AnsiReplaceStr(GetPath, '"', '')) then
      begin
        gravando.Texto := Format('O arquivo [%s] não existe, ou não foi encontrado!', [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.Cancelar;
      end;

      if gravando.Status <> sgGravando then
      begin
        Exit;
      end;

      gravando.Texto := 'Path validado com sucesso...';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BZC_CADBZC');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Carregando dados...';

      pCreateConnection;

      gravando.Texto := 'Excluindo os registros da BZC_CADBZC...';
      qryDestino.SQL := 'DELETE FROM BZC_CADBZC';
      qryDestino.ExecSQL;

      tabela.CommandText := 'SELECT * '+
                            '  FROM MIX_Formulacoes '+
                            ' ORDER BY id_MIX_Formulacoes ';
      tabela.Open;

      gravando.Texto := 'Preparando para importação dos registros...';

      tabela.First;

      qryDestino.SQL := 'SELECT * FROM BZC_CADBZC';
      qryDestino.Open;


      _Connection                  := TADOConnection.Create(nil);
      _Connection.LoginPrompt      := False;
      _Connection.ConnectionString := fConnection;
      _Connection.Open;

      QryComposicao := TADODataSet.Create(nil);
      QryComposicao.Connection  := _Connection;
      QryComposicao.CommandText := ' SELECT                           ' +
                                   '   *                              ' +
                                   ' FROM                             ' +
                                   '   MIX_COMPOSICAO AS C            ' +
                                   '   INNER JOIN MIX_BASES AS B      ' +
                                   '     ON C.ID_MIX_BASES = B.CODIGO ' +
                                   ' WHERE ID_MIX_FOMULACOES = :ID    ' +
                                   ' ORDER BY QUANTIDADE              ' ;

      gravando.RegistrarProgresso(0, 0, 0);

      While Not tabela.Eof Do
      Begin

        if gravando.Status <> sgGravando then
        begin
          Exit;
        end;

        qryDestino.Insert;
        qryDestino.FieldByName('BZC_CODIGO').AsString := tabela.FieldByName('Codigo').AsString;
        qryDestino.FieldByName('BZC_CODUNI').AsString := tabela.FieldByName('CodigoUniversal').AsString;
        qryDestino.FieldByName('BZC_DESCRI').AsString := Trim(AnsiUpperCase(fRemoveAcento(tabela.FieldByName('Descricao').AsString)));
        qryDestino.FieldByName('BZC_A_N_O_').AsString := tabela.FieldByName('Ano').AsString;

        qryDestino.FieldByName('BZC_CODMON').AsString :=
          TStrUtils.fStrZero(Trim(AnsiUpperCase(fRemoveAcento(tabela.FieldByName('id_MIX_Montadora').AsString))), 5);

        qryDestino.FieldByName('BZC_REVISA').AsString := tabela.FieldByName('Revisao').AsString;
        qryDestino.FieldByName('BZC_ESPECI').AsString := tabela.FieldByName('Especificacao').AsString;
        qryDestino.FieldByName('BZC_TIPO__').AsString := Trim(AnsiUpperCase(fRemoveAcento(tabela.FieldByName('Tipo').AsString)));
        qryDestino.FieldByName('BZC_CODPRE').AsString := tabela.FieldByName('CodPrefixo').AsString;
        qryDestino.FieldByName('BZC_CODPRO').AsString := tabela.FieldByName('CodProduto').AsString;
        qryDestino.FieldByName('BZC_CODSUF').AsString := tabela.FieldByName('CodSufixo').AsString;
        qryDestino.FieldByName('BZC_PUBLIC').AsString := tabela.FieldByName('Publicado').AsString;
        qryDestino.FieldByName('BZC_LINHA_').AsString := tabela.FieldByName('linha').AsString;

        if Trunc(tabela.FieldByName('PublicadoData').AsDateTime) > 0 then
          qryDestino.FieldByName('BZC_PUBDTA').AsDate := Trunc(tabela.FieldByName('PublicadoData').AsDateTime);

        qryDestino.FieldByName('BZC_AUTORI').AsString := tabela.FieldByName('Autorizador').AsString;
        qryDestino.FieldByName('BZC_REVISD').AsString := tabela.FieldByName('Revisado').AsString;

        qryDestino.FieldByName('BZC_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BZC_CADBZC', TAutcomTintaFactory.Get.GetCodEmp);

        qryDestino.FieldByName('BZC_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('BZC_CODIGO').AsString +
                                                                qryDestino.FieldByName('BZC_CODUNI').AsString +
                                                                qryDestino.FieldByName('BZC_DESCRI').AsString +
                                                                qryDestino.FieldByName('BZC_A_N_O_').AsString +
                                                                qryDestino.FieldByName('BZC_CODMON').AsString +
                                                                qryDestino.FieldByName('BZC_REVISA').AsString +
                                                                qryDestino.FieldByName('BZC_ESPECI').AsString +
                                                                qryDestino.FieldByName('BZC_TIPO__').AsString +
                                                                qryDestino.FieldByName('BZC_CODPRE').AsString +
                                                                qryDestino.FieldByName('BZC_CODPRO').AsString +
                                                                qryDestino.FieldByName('BZC_CODSUF').AsString +
                                                                qryDestino.FieldByName('BZC_PUBLIC').AsString +
                                                                qryDestino.FieldByName('BZC_LINHA_').AsString);


        qryComposicao.Close;
        qryComposicao.Parameters.ParamByName('ID').Value := tabela.FieldByName('id_MIX_Formulacoes').AsString;
        qryComposicao.Open;


        qryComposicao.First;

        While not qryComposicao.Eof do
        begin
          qryDestino.FieldByName('BZC_BASE' + TStrUtils.fStrZero(qryComposicao.RecNo, 2)).AsString :=
            Trim(AnsiUpperCase(fRemoveAcento(qryComposicao.FieldByName('C.id_MIX_Bases').AsString)));

          If (tabela.FieldByName('linha').AsString = 'SINTETICO') Or (tabela.FieldByName('linha').AsString = 'LACA NITRO') And
            (qryDestino.FieldByName('BZC_BASE' + TStrUtils.fStrZero(qryComposicao.RecNo, 2)).AsString <> 'BP 8007') Then
          Begin
            qryDestino.FieldByName('BZC_QTDC' + TStrUtils.fStrZero(qryComposicao.RecNo, 2)).AsFloat :=
              RoundTo(qryComposicao.FieldByName('Quantidade').AsFloat * 0.9, -1);

            qryDestino.FieldByName('BZC_QTDD' + TStrUtils.fStrZero(qryComposicao.RecNo, 2)).AsFloat := 0;
          End
          Else
          Begin
            qryDestino.FieldByName('BZC_QTDD' + TStrUtils.fStrZero(qryComposicao.RecNo, 2)).AsFloat :=
              RoundTo(qryComposicao.FieldByName('Quantidade').AsFloat * 0.9, -1);

            qryDestino.FieldByName('BZC_QTDC' + TStrUtils.fStrZero(qryComposicao.RecNo, 2)).AsFloat := 0;
          End;

          qryComposicao.Next;
        end;

        // Concentrados

        If qryComposicao.Locate('C.id_MIX_Bases', 'BP 8007', []) then
        Begin
          fltPesoConcentradoCheio := 0;
          fltPesoDiluente         := 0;
          fltPesoConcentrado      := 0;

          qryComposicao.First;

          while not qryComposicao.Eof do
          begin
            fltPesoConcentradoCheio := fltPesoConcentradoCheio + qryComposicao.FieldByName('Quantidade').AsFloat;

            if Trim(AnsiUpperCase(fRemoveAcento(qryComposicao.FieldByName('C.id_MIX_Bases').AsString))) = 'BP 8007' then
              fltPesoDiluente := qryComposicao.FieldByName('Quantidade').AsFloat
            else
              fltPesoConcentrado := fltPesoConcentrado + (qryComposicao.FieldByName('Quantidade').AsFloat *
                qryComposicao.FieldByName('PesoEspecifico').AsFloat);
            qryComposicao.Next;
          end;

          fltFatorConcentrado   := 0.9 / ((fltPesoConcentradoCheio - fltPesoDiluente) * 1000);
          fltValorMultiplicante := (((fltPesoConcentrado * fltFatorConcentrado) * 1000) * 1000) / (fltPesoConcentradoCheio - fltPesoDiluente);


          qryComposicao.First;

          While not qryComposicao.Eof do
          begin
            if qryDestino.fieldByName('BZC_BASE' + TStrUtils.fStrZero(qryComposicao.RecNo, 2)).AsString <> 'BP 8007' then
              qryDestino.fieldByName('BZC_QTDC' + TStrUtils.fStrZero(qryComposicao.RecNo, 2)).AsFloat :=
                RoundTo(qryComposicao.FieldByName('Quantidade').AsFloat * fltValorMultiplicante, -1)
            else
              qryDestino.fieldByName('BZC_QTDC' + TStrUtils.fStrZero(qryComposicao.RecNo, 2)).AsFloat := 0;

            qryComposicao.Next;
          end;

        End;

        qryDestino.post;

        gravando.RegistrarProgresso(1, tabela.RecNo, tabela.RecordCount);
        tabela.Next;

      end;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    pDestroyConnection;
  End;

end;

function TGravandoExecucaoBrazilianColorAutomotivaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;



end.
