unit Contabilidade.View.FechamentoContabilEstorno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox,
  cxCheckGroup, Vcl.Mask, MaskEditFocus, EditFocus, untTypesSistema, Uni,
  Data.DB, Contabilidade.Interfaces, Contabilidade.Classes.Utils, System.DateUtils, cxCheckBox, System.Generics.Collections;

type
  TfrmFechamentoContabilEstorno = class(TfrmPaiContabilidade)
    Panel1: TPanel;
    lbPeriodoExercicio: TLabel;
    Label1: TLabel;
    edtEmpGrv: TEditFocus;
    edtNomEmpGrv: TEditFocus;
    rdgFormaFechamento: TRadioGroup;
    mskExercicio: TMaskEditFocus;
    chkGrpPeriodoFechamento: TcxCheckGroup;
    btnGerar: TBitBtnLocked;
    procedure edtEmpGrvKeyPress(Sender: TObject; var Key: Char);
    procedure rdgFormaFechamentoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure chkGrpPeriodoFechamentoPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FValidaCheckPeriodo: boolean;
    FPreviousStates: TcxCheckStates;
    FDicPeriodoFechamentos: TDictionary<TDateTime, TDateTime>;
    FblnTabelaEPREGTexiste: Boolean ;
    arrEmpSel: TConsultasArray;
    procedure pLimpaOpcoesFormaFechamento ;
    procedure pConfiguraFormaFechamento(const AstrCodEmp: String;
                                        const AintExercicio: Integer;
                                        const AblnBuscaPorChave: Boolean) ;
    procedure pCriaPeriodoCustomizadoFechamento(Const ATipoFechamento: TTipoFechamentoContabil) ;
    function fValidaOpcaoSelecionadaFormaFechamento: Boolean ;
    function fExercicio: integer;
    procedure pMontaDicionarioFechamentos;
    function fTemFechamento(const APeriodo: String): Boolean;
    function fTemPeriodosPosterioresComFechamento(const AdtaData: TDateTime; const AstrCodEmp: String): Boolean ;
    function fTemGapNoCheckGroup(const ACheckGroup: TcxCheckGroup): Boolean;
    function fValidarSelecaoParaExclusao: Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untFuncoesConsulta, Contabilidade.Funcoes ;

{$R *.dfm}

procedure TfrmFechamentoContabilEstorno.btnGerarClick(Sender: TObject);
var
  LobjFormaFec : TFormaFechamentoContabil;
  LdtaIni : TDateTime ;
  LdtaFin : TDateTime ;
  LintCnt : Integer ;
  LstrEmpresas: String;
  LdtaIniSetada: Boolean;
begin
  inherited;
  if not fValidaOpcaoSelecionadaFormaFechamento then
    exit;

  arrEmpSel := fObtemEmpresasFiliais(edtEmpGrv.Text) ;

  LstrEmpresas := fGetInEmpresas(arrEmpSel) ;

  If fEmptyStr(LstrEmpresas) Then
    Exit;

  LobjFormaFec := TFormaFechamentoContabil.Create(fExercicio, TTipoFechamentoContabil(rdgFormaFechamento.ItemIndex));
  try
    LdtaIniSetada := false;
    LdtaIni := Date ;
    LdtaFin := 0 ;
    for LintCnt := 0 to Pred(LobjFormaFec.Iteracoes) do
    begin
      if chkGrpPeriodoFechamento.States[LintCnt] <> cbsChecked then
        Continue ;
      If not LdtaIniSetada Then
      Begin
        LdtaIni := LobjFormaFec.DataInicial(LintCnt);
        LdtaIniSetada := True;
      End;
      LdtaFin := LobjFormaFec.DataFinal(LintCnt);
    end;

  finally
    FreeAndNil(LobjFormaFec) ;
  end ;

  if LdtaFin = 0 then
  begin
    fMensagem('ATENÇÃO!', 'Pelo menos um período deve ser selecionado!', ['&OK']);
    exit;
  end;

  if fTemPeriodosPosterioresComFechamento(LdtaFin, edtEmpGrv.Text) then
    exit ;

  if fExcluirFechamentos(LdtaIni, LdtaFin, edtEmpGrv.Text, True, False, nil, LstrEmpresas) then
  begin
    fMensagem('ATENÇÃO!', 'Exclusão dos fechamentos concluída com sucesso!', ['&OK']);
    pConfiguraFormaFechamento(edtEmpGrv.Text, StrToIntDef(mskExercicio.Text, 0), true) ;
  end;
