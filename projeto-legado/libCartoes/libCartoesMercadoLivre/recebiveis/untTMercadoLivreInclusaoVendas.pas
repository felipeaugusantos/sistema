unit untTMercadoLivreInclusaoVendas;

interface

uses System.SysUtils, System.Classes, System.Variants, System.JSON, System.Generics.Collections,
     Data.DB, Uni,

     untILibCartoesWrapper, untTMercadoLivreFuncoes;

type
  TMercadoLivreInclusaoVendas = class
  private
    class function fCartoesMercadoLivre(const ACodigoEmpresa: String): String;
    class function fConfiguracaoCartaoPreenchida(ADataset: TDataSet): Boolean;
    class function fVendaJaLancada(AEnvio: TJSONObject): Boolean;
    class function fMontaEnvios(ADataset: TDataSet): TObjectList<TJSONObject>;
  public
    const
      INCONSISTENCIA_VENDA      = 'Vendas não encontradas nos lançamentos do sistema';
      INCONSISTENCIA_MAQUININHA = 'Registro do arquivo não encontrado nos lançamentos do sistema';

    class function fDisponivel(AAutoIncremRelatorio: Integer): Boolean;
    class function fIncluirVendas(ADataset: TDataSet): Boolean;
  end;

implementation


class function TMercadoLivreInclusaoVendas.fDisponivel(AAutoIncremRelatorio: Integer): Boolean;
  Var
    LMarketplace: ILibCartoesMarketplace;
    LConsulta: TUniQuery;
begin
  Result := Supports(VS_FuncoesExternas, ILibCartoesMarketplace, LMarketplace);
  If Not Result Then
    Exit;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT 1 FROM REL_CONITE ' +
                          'WHERE REL_RELINC = :RELINC ' +
                          '  AND REL_TIPREG = "INCONSISTENCIA" ' +
                          '  AND REL_DESCRI IN (:DESVEN, :DESMAQ) ' +
                          'LIMIT 1';
    LConsulta.ParamByName('RELINC').AsInteger := AAutoIncremRelatorio;
    LConsulta.ParamByName('DESVEN').AsString := INCONSISTENCIA_VENDA;
    LConsulta.ParamByName('DESMAQ').AsString := INCONSISTENCIA_MAQUININHA;
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

class function TMercadoLivreInclusaoVendas.fCartoesMercadoLivre(const ACodigoEmpresa: String): String;
begin
  Result := VarToStr(VS_FuncoesExternas.fICfgSis('MERCAR', varString, ACodigoEmpresa)).Trim;
end;

class function TMercadoLivreInclusaoVendas.fConfiguracaoCartaoPreenchida(ADataset: TDataSet): Boolean;
  Var
    LEmpresasVerificadas: TStringList;
    LCodigoEmpresa: String;
begin
  Result := True;

  LEmpresasVerificadas := TStringList.Create;
  Try
    ADataset.First;
    While Not ADataset.Eof Do
    Begin
      LCodigoEmpresa := ADataset.FieldByName('REL_CODEMP').AsString;

      If (ADataset.FieldByName('MARCADO').AsInteger = 1) And
         (LEmpresasVerificadas.IndexOf(LCodigoEmpresa) < 0) Then
      Begin
        LEmpresasVerificadas.Add(LCodigoEmpresa);

        If fCartoesMercadoLivre(LCodigoEmpresa).Replace('_', '').Trim.IsEmpty Then
          Exit(False);
      End;

      ADataset.Next;
    End;
  Finally
    FreeAndNil(LEmpresasVerificadas);
  End;
end;

class function TMercadoLivreInclusaoVendas.fMontaEnvios(ADataset: TDataSet): TObjectList<TJSONObject>;
  Var
    LEnviosPorChave: TDictionary<String, TJSONObject>;
    LEnvio,
    LParcela: TJSONObject;
    LChave: String;
begin
  Result := TObjectList<TJSONObject>.Create(True);
  LEnviosPorChave := TDictionary<String, TJSONObject>.Create;
  Try
    Try
      ADataset.First;
      While Not ADataset.Eof Do
      Begin
        If ADataset.FieldByName('MARCADO').AsInteger <> 1 Then
        Begin
          ADataset.Next;
          Continue;
        End;

        LChave := ADataset.FieldByName('REL_CODEMP').AsString + '|' + ADataset.FieldByName('REL_NUMNSU').AsString;
        If ADataset.FieldByName('REL_DESCRI').AsString = INCONSISTENCIA_MAQUININHA Then
          LChave := LChave + '|' + ADataset.RecNo.ToString;

        If Not LEnviosPorChave.TryGetValue(LChave, LEnvio) Then
        Begin
          LEnvio := TJSONObject.Create;
          Result.Add(LEnvio);
          LEnviosPorChave.Add(LChave, LEnvio);
          LEnvio.AddPair('CODEMP', ADataset.FieldByName('REL_CODEMP').AsString);
          LEnvio.AddPair('NUMNSU', ADataset.FieldByName('REL_NUMNSU').AsString);
          LEnvio.AddPair('PARCELAS', TJSONArray.Create);
        End;

        LParcela := TJSONObject.Create;
        LEnvio.GetValue<TJSONArray>('PARCELAS').AddElement(LParcela);
        LParcela.AddPair('ORDEID', ADataset.FieldByName('ORDEID').AsString);
        LParcela.AddPair('VALBRU', TJSONNumber.Create(ADataset.FieldByName('REL_VALBRU').AsFloat));
        LParcela.AddPair('VALFRE', TJSONNumber.Create(ADataset.FieldByName('REL_VALFRE').AsFloat));
        LParcela.AddPair('VALCUP', TJSONNumber.Create(ADataset.FieldByName('REL_VALCUP').AsFloat));
        LParcela.AddPair('VALLIQ', TJSONNumber.Create(ADataset.FieldByName('REL_VALLIQ').AsFloat));
        LParcela.AddPair('DTATRA', FormatDateTime('yyyy-mm-dd', ADataset.FieldByName('REL_DTA_CV').AsDateTime));
        LParcela.AddPair('DTAVEN', FormatDateTime('yyyy-mm-dd', ADataset.FieldByName('DTAVEN').AsDateTime));

        ADataset.Next;
      End;
    Except
      FreeAndNil(Result);
      Raise;
    End;
  Finally
    FreeAndNil(LEnviosPorChave);
  End;
