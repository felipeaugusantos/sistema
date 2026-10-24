unit untTConfirmaCartoesRedeCard;

interface

Uses Forms,System.SysUtils,cxProgressBar,untIDataset,System.Generics.Collections,
     untFuncoes, untFuncoesSimples, untConstantes,untTExtratoConfirmaCartoes,
     System.StrUtils;

Type
  TVendasRedeCard = Class
  Private
    FExtratoVendas: TList<TDadosVendas>;
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
    function RetornaSQLVendas: String;
  Public
    constructor Create;
    destructor Destroy; override;
    function ImportaExtratoVendas(pgbProgresso: TcxProgressBar): Boolean;
    property DataInicial:    TDateTime           Read FDataInicial   Write FDataInicial;
    property DataFinal:      TDateTime           Read FDataFinal     Write FDataFinal;
    property ExtratoVendas:  TList<TDadosVendas> Read FExtratoVendas Write FExtratoVendas;
  End;


implementation

{ TVendasRedeCard }

constructor TVendasRedeCard.Create;
begin
  FExtratoVendas := TList<TDadosVendas>.Create;
end;

destructor TVendasRedeCard.Destroy;
begin
  If Assigned(FExtratoVendas) Then
    If FExtratoVendas.Count > 0 Then
      FreeAndNil(FExtratoVendas);
  inherited;
end;

function TVendasRedeCard.ImportaExtratoVendas(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LQryVendas: IDataset;
    LDadosVendas : TDadosVendas;
Begin
  Result := True;

  Try
    LQryVendas := objFunctions.fGetDataSet;

    Try
      LQryVendas.Close;
      LQryVendas.SQL := RetornaSQLVendas;

      LQryVendas.ParamByName('DTAINI').AsDateTime := FDataInicial;
      LQryVendas.ParamByName('DTAFIN').AsDateTime := FDataFinal;
      LQryVendas.Open;

      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := LQryVendas.RecordCount;

      While Not LQryVendas.Eof Do
      Begin
        LDadosVendas.Estabelecimento := LQryVendas.FieldByName('V_RED_NUM_PV').AsString;
        LDadosVendas.Autorizacao     := LQryVendas.FieldByName('V_RED_CODAUT').AsString;
        LDadosVendas.Nsu             := fStrZero(Trim(RightStr(LQryVendas.FieldByName('VP_RED_NUMNSU').AsString, 14)), 14);
        LDadosVendas.Parcela         := fGetLetraAlfa(StrToInt(LeftStr(LQryVendas.FieldByName('VP_RED_NUMPAR').AsString , 2)));
        LDadosVendas.Cartao          := LQryVendas.FieldByName('V_RED_NUMCAR').AsString;
        LDadosVendas.Bandeira        := fRetNomBandeira(LDadosVendas.Cartao);
        LDadosVendas.Status          := 'N';
        LDadosVendas.Operador        := strLoginUsuarioLogado;
        LDadosVendas.NomeOperadora   := 'REDECARD';


        LDadosVendas.DataTransacao   := StrToDate(LQryVendas.FieldByName('V_RED_DTAVEN').AsString);
        LDadosVendas.DataVencimento  := StrToDate(LQryVendas.FieldByName('VP_RED_VEN_RV').AsString);
        LDadosVendas.DataImportacao  := VS_Date;

        LDadosVendas.ValorBruto      := LQryVendas.FieldByName('VP_RED_VALPAR').AsFloat;
        LDadosVendas.ValorTaxa       := LQryVendas.FieldByName('VP_RED_VALDES').AsFloat;
        LDadosVendas.ValorLiquido    := LQryVendas.FieldByName('VP_RED_LIQPAR').AsFloat;


        FExtratoVendas.Add(LDadosVendas);
        pStep(pgbProgresso);
        LQryVendas.Next;
      End;


    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    LQryVendas := Nil;
  End;
End;

function TVendasRedeCard.RetornaSQLVendas: String;
begin
  Result := 'SELECT                                                '+
            '  V.RED_NUM_PV AS V_RED_NUM_PV,                       '+
            '  V.RED_NUM_RV AS V_RED_NUM_RV,                       '+
            '  V.RED_TIPREG AS V_RED_TIPREG,                       '+
            '  V.RED_TOTPAR AS V_RED_TOTPAR,                       '+
            '  V.RED_DTAVEN AS V_RED_DTAVEN,                       '+
            '  VP.RED_VEN_RV AS VP_RED_VEN_RV,                     '+
            '  CAST(                                               '+
            '    IFNULL(VP.RED_NUMPAR, "0") AS DECIMAL             '+
            '  ) AS VP_RED_NUMPAR,                                 '+
            '  VP.RED_NUMNSU AS VP_RED_NUMNSU,                     '+
            '  TRIM(LEADING 0 FROM V.RED_CODAUT) AS V_RED_CODAUT,  '+
            '  VP.RED_DTA_RV AS VP_RED_DTA_RV,                     '+
            '  VP.RED_NUM_PV AS VP_RED_NUM_PV,                     '+
            '  VP.RED_NUM_RV AS VP_RED_NUM_RV,                     '+
            '  VP.RED_LIQPAR AS VP_RED_LIQPAR,                     '+
            '  VP.RED_VALDES AS VP_RED_VALDES,                     '+
            ' (VP.RED_BRU_RO / VP.RED_TOTPAR) AS VP_RED_VALPAR,    '+
            '  V.RED_NUMCAR AS V_RED_NUMCAR                        '+
            'FROM                                                  '+
            '  RED_APVPAR VP                                       '+
            '  INNER JOIN RED_APVEND V                             '+
            '    ON VP.RED_NUM_PV = V.RED_NUM_PV                   '+
            '    AND VP.RED_NUM_RV = V.RED_NUM_RV                  '+
            '    AND VP.RED_NUMNSU = V.RED_NUMNSU                  '+
            '    AND VP.RED_DTAVEN = V.RED_DTAVEN                  '+
            'WHERE VP.RED_DTAVEN BETWEEN :DTAINI                   '+
            '  AND :DTAFIN                                         ';
end;

end.