end;

function TfrmFechamentoContabilEstorno.fValidarSelecaoParaExclusao: Boolean;
var
  LobjFormaFec : TFormaFechamentoContabil;
  LdtaFin : TDateTime ;
  LintCnt : Integer ;
  LdtaIniSetada: Boolean;

begin
  if not fValidaOpcaoSelecionadaFormaFechamento then
  begin
    Result := false;
    exit;
  end;

  LobjFormaFec := TFormaFechamentoContabil.Create(fExercicio, TTipoFechamentoContabil(rdgFormaFechamento.ItemIndex));
  try
    LdtaIniSetada := false;
    LdtaFin := 0 ;
    for LintCnt := 0 to Pred(LobjFormaFec.Iteracoes) do
    begin
      if chkGrpPeriodoFechamento.States[LintCnt] <> cbsChecked then
        Continue ;
      If not LdtaIniSetada Then
        LdtaIniSetada := True;

      LdtaFin := LobjFormaFec.DataFinal(LintCnt);
    end;

  finally
    FreeAndNil(LobjFormaFec) ;
  end ;

  if (LdtaFin <> 0) and (fTemPeriodosPosterioresComFechamento(LdtaFin, edtEmpGrv.Text)) then
  begin
    Result := False;
    exit ;
  end;

  Result := True;
end;

procedure TfrmFechamentoContabilEstorno.chkGrpPeriodoFechamentoPropertiesEditValueChanged(
  Sender: TObject);
  var I : integer;
begin
  inherited;
  if FValidaCheckPeriodo then
  begin
    if not fValidarSelecaoParaExclusao then
    begin
      FValidaCheckPeriodo := False;
      for I := 0 to chkGrpPeriodoFechamento.Properties.Items.Count - 1 do
        chkGrpPeriodoFechamento.States[I] := FPreviousStates[I];
      FValidaCheckPeriodo := True;
    end
    else
    begin
      for I := 0 to chkGrpPeriodoFechamento.Properties.Items.Count - 1 do
        FPreviousStates[I] := chkGrpPeriodoFechamento.States[I];
    end;
  end;
end;

procedure TfrmFechamentoContabilEstorno.edtEmpGrvKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpGrv, edtNomEmpGrv, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtEmpGrv) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFechamentoContabilEstorno.fExercicio: integer;
begin
  Result := StrToInt(mskExercicio.Text);
end;

procedure TfrmFechamentoContabilEstorno.pMontaDicionarioFechamentos;
var LqryConsulta: TUniQuery ;

begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close;
    LqryConsulta.SQL.Clear;
    LqryConsulta.SQL.Add(' SELECT CON_FECINI, CON_FECFIN ');
    LqryConsulta.SQL.Add('   FROM FECCON ');
    LqryConsulta.SQL.Add('  WHERE CON_CODEMP = :CODEMP ');
    LqryConsulta.SQL.Add('        AND CON_FECINI >= :FECINI ');
    LqryConsulta.SQL.Add('        AND CON_FECFIN <= :FECFIN ');
    LqryConsulta.SQL.Add('  ORDER BY CON_FECINI ');
    LqryConsulta.ParamByName('CODEMP').AsString := edtEmpGrv.Text;
    LqryConsulta.ParamByName('FECINI').AsDateTime := EncodeDate(StrToInt(mskExercicio.Text), 1, 1);
    LqryConsulta.ParamByName('FECFIN').AsDateTime := EncodeDate(StrToInt(mskExercicio.Text), 12, 31);
    LqryConsulta.Open;

    LqryConsulta.First;

    While not LqryConsulta.EOF do
    begin
      FDicPeriodoFechamentos.Add(LqryConsulta.FieldByName('CON_FECINI').AsDateTime, LqryConsulta.FieldByName('CON_FECFIN').AsDateTime);
      LqryConsulta.Next;
    end;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;

function TfrmFechamentoContabilEstorno.fTemFechamento(const APeriodo: String): Boolean;
var LdtInicio,
    LdtFim, LdtRetorno : TDateTime;