end;

class function TMercadoLivreInclusaoVendas.fVendaJaLancada(AEnvio: TJSONObject): Boolean;
  Var
    LConsulta: TUniQuery;
    LPedidos: TStringList;
    LParcela: TJSONValue;
begin
  LConsulta := Nil;
  LPedidos := TStringList.Create;
  Try
    For LParcela In AEnvio.GetValue<TJSONArray>('PARCELAS') Do
      LPedidos.Add(TJSONObject(LParcela).GetValue<String>('ORDEID'));

    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT 1 FROM MOVCAR ' +
                          'WHERE MCA_CODEMP = :CODEMP ' +
                          '  AND FIND_IN_SET(MCA_CODCAR, REPLACE(:CARTOES, "_", ",")) ' +
                          '  AND (MCA_NUMNSU = :NUMNSU OR MCA_NUMCCD = :NUMNSU ' +
                          '       OR FIND_IN_SET(MCA_ORDEID, :PEDIDOS)) ' +
                          'LIMIT 1';
    LConsulta.ParamByName('CODEMP').AsString := AEnvio.GetValue<String>('CODEMP');
    LConsulta.ParamByName('CARTOES').AsString := fCartoesMercadoLivre(AEnvio.GetValue<String>('CODEMP'));
    LConsulta.ParamByName('NUMNSU').AsString := AEnvio.GetValue<String>('NUMNSU');
    LConsulta.ParamByName('PEDIDOS').AsString := LPedidos.CommaText;
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LPedidos);
    TMercadoLivreFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

class function TMercadoLivreInclusaoVendas.fIncluirVendas(ADataset: TDataSet): Boolean;
  Var
    LMarketplace: ILibCartoesMarketplace;
    LEnvios: TObjectList<TJSONObject>;
    LIndice,
    LGravadas,
    LCanceladas,
    LPuladas,
    LNaoProcessadas: Integer;
    LResumo: String;
begin
  Result := False;

  If Not Supports(VS_FuncoesExternas, ILibCartoesMarketplace, LMarketplace) Then
    Exit;

  If Not fConfiguracaoCartaoPreenchida(ADataset) Then
  Begin
    TMercadoLivreFuncoes.fMensagem('ATENÇÃO', 'Não foi possível gerar os lançamentos. Por favor, defina o Cartão Padrão ' +
                                              'para Conciliação nas Configurações do Sistema.', ['&OK']);
    Exit;
  End;

  LGravadas := 0;
  LCanceladas := 0;
  LPuladas := 0;
  LNaoProcessadas := 0;

  LEnvios := fMontaEnvios(ADataset);
  Try
    For LIndice := 0 To LEnvios.Count - 1 Do
    Begin
      If fVendaJaLancada(LEnvios[LIndice]) Then
      Begin
        Inc(LPuladas);
        Continue;
      End;

      If LMarketplace.fIIncluirCartaoVendaMarketplace(LEnvios[LIndice].ToString) Then
      Begin
        Inc(LGravadas);
        Continue;
      End;

      Inc(LCanceladas);

      If (LIndice < LEnvios.Count - 1) And
         (TMercadoLivreFuncoes.fMensagem('ATENÇÃO', 'A venda do envio ' + LEnvios[LIndice].GetValue<String>('NUMNSU') +
                                                    ' não foi gravada.' + #13 + 'Deseja seguir para a próxima venda?',
                                         ['&Seguir', '&Interromper']) = 2) Then
      Begin
        LNaoProcessadas := LEnvios.Count - 1 - LIndice;
        Break;
      End;
    End;
  Finally
    FreeAndNil(LEnvios);
  End;

  LResumo := 'Vendas gravadas: ' + LGravadas.ToString + #13 +
             'Vendas canceladas: ' + LCanceladas.ToString + #13 +
             'Vendas puladas por já possuírem lançamento: ' + LPuladas.ToString;
  If LNaoProcessadas > 0 Then
    LResumo := LResumo + #13 + 'Vendas não processadas (interrompido): ' + LNaoProcessadas.ToString;

  TMercadoLivreFuncoes.fMensagem('RESUMO', LResumo, ['&OK']);

  Result := LGravadas > 0;
end;

end.
