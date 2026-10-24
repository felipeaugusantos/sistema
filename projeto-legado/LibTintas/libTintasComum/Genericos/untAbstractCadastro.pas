{**********************************************************************************}
{* TAbstractCadastro: Classe abstrata contendo os metodos em comum de um cadastro *}
{******************************************************************************PH**}
unit untAbstractCadastro;

interface

uses
  untLibTintaFactory, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, Classes, untIDataSet,
  untTipoCadastro, untTipoTinta, StrUtils, Math, SysUtils, untStrUtils, untAutcomTintaFactory,
  untTypesSistema;

type
  TAbstractCadastro = class abstract(TInterfacedObject, ICadLibTintas)
  private
    lstControles: IInterfaceList;
    qryCadastro: IDataSet;
    function GetControles: IInterfaceList;
  protected
    function AdicionarControle(const libTintaControleVisual: ILibTintaControleVisual): Integer;
    procedure ConstruirControles; virtual;
  public
    blnAlterou: Boolean;
    constructor Create();
    function GetIdePro: string; virtual;
    function GetTitulo: string; virtual; abstract;
    function GetConsulta: IConsulta; virtual; abstract;
    function GetCamposDesabilitadosEdit: TCadLibTintasStringArray; virtual; abstract;
    function GetClassName: string;
    function GetNomeCampo: string; virtual; abstract;
    function GetNomeTabela: string; virtual; abstract;
    function GetLibTintaControleVisual(const index: Integer): ILibTintaControleVisual; overload;
    function GetLibTintaControleVisual(const strNome: string): ILibTintaControleVisual; overload;
    function GetLibTintaControleVisualCont: Integer;
    function GetNomeCampoRelacionamento: string; virtual; abstract;
    procedure pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string); virtual; abstract;
    procedure SetQueryCadastro(const dataSet: IDataSet);
    function GetQueryCadastro: IDataSet;
    function fGetCampoChave(const index: Integer): string; virtual; abstract;
    function fGetCountCamposChave: Integer; virtual; abstract;
    procedure CarregarDescricoes(const tela: ITelaCadLibTintas); virtual; abstract;
    function fVerificaNovFormulas(strCodNfm: String): Boolean; Virtual;
    function fValidaCampos(const tela: ITelaCadLibTintas;
      strNomeCampo: string; strValorCampo: string;
      var strRetorno: string): Boolean; virtual; abstract;
    procedure FormatarCampo(const strNomeCampo: string;
      var arrPropriedades: TCadLibTintasStringArray;
      var arrValores: TCadLibTintasVariantArray); virtual; abstract;
    procedure AjustarTela(const tela: ITelaCadLibTintas); virtual;
    procedure IncluirAntes(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure GravarDepois(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure AlterarAntes(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure AlterarDepois(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure ExcluirAntes(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure CancelarAntes(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure CancelarDepois(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure PesquisarDepois(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure AtivarNovasFormulas(const tela: ITelaCadLibTintas; const strState: string); virtual;

    function VerificaDataBalanco(qryCadastro: IDataSet; strIniTab: String): Boolean; Virtual;
    procedure MensagemInfoDtaBalanco(); Virtual;
    function fVerificaBasPesAntigo(qryCadastro: IDataSet; strValorCampo: String; strTabela: String; strCampo: String; strCamEmb: String = ''; strCamEsp: String  = ''): Boolean; Virtual;
    function fVerificaFatorTintometrico(qryCadastro: IDataSet): Boolean; Virtual;



    function GetTipoCadastro: TTipoCadastro; virtual; abstract;
    function GetTipoTinta: TTipoTinta; virtual; abstract;

    function fPodeAlterar: Boolean; virtual; abstract;
    function fPodeExcluir: Boolean; virtual; abstract;

    function fPodeGravar(const tela: ITelaCadLibTintas; const strState: String): Boolean; Virtual;
    function fPodeIncluir(const tela: ITelaCadLibTintas; const strState: String): Boolean; Virtual;

    function GetNomeCampoItem: string; virtual; abstract;

    function GetNomeCampoUnidade: string; virtual; abstract;

//    function GetCampoEmbalagem: string; virtual; abstract;
//    function GetCampoPesoEspecifico: string; virtual; abstract;

    function GetPreencherDbComboBox: Boolean; virtual;
    function GetDescDbComboBox: String; virtual;

    function GetPreencherComboBox: Boolean; virtual;
    function GetDescComboBox: String; virtual;

    function GetPreencherDBRadioGroup(): Boolean; Virtual;
    procedure pAjustarRadioGroup(const tela: ITelaCadLibTintas; stlItems: TStrings); Virtual;
    function fGetLetrasIndisponivel(strLetras: String): Boolean; Virtual;
    function fGetLetrasAnteriores(strLetras: String): Boolean; Virtual;
    function fCalculaOncaParaMl(strTipOnc: String; strOnca: String): Double; Virtual;
    function fGetValorPulsosMl(strValor: String): Boolean;
    function fGetValorInteiro(strValor: String): Boolean;
    procedure pLimparQuantidades(GetQueryCadastro: IDataSet); Virtual;
    procedure pAjustarCamposMl(tela: ITelaCadLibTintas); virtual;
    procedure pAjustarCamposOnca(tela: ITelaCadLibTintas); virtual;
    procedure AjustarCampos(Tela: ITelaCadLibTintas); virtual;
    function fValidaUnidadeItem(strProduto: String; strUnidade: String): Boolean; Virtual;

    function fGetArrayTipos: TCadLibTintasStringArray; virtual;
    function fGetArrayLinhas: TCadLibTintasStringArray; virtual;

    function GetTipoFormula(): Boolean; Virtual;
    procedure PreencherTipoFormula(const tela: ITelaCadLibTintas; Items: TStrings); Virtual;
    procedure FormataEmbalagem(qryCadastro: IDataSet; strValor: String; strTabela: String = ''; strCampo: String = ''); Virtual;
  end;

implementation

{ TAbstractCadastroSuvinil }

function TAbstractCadastro.AdicionarControle(
  const libTintaControleVisual: ILibTintaControleVisual): Integer;
begin
  Result := GetControles.Add(libTintaControleVisual);
end;

procedure TAbstractCadastro.AjustarCampos(Tela: ITelaCadLibTintas);
begin
  //
end;

procedure TAbstractCadastro.AjustarTela(const tela: ITelaCadLibTintas);
begin

end;

procedure TAbstractCadastro.AlterarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.AlterarDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.AtivarNovasFormulas(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.CancelarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.CancelarDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.ConstruirControles;
begin
end;

constructor TAbstractCadastro.Create;
begin
  inherited Create;
  ConstruirControles;
end;

procedure TAbstractCadastro.ExcluirAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

function TAbstractCadastro.fCalculaOncaParaMl(strTipOnc,
  strOnca: String): Double;
Var
  intInteiro: Integer;
  fltFracao: Double;
  strInteiro: String;
  strFracao: String;
  intY: Integer;
  strCalculo: String;
  strCalculo1: String;
begin
  Result := 0;
  intY := Pos('Y', strOnca);

  If strTipOnc = 'A' Then //Americana
  Begin
    strInteiro := Copy(strOnca, 1, intY - 1);
    intInteiro := StrToInt(strInteiro); //Numero Inteiro da Onça

    strFracao := Copy(strOnca, intY + 1, Length(strOnca));
    fltFracao := StrToFloat(strFracao);

    strCalculo := FloatToStrF(intInteiro * 28.4130742283722, ffNumber, 12, 2);
    strCalculo1 := FloatToStrF(fltFracao * 28.4130742283722 / 48, ffNumber, 12, 2);

    strCalculo := AnsiReplaceStr(strCalculo, '.', '');
    strCalculo1 := AnsiReplaceStr(strCalculo1, '.', '');

    Result := StrToFloat(strCalculo) + StrToFloat(strCalculo1);
  End
  Else
  If strTipOnc = 'I' Then //Inglesa
  Begin
    strInteiro := Copy(strOnca, 1, intY - 1);
    intInteiro := StrToInt(strInteiro);

    strFracao := Copy(strOnca, intY + 1, Length(strOnca));
    fltFracao := StrToFloat(strFracao);




    strCalculo := FloatToStrF(intInteiro * 29.5735295641119, ffNumber, 12, 2);
    strCalculo1 := FloatToStrF(fltFracao * 29.5735295641119 / 48, ffNumber, 12, 2);

    strCalculo := AnsiReplaceStr(strCalculo, '.', '');
    strCalculo1 := AnsiReplaceStr(strCalculo1, '.', '');

    Result := StrToFloat(strCalculo) + StrToFloat(strCalculo1);
  End;
end;

function TAbstractCadastro.fGetArrayLinhas: TCadLibTintasStringArray;
begin
  Result := Nil;
end;

function TAbstractCadastro.fGetArrayTipos: TCadLibTintasStringArray;
begin
  Result := Nil;
end;

function TAbstractCadastro.fGetLetrasAnteriores(strLetras: String): Boolean;
Var
  intCont: Integer;
  strPos: String;
  intPos: Integer;
  stlPos: TStringList;
begin
  {*******************************************}
  {VERIFICA A PARTE INTEIRA DO CALCULO DA ONÇA}
  {*****************************************RG}


  Result := False;

  intPos := Pos('Y', strLetras);

  strPos := Copy(strLetras, 1, intPos);

  stlPos := TStringList.Create;

  For intCont := 1 To intPos Do
    stlPos.Add(Copy(strPos, intCont, 1));


  For intCont := 0 To stlPos.Count - 1 Do
  Begin
    If Pos(stlPos[intCont], 'A_B_C_D_E_F_G_H_I_J_K_L_M_N_O_P_K_R_S_T_U_V_W_X_Z_._,_') > 0 Then
      Result := True;

    If intCont < (intPos - 1) Then
    Begin
      If Pos(stlPos[intCont], 'Y_y_') > 0 Then
      Begin
        Result := True;
        Exit;
      End;
    End;
  End;

  FreeAndNil(stlPos);
end;

function TAbstractCadastro.fGetLetrasIndisponivel(strLetras: String): Boolean;
Var
  intPos: Integer;
  strPos: String;
  stlPos: TStringList;
  intCont: Integer;
begin
  {**********************************************}
  {VERIFICA A PARTE FRACIONADA DO CALCULO DA ONÇA}
  {********************************************RG}

  Result := False;

  intPos := Pos('Y', strLetras);

  If intPos = 0 Then
  Begin
    Result := True;
    Exit;
  End;

  If fGetLetrasAnteriores(strLetras) Then
  Begin
    Result := True;
    Exit;
  End;

  strPos := Copy(strLetras, intPos, Length(strLetras) - (intPos - 1));

  stlPos := TStringList.Create;

  For intCont := 1 To (Length(strLetras) - (intPos - 1)) Do
    stlPos.Add(Copy(strPos, intCont, 1));

  For intCont := 0 To stlPos.Count - 1 Do
  Begin
    If Pos(stlPos[intCont], 'A_B_C_D_E_F_G_H_I_J_K_L_M_N_O_P_K_R_S_T_U_V_X_W_Z_Ç_._') > 0 Then
      Result := True;

    If IntCont > 0 Then
    Begin
      If Pos(stlPos[intCont], 'Y_y_') > 0 Then
      Begin
        Result := True;
        Break;
      End;
    End;
  End;

  FreeAndNil(stlPos);
end;

function TAbstractCadastro.fGetValorInteiro(strValor: String): Boolean;
Var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To Length(strValor) Do
  Begin
    If Not (CharInSet(strValor[IntCont],['0'..'9'])) Then   //Valor Inteiro
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TAbstractCadastro.fGetValorPulsosMl(strValor: String): Boolean;
Var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To Length(strValor) Do
  Begin
    If Not (CharInSet(strValor[IntCont],['0'..'9', ','])) Then   //Valor Decimal
    Begin
      Result := True;
      Break;
    End;

    If strValor[1] = ',' Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

procedure TAbstractCadastro.FormataEmbalagem(qryCadastro: IDataSet; strValor: String; strTabela: String; strCampo: String);
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '';
    qryGen.SQL := qryGen.SQL + '  SELECT            ';
    qryGen.SQL := qryGen.SQL + '    *               ';
    qryGen.SQL := qryGen.SQL + '  FROM              ';
    qryGen.SQL := qryGen.SQL + '    TABTIN          ';
    qryGen.SQL := qryGen.SQL + '  WHERE             ';
    qryGen.SQL := qryGen.SQL + '    TIN_TABELA = "' + strTabela + '"  AND     ';
    qryGen.SQL := qryGen.SQL + '    TIN_CAMPO_ = "' + strCampo +  '"  AND     ';
    qryGen.SQL := qryGen.SQL + '    TIN_OPCCOM = "' + strValor +  '"          ';
    qryGen.Open;

    qryCadastro.FieldByName(strCampo).AsFloat := qryGen.FieldByName('TIN_VALCOM').AsFloat;
  Except
    Raise;
  End;
end;

function TAbstractCadastro.fPodeGravar(const tela: ITelaCadLibTintas; const strState: String): Boolean;
begin
  Result := True;
end;

function TAbstractCadastro.fPodeIncluir(const tela: ITelaCadLibTintas;
  const strState: String): Boolean;
begin
  Result := true;
end;

function TAbstractCadastro.fValidaUnidadeItem(strProduto: String; strUnidade: String): Boolean;
Var
  qryCadIte: IDataSet;
begin
  If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('BASUNI') = 'S' Then
    Exit(True);

  If TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('BASUNI')) Then
    Exit(True);

  Result := True;

  qryCadIte := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadIte.Close;
  qryCadIte.SQL := '  SELECT U.UNI_SIGUNI AS SIGUNI  ' +
                   '    FROM CADITE I             ' +
                   '  INNER JOIN CADUNI U ON      ' +
                   '    U.UNI_CODUNI = I.ITE_CODUNI ' +
                   '  WHERE ITE_CODITE = :CODITE  ';
  qryCadIte.ParamByName('CODITE').AsString := strProduto;
  qryCadIte.Open;

  If qryCadIte.FieldByName('SIGUNI').AsString <> strUnidade Then
  Begin
    Result := False;
    Exit;
  End
end;

function TAbstractCadastro.fVerificaBasPesAntigo(qryCadastro: IDataSet; strValorCampo: String;
  strTabela: String; strCampo: String; strCamEmb: String; strCamEsp: String): Boolean;
Var
  qryGen: IDataSet;
  strSQL: String;
begin
  Result := True;

  strSQL := '';
  strSQL := '   SELECT * FROM ' + strTabela;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := strSQL;
  qryGen.Open;

  If Not qryGen.Locate(strCampo, qryCadastro.FieldByName(strCampo).AsString, []) Then
  Begin
    Result := True;
    Exit;
  End;

  If Not TStrUtils.fEmptyStr(strCamEmb) Then
  Begin
    qryCadastro.FieldByName(strCamEmb).AsString := strValorCampo;

    If qryGen.FieldByName(strCamEmb).AsString <> qryCadastro.FieldByName(strCamEmb).AsString Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  If Not TStrUtils.fEmptyStr(strCamEsp) Then
  Begin
    qryCadastro.FieldByName(strCamEsp).AsFloat := StrToFloat(strValorCampo);

    If qryGen.FieldByName(strCamEsp).AsFloat <> qryCadastro.FieldByName(strCamEsp).AsFloat Then
    Begin
      Result := False;
      Exit;
    End;
  End;
end;

function TAbstractCadastro.fVerificaFatorTintometrico(
  qryCadastro: IDataSet): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := ' SELECT ITE_CNV_ML FROM CADITE WHERE ITE_CODITE = :CODITE    ';
  qryGen.ParamByName('CODITE').AsString := qryCadastro.FieldByName(GetNomeCampoItem).AsString;
  qryGen.Open;

  Result := (TStrUtils.fEmptyStr(qryGen.FieldByName('ITE_CNV_ML').AsString)) Or (qryGen.FieldByName('ITE_CNV_ML').AsFloat <= 0);
end;


function TAbstractCadastro.fVerificaNovFormulas(strCodNfm: String): Boolean;
begin
  Result := False;
end;

function TAbstractCadastro.GetClassName: string;
begin
  Result := Self.ClassName;
end;

function TAbstractCadastro.GetControles: IInterfaceList;
begin
  if not Assigned(lstControles) then
  begin
    lstControles := TInterfaceList.Create;
  end;

  Result := lstControles;
end;

function TAbstractCadastro.GetDescComboBox: String;
begin
  Result := '';
end;

function TAbstractCadastro.GetDescDbComboBox: String;
begin
  Result := '';
end;

function TAbstractCadastro.GetIdePro: string;
begin
  Result := TLibTintaFactory.GetLibTinta.GetIdePro;
end;

function TAbstractCadastro.GetLibTintaControleVisual(
  const index: Integer): ILibTintaControleVisual;
begin
  Result := GetControles[index] as ILibTintaControleVisual;
end;

function TAbstractCadastro.GetLibTintaControleVisual(
  const strNome: string): ILibTintaControleVisual;
var
  intCont: Integer;
begin
  Result := nil;

  for intCont := 0 to GetControles.Count - 1 do
  begin
    if (GetControles[intCont] as ILibTintaControleVisual).Nome = strNome then
    begin
      Result := GetControles[intCont] as ILibTintaControleVisual;
      Exit;
    end;
  end;

end;

function TAbstractCadastro.GetLibTintaControleVisualCont: Integer;
begin
  Result := GetControles.Count;
end;

function TAbstractCadastro.GetPreencherComboBox: Boolean;
begin
  Result := false;
end;

function TAbstractCadastro.GetPreencherDbComboBox: Boolean;
begin
  Result := False;
end;

function TAbstractCadastro.GetPreencherDBRadioGroup: Boolean;
begin
  Result := False;
end;

function TAbstractCadastro.GetQueryCadastro: IDataSet;
begin
  Result := qryCadastro;
end;

function TAbstractCadastro.GetTipoFormula: Boolean;
begin
  Result := False;
end;

procedure TAbstractCadastro.GravarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.GravarDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.IncluirAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.MensagemInfoDtaBalanco();
Var
  arrMensagem: TStringArray;
begin
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------');
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'Para alterar peso específico e/ou embalagem, é necessário realizar Digitação de Saldo de Balanço através do menu');
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, '[ Operações Ref. a Produtos > Digitação de Saldo de Balanço ]. ');
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------');
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, '1) Se houver movimento de entrada/saída deste produto no dia de hoje, esta operação deve ser feita no final do ');
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'dia e deve ser informado o dia de hoje na data de balanço, pois a digitação da data de hoje na data de balanço');
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'irá permitir nova movimentação somente a partir de amanhã.');
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, '2) Se não houver movimento de entrada/saída deste produto no dia de hoje, esta operação pode ser feita agora e ');
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'deve ser informado o dia de ontem na data de balanço.');
  TAutcomTintaFactory.Get.pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------');

  TAutcomTintaFactory.Get.fMensagemTabela('ATENÇÃO!', 'AVISO', arrMensagem, '', ['&Ok'], 1, True, 1, 827, False, 0, False, False, False, 20, 360, 850, True);
end;

procedure TAbstractCadastro.pAjustarCamposMl(tela: ITelaCadLibTintas);
begin

end;

procedure TAbstractCadastro.pAjustarCamposOnca(tela: ITelaCadLibTintas);
begin

end;

procedure TAbstractCadastro.pAjustarRadioGroup(const tela: ITelaCadLibTintas; stlItems: TStrings);
begin
  //
end;

procedure TAbstractCadastro.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.PesquisarDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.pLimparQuantidades(GetQueryCadastro: IDataSet);
Var
  intCont: Integer;
  intPonto: Integer;
  strQtd: String;
  strInicio: String;
begin
  For intCont := 1 To 20 Do
  Begin
    strQtd := GetQueryCadastro.FieldByName('NFM_QTDX' + TStrUtils.fStrZero(intCont, 2)).AsString;
    strInicio := Copy(GetQueryCadastro.FieldByName('NFM_QTDX' + TStrUtils.fStrZero(intCont, 2)).AsString, 1, 1);

    If (Pos('0.00', GetQueryCadastro.FieldByName('NFM_QTDX' + TStrUtils.fStrZero(intCont, 2)).AsString) > 0)  And
       (strInicio = '0') Then
    Begin
      GetQueryCadastro.FieldByName('NFM_QTDX' + TStrUtils.fStrZero(intCont, 2)).AsString := '';
    End
    Else
    Begin
      intPonto := Pos('.', GetQueryCadastro.FieldByName('NFM_QTDX' + TStrUtils.fStrZero(intCont, 2)).AsString);

      If intPonto = 0 Then
        Continue;


      GetQueryCadastro.FieldByName('NFM_QTDX' + TStrUtils.fStrZero(intCont, 2)).AsString := Copy(strQtd, 1, intPonto - 1);
    End;
  End;
end;

procedure TAbstractCadastro.PreencherTipoFormula(const tela: ITelaCadLibTintas;
  Items: TStrings);
begin
  //
end;

procedure TAbstractCadastro.SetQueryCadastro(
  const dataSet: IDataSet);
begin
  Self.qryCadastro := dataSet;
end;

function TAbstractCadastro.VerificaDataBalanco(qryCadastro: IDataSet; strIniTab: String): Boolean;
Var
  qryGen: IDataSet;
  DataHoje: TDate;
  DataOntem: TDate;
begin
  Result := True;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT            ';
  qryGen.SQL := qryGen.SQL + '    ITE_DTABAL      ';
  qryGen.SQL := qryGen.SQL + '  FROM              ';
  qryGen.SQL := qryGen.SQL + '    ITEGER          ';
  qryGen.SQL := qryGen.SQL + '  WHERE             ';
  qryGen.SQL := qryGen.SQL + '    ITE_CODITE = :CODITE   AND        ';
  qryGen.SQL := qryGen.SQL + '    ITE_CODEMP = :CODEMP              ';

  qryGen.ParamByName('CODITE').AsString := qryCadastro.FieldByName(strIniTab + '_CODITE').AsString;
  qryGen.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryGen.Open;

  If qryGen.IsEmpty Then
  Begin
    Result := True;
    Exit;
  End;

  DataHoje  := Date;
  DataOntem := Date - 1;

  If qryGen.FieldByName('ITE_DTABAL').AsDate <> DataHoje Then
  Begin
    If qryGen.FieldByName('ITE_DTABAL').AsDate = DataOntem Then
    Begin
      Result := True;
      Exit;
    End
    Else
    Begin
      Result := False;
      Exit;
    End;
  End;
end;

end.