begin
  LdtInicio := fnow;
  LdtFim := fnow;
  if TTipoFechamentoContabil(rdgFormaFechamento.ItemIndex) = tfcTrimestral then
  begin
    if APeriodo = '1º Trimestre' then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 1, 1);
      LdtFim    := EncodeDate(StrToInt(mskExercicio.Text), 3, 31);
    end
    else if APeriodo = '2º Trimestre' then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 4, 1);
      LdtFim    := EncodeDate(StrToInt(mskExercicio.Text), 6, 30);
    end
    else if APeriodo = '3º Trimestre' then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 7, 1);
      LdtFim    := EncodeDate(StrToInt(mskExercicio.Text), 9, 30);
    end
    else if APeriodo = '4º Trimestre' then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 10, 1);
      LdtFim    := EncodeDate(StrToInt(mskExercicio.Text), 12, 31);
    end;
  end
  else
  if TTipoFechamentoContabil(rdgFormaFechamento.ItemIndex) = tfcMensal then
  begin
    if APeriodo.Contains('Jan') then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 1, 1);
      LdtFim    := Trunc(EndOfTheMonth(LdtInicio));
    end
    else if APeriodo.Contains('Fev') then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 2, 1);
      LdtFim    := Trunc(EndOfTheMonth(LdtInicio));
    end
    else if APeriodo.Contains('Mar') then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 3, 1);
      LdtFim    := Trunc(EndOfTheMonth(LdtInicio));
    end
    else if APeriodo.Contains('Abr') then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 4, 1);
      LdtFim    := Trunc(EndOfTheMonth(LdtInicio));
    end
    else if APeriodo.Contains('Mai') then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 5, 1);
      LdtFim    := Trunc(EndOfTheMonth(LdtInicio));
    end
    else if APeriodo.Contains('Jun') then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 6, 1);
      LdtFim    := Trunc(EndOfTheMonth(LdtInicio));
    end
    else if APeriodo.Contains('Jul') then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 7, 1);
      LdtFim    := Trunc(EndOfTheMonth(LdtInicio));
    end
    else if APeriodo.Contains('Ago') then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 8, 1);
      LdtFim    := Trunc(EndOfTheMonth(LdtInicio));
    end
    else if APeriodo.Contains('Set') then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 9, 1);
      LdtFim    := Trunc(EndOfTheMonth(LdtInicio));
    end
    else if APeriodo.Contains('Out') then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 10, 1);
      LdtFim    := Trunc(EndOfTheMonth(LdtInicio));
    end
    else if APeriodo.Contains('Nov') then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 11, 1);
      LdtFim    := Trunc(EndOfTheMonth(LdtInicio));
    end
    else if APeriodo.Contains('Dez') then
    begin
      LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 12, 1);
      LdtFim    := Trunc(EndOfTheMonth(LdtInicio));
    end;
  end
  else // Anual
  begin
    LdtInicio := EncodeDate(StrToInt(mskExercicio.Text), 1, 1);
    LdtFim    := EncodeDate(StrToInt(mskExercicio.Text), 12, 31);
  end;

  if FDicPeriodoFechamentos.TryGetValue(LdtInicio, LdtRetorno) and (LdtRetorno = LdtFim) then
    Result := true
  else
    Result := False;

end;

procedure TfrmFechamentoContabilEstorno.FormCreate(Sender: TObject);
begin
  inherited;
  FValidaCheckPeriodo := false;
  FDicPeriodoFechamentos := TDictionary<TDateTime,TDateTime>.Create();
  FblnTabelaEPREGTexiste := fTabelaExiste('EPREGT') ;
  if not FblnTabelaEPREGTexiste then
  begin
    rdgFormaFechamento.Enabled := True ;
    rdgFormaFechamento.ItemIndex := 0 ;
    pCriaPeriodoCustomizadoFechamento(TTipoFechamentoContabil(rdgFormaFechamento.ItemIndex)) ;
  end ;
  edtEmpGrv.Text := VS_strCodEmp;
  edtNomEmpGrv.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
end;

procedure TfrmFechamentoContabilEstorno.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FDicPeriodoFechamentos);
end;

function TfrmFechamentoContabilEstorno.fTemPeriodosPosterioresComFechamento(
  const AdtaData: TDateTime; const AstrCodEmp: String): Boolean;
var
  LqryConsulta: TUniQuery ;
  LstrLinha: String ;
  LstrMensagem: String ;
  LintNumeroLinhas: Integer ;
