unit untLibCartoesLogMca;

interface

uses Vcl.Forms, Uni, System.SysUtils, System.DateUtils, System.Variants,
     Data.DB, System.StrUtils,

     untTLibCartoesFuncoes, untTBatchSQL, untTBatchSQL.Helper;

Type
  TAjusteLogMca = reference to procedure(AMovCar: TDataSet; ALogMca: TUniQuery);

procedure GravaLogMca(AAutoIncrem: String;
                      ADescricao,
                      ANomeFormulario: String;
                      AAutoIncremLog: String = '';
                      ABatchSQL: TBatchSQL = Nil;
                      AAjustarValores: TAjusteLogMca = Nil);

procedure DefinirCampoLogMca(ALogMca: TUniQuery; const ACampo: String; const AValor: Variant);

procedure GeraListaDeCamposLOGMCA;

implementation

Var
  FCamposLogMca,
  FParametrosLogMca: String;

  FDataExecutavel: TDateTime;

Const
  FArrayCamposIgnoradosLogMca: Array of String = ['AUTOINCREM', 'MCA_NOMFRM', 'MCA_DESCRI', 'MCA_DTALOG', 'MCA_HORLOG',
                                                  'MCA_OPELOG', 'MCA_NOMTAB', 'MCA_NOMEXE', 'MCA_DTAEXE', 'MCA_HOREXE',
                                                  'MCA_VEREXE'];

procedure GravaLogMca(AAutoIncrem: String;
                      ADescricao,
                      ANomeFormulario: String;
                      AAutoIncremLog: String = '';
                      ABatchSQL: TBatchSQL = Nil;
                      AAjustarValores: TAjusteLogMca = Nil);
  var
    LMovCar,
    LLogMca: TUniQuery;

    LCampo: TField;
Begin
  LMovCar := Nil;
  LLogMca := Nil;
  Try
    GeraListaDeCamposLOGMCA;

    LMovCar := VS_FuncoesExternas.fICriaQuery;
    LMovCar.SQL.Text := 'SELECT * FROM MOVCAR WHERE AUTOINCREM = "' + AAutoincrem + '"';
    LMovCar.Open;

    If LMovCar.IsEmpty Then
      Exit;

    If FDataExecutavel = 0 Then
      FileAge(Application.ExeName, FDataExecutavel);
    
    LLogMca := VS_FuncoesExternas.fICriaQuery;
    LLogMca.SQL.Text := 'INSERT INTO LOGMCA (' + FCamposLogMca + ') ' +
                        ' VALUES (' + FParametrosLogMca + ') ';

    For LCampo In LMovCar.Fields Do
    Begin
      If MatchStr(LCampo.FieldName, FArrayCamposIgnoradosLogMca) Then
        Continue;

      If LLogMca.FindParam(LCampo.FieldName) = Nil Then
        Continue;

      If LCampo.IsNull Then
        LLogMca.ParamByName(LCampo.FieldName).Value := Null
      Else
        LLogMca.ParamByName(LCampo.FieldName).Value := LCampo.Value;
    End;

    If Assigned(AAjustarValores) Then
      AAjustarValores(LMovCar, LLogMca);

    If AAutoIncremLog.IsEmpty Then
      AAutoIncremLog := VS_FuncoesExternas.fIRetAutoIncrem('LOGMCA', VS_FuncoesExternas.fIRetEmpresaLogada);

    LLogMca.ParamByName('AUTOINCREM').AsString   := AAutoIncremLog;
    LLogMca.ParamByName('MCA_NOMFRM').AsString   := ANomeFormulario;
    LLogMca.ParamByName('MCA_DESCRI').AsString   := ADescricao;
    LLogMca.ParamByName('MCA_DTALOG').AsDateTime := VS_FuncoesExternas.fIGetVS_Date;
    LLogMca.ParamByName('MCA_HORLOG').AsDateTime := TLibCartoesFuncoes.RetornaHoraServidor;
    LLogMca.ParamByName('MCA_OPELOG').AsString   := VS_FuncoesExternas.fIRetOperadorLogado;
    LLogMca.ParamByName('MCA_NOMTAB').AsString   := 'MOVCAR';
    LLogMca.ParamByName('MCA_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
    LLogMca.ParamByName('MCA_DTAEXE').Value      := FDataExecutavel;
    LLogMca.ParamByName('MCA_HOREXE').Value      := EncodeTime(HourOf(FDataExecutavel),
                                                               MinuteOf(FDataExecutavel),
                                                               SecondOf(FDataExecutavel),
                                                               MilliSecondOf(FDataExecutavel));

    LLogMca.ParamByName('MCA_VEREXE').AsString   := VS_FuncoesExternas.fIGetVersaoProduto;

    If Not Assigned(ABatchSQL) Then
      LLogMca.ExecSQL
    Else
      TBatchHelper.AddQueryToBatch(ABatchSQL, LLogMca);
  Finally
    TLibCartoesFuncoes.FreeAndNilDatasets(LLogMca);
    TLibCartoesFuncoes.FreeAndNilDatasets(LMovCar);
  End;
End;

procedure DefinirCampoLogMca(ALogMca: TUniQuery; const ACampo: String; const AValor: Variant);
Begin
  If ALogMca.FindParam(ACampo) = Nil Then
    Exit;

  ALogMca.ParamByName(ACampo).Value := AValor;
End;

procedure GeraListaDeCamposLOGMCA;
  Var
    LConsulta: TUniQuery;
    LCampo: TField;

Begin
  If Not FCamposLogMca.IsEmpty Then
    Exit;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT * FROM LOGMCA WHERE FALSE';
    LConsulta.Open;

    FCamposLogMca := '';
    FParametrosLogMca := '';

    For LCampo In LConsulta.Fields Do
    Begin
      FCamposLogMca := FCamposLogMca + LCampo.FieldName + ',';
      FParametrosLogMca := FParametrosLogMca + ':' + LCampo.FieldName + ',';
    End;

    FCamposLogMca := LeftStr(FCamposLogMca, FCamposLogMca.Length - 1);
    FParametrosLogMca := LeftStr(FParametrosLogMca, FParametrosLogMca.Length - 1);
  Finally
    TLibCartoesFuncoes.FreeAndNilDatasets(LConsulta);
  End;
End;

Initialization
  FCamposLogMca := EmptyStr;
  FParametrosLogMca := EmptyStr;

  FDataExecutavel := 0;

end.