begin
  Result := False ;

  LqryConsulta := fCriaQuery() ;
  try

    LqryConsulta.Close;
    LqryConsulta.SQL.Clear;
    LqryConsulta.SQL.Add(' SELECT CON_FECINI, CON_FECFIN ');
    LqryConsulta.SQL.Add('   FROM FECCON ');
    LqryConsulta.SQL.Add('  WHERE CON_CODEMP = :CODEMP ');
    LqryConsulta.SQL.Add('        AND CON_FECINI > :FECINI ');
    LqryConsulta.SQL.Add('  ORDER BY CON_FECINI ');
    LqryConsulta.ParamByName('CODEMP').AsString := AstrCodEmp;
    LqryConsulta.ParamByName('FECINI').AsDateTime := AdtaData;
    LqryConsulta.Open;

    if not LqryConsulta.IsEmpty then
    begin
      LstrMensagem := '' ;
      LintNumeroLinhas := 0 ;
      LqryConsulta.First ;
      while not LqryConsulta.Eof do
      begin
        LstrLinha := DateToStr(LqryConsulta.FieldByName('CON_FECINI').AsDateTime) + ' - ' + DateToStr(LqryConsulta.FieldByName('CON_FECFIN').AsDateTime) + #13#10  ;
        LstrMensagem := LstrMensagem + LstrLinha ;
        LintNumeroLinhas := LintNumeroLinhas + 1 ;
        LqryConsulta.Next ;
      end ;

      fMensagem('Aviso',
                'Há fechamento contábil nos seguintes periodos:' + #13#10 + LstrMensagem + 'Faça a exclusão desses periodos primeiro!',
                ['&OK'],
                1,
                False,
                1,
                0,
                False,
                0,
                False,
                False,
                False,
                0,
                0,
                LintNumeroLinhas) ;

      Result := True ;
    end ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;

end;

function TfrmFechamentoContabilEstorno.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (mskExercicio.Visible) and (Sender = mskExercicio) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskExercicio.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O exercício deve ser preenchido!', ['&OK']);
        pLimpaOpcoesFormaFechamento ;
        Result := False;
      End
      else if (Length(mskExercicio.Text) <> 4) then
      begin
        fMensagem('ATENÇÃO!', 'Exercício inválido!', ['&OK']);
        pLimpaOpcoesFormaFechamento ;
        Result := False;
      end
      else if (StrToIntDef(mskExercicio.Text, 0) = 0) then
      begin
        fMensagem('ATENÇÃO!', 'Exercício inválido!', ['&OK']);
        pLimpaOpcoesFormaFechamento ;
        Result := False;
      end
      else
      begin
        if Not fEmptyStr(edtEmpGrv.Text) then
          pConfiguraFormaFechamento(edtEmpGrv.Text, StrToIntDef(mskExercicio.Text, 0), blnBuscaPorChave) ;
      end ;
    End
    Else If (Sender = edtEmpGrv) Then
    Begin
      If (Not fEmptyStr(edtEmpGrv.Text)) Then
      Begin
        edtNomEmpGrv.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpGrv.Text], False);
        If (fEmptyStr(edtNomEmpGrv.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          pLimpaOpcoesFormaFechamento ;
          Result := False;
        End
        else
        begin
          if Not fEmptyStr(mskExercicio.Text) then
            pConfiguraFormaFechamento(edtEmpGrv.Text, StrToIntDef(mskExercicio.Text, 0), blnBuscaPorChave) ;
        end ;
      End
      Else
      begin
        edtNomEmpGrv.Clear;
        fMensagem('ATENÇÃO!', 'Empresa de gravação deve ser preenchida!', ['&Ok']);
        pLimpaOpcoesFormaFechamento ;
        Result := False;
      end;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFechamentoContabilEstorno.fValidaOpcaoSelecionadaFormaFechamento: Boolean;
begin
  Result := False ;

  if rdgFormaFechamento.ItemIndex < 0 then
  begin
    fMensagem('ATENÇÃO!', '"Efetuar o Fechamento de Forma" deve estar selecionado!', ['&OK']);
    pSetFocus(mskExercicio) ;
    exit ;
  end ;

  if not fVerificaCampos then
    exit;

  if fTemGapNoCheckGroup(chkGrpPeriodoFechamento) then
  begin
    fMensagem('ATENÇÃO!', 'Por favor, selecione as opções de "Período de Fechamento" de forma contínua. Não pode haver lacunas entre as opções.', ['&OK']);
    pSetFocus(chkGrpPeriodoFechamento) ;
    exit
  end ;

  Result := True ;
end;

procedure TfrmFechamentoContabilEstorno.pConfiguraFormaFechamento(
  const AstrCodEmp: String; const AintExercicio: Integer;
  const AblnBuscaPorChave: Boolean);
var
  LqryCnf: TUniQuery ;
  LintFormtr: Integer ;
  LstrEncerr: String ;
begin
  if not FblnTabelaEPREGTexiste then
    Exit ;

  FValidaCheckPeriodo := False;
  LqryCnf := fCriaQuery() ;
  try
    LqryCnf.Close ;
    LqryCnf.SQL.Clear ;
    LqryCnf.SQL.Add(' SELECT TRI_FORMTR, TRI_ENCERR ') ;
    LqryCnf.SQL.Add(' FROM EPREGT ') ;
    LqryCnf.SQL.Add(' WHERE TRI_ANOEXE = :ANOEXE ') ;
    LqryCnf.SQL.Add('       AND TRI_CODEMP = :CODEMP ; ') ;
    LqryCnf.ParamByName('ANOEXE').AsInteger := AintExercicio ;
    LqryCnf.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqryCnf.Open ;

    if AblnBuscaPorChave then
      pLimpaOpcoesFormaFechamento ;

    if LqryCnf.IsEmpty then
    begin
      fMensagem('ATENÇÃO!', 'O Fechamento Contábil deverá ser realizado somente pela Empresa MATRIZ.' + #13+#10 + #13+#10 +
                            'Não há Parâmetros da "Forma de Tributação" para essa Empresa/Exercício.' + #13+#10 +
                            'Certifique-se que a Empresa é uma "Matriz", e efetue o preenchimento ' +
                            ' da "Forma  de  Tributação"  para  o  Exercício no  caminho ' + #13+#10 +
                            '"Principal > Manutenção de Cadastros >  Auxiliares >  Empresas" ' + #13+#10 +
                            ' na Aba "Contabilidade"', ['&OK'], 1, False, 1, 0, False, 0, False, False, False, 0, 0, 3);
      exit ;
    end
    else
    begin
      FDicPeriodoFechamentos.clear;
      pMontaDicionarioFechamentos;
      if AblnBuscaPorChave then
      begin
        LintFormtr := LqryCnf.FieldByName('TRI_FORMTR').AsInteger ;
        LstrEncerr :=  LqryCnf.FieldByName('TRI_ENCERR').AsString ;
        case LintFormtr of
          1, 2: rdgFormaFechamento.ItemIndex := 1 ;
          3   :
               begin
                 if LstrEncerr = 'A' then
                   rdgFormaFechamento.ItemIndex := 0
                 else
                   rdgFormaFechamento.ItemIndex := 2 ;
               end ;
          4   :
               begin
                 if LstrEncerr = 'A' then
                   rdgFormaFechamento.ItemIndex := 2
                 else if LstrEncerr = 'M' then
                   rdgFormaFechamento.ItemIndex := 0
                 else // T
                   rdgFormaFechamento.ItemIndex := 1 ;
               end ;
        end ;
        pCriaPeriodoCustomizadoFechamento(TTipoFechamentoContabil(rdgFormaFechamento.ItemIndex)) ;
      end ;
    end ;

  finally
    FreeAndNil(LqryCnf) ;
    FValidaCheckPeriodo := True;
  end ;
end;

procedure TfrmFechamentoContabilEstorno.pCriaPeriodoCustomizadoFechamento(
  const ATipoFechamento: TTipoFechamentoContabil);
var
  auxItem : TcxCheckGroupItem ;
  iMes, i : integer ;
  TemFechAnual: boolean;

begin
  chkGrpPeriodoFechamento.Properties.Items.BeginUpdate ;
  try
    ///limpar
    FValidaCheckPeriodo := false;
    chkGrpPeriodoFechamento.Properties.Items.Clear ;
    if ATipoFechamento in [tfcMensal, tfcAnual] then
    begin
      chkGrpPeriodoFechamento.Properties.Columns := 3 ;
      if ATipoFechamento = tfcAnual then
        TemFechAnual := fTEmFechamento('')
      else
        TemFechAnual := False;

      for iMes := 1 to 12 do
      begin
        auxItem := chkGrpPeriodoFechamento.Properties.Items.Add ;
        auxItem.Caption := fRetMes(iMes) ;
        if ATipoFechamento = tfcAnual then
        begin
          if TemFechAnual then
            chkGrpPeriodoFechamento.States[iMes-1] := cbsChecked
          else
            chkGrpPeriodoFechamento.States[iMes-1] := cbsUnChecked;
          auxItem.Enabled := false;
        end
        else
        begin
          if fTemFechamento(auxItem.Caption) then
            chkGrpPeriodoFechamento.States[iMes-1] := cbsChecked
          else
          begin
            chkGrpPeriodoFechamento.States[iMes-1] := cbsUnChecked;
            auxItem.Enabled := false;
          end;
        end;
      end;
    end
    else if ATipoFechamento = tfcTrimestral then
    begin
      chkGrpPeriodoFechamento.Properties.Columns := 2 ;

      auxItem := chkGrpPeriodoFechamento.Properties.Items.Add ;
      auxItem.Caption := '1º Trimestre' ;
      if fTemFechamento(auxItem.Caption) then
        chkGrpPeriodoFechamento.States[0] := cbsChecked
      else
      begin
        chkGrpPeriodoFechamento.States[0] := cbsUnChecked;
        auxItem.Enabled := false;
      end;

      auxItem := chkGrpPeriodoFechamento.Properties.Items.Add ;
      auxItem.Caption := '2º Trimestre' ;
      if fTemFechamento(auxItem.Caption) then
        chkGrpPeriodoFechamento.States[1] := cbsChecked
      else
      begin
        chkGrpPeriodoFechamento.States[1] := cbsUnChecked;
        auxItem.Enabled := false;
      end;

      auxItem := chkGrpPeriodoFechamento.Properties.Items.Add ;
      auxItem.Caption := '3º Trimestre' ;
      if fTemFechamento(auxItem.Caption) then
        chkGrpPeriodoFechamento.States[2] := cbsChecked
      else
      begin
        chkGrpPeriodoFechamento.States[2] := cbsUnChecked;
        auxItem.Enabled := false;
      end;

      auxItem := chkGrpPeriodoFechamento.Properties.Items.Add ;
      auxItem.Caption := '4º Trimestre' ;
      if fTemFechamento(auxItem.Caption) then
        chkGrpPeriodoFechamento.States[3] := cbsChecked
      else
      begin
        chkGrpPeriodoFechamento.States[3] := cbsUnChecked;
        auxItem.Enabled := false;
      end;


    end;

  finally
    chkGrpPeriodoFechamento.Properties.Items.EndUpdate ;
  end;

  SetLength(FPreviousStates, chkGrpPeriodoFechamento.Properties.Items.Count);
  for I := 0 to chkGrpPeriodoFechamento.Properties.Items.Count - 1 do
    FPreviousStates[I] := chkGrpPeriodoFechamento.States[I];
  FValidaCheckPeriodo := true;
end;

procedure TfrmFechamentoContabilEstorno.pLimpaOpcoesFormaFechamento;
begin
  rdgFormaFechamento.ItemIndex := -1 ;
  chkGrpPeriodoFechamento.Properties.Items.Clear ;
end;

procedure TfrmFechamentoContabilEstorno.rdgFormaFechamentoClick(
  Sender: TObject);
begin
  inherited;
  pCriaPeriodoCustomizadoFechamento(TTipoFechamentoContabil(TRadioGroup(Sender).ItemIndex)) ;
end;

function TfrmFechamentoContabilEstorno.fTemGapNoCheckGroup(
  const ACheckGroup: TcxCheckGroup): Boolean;
var
  LCnt: Integer;
  LPrimeiroMarcado: Integer;
  LUltimoMarcado: Integer;
begin
  LPrimeiroMarcado := -1;
  LUltimoMarcado := -1;

  for LCnt := 0 to ACheckGroup.Properties.Items.Count - 1 do
  begin
    if ACheckGroup.States[LCnt] = cbsChecked then
    begin
      if LPrimeiroMarcado = -1 then
        LPrimeiroMarcado := LCnt;

      LUltimoMarcado := LCnt;
    end;
  end;

  if (LPrimeiroMarcado = -1) or (LPrimeiroMarcado = LUltimoMarcado) then
    Exit(False);

  for LCnt := LPrimeiroMarcado to LUltimoMarcado do
  begin
    if ACheckGroup.States[LCnt] <> cbsChecked then
      Exit(True);
  end;

  Result := False;
end;

end.
