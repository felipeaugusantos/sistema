unit untCalEstMin;

interface

uses
  Windows, Classes, Controls, untPai, ComCtrls, StdCtrls, EditFocus, Menus, Buttons,
  ExtCtrls, untFuncoesSimples, Uni, AppEvnts, CheckLst, cxPC, cxControls,
  BitBtnLockedIncrem, cxPCdxBarPopupMenu, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, untTypesSistema, dxBarBuiltInMenu,
  frxClass, frxExportCSVTestabilidade, untAltEst, CxProgressBar, untGravando,
  Vcl.Mask, MaskEditFocus, UniClientDataSet, Data.DB, untMesesGiro, DBAccess;

type
  TfrmCalEstMin = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    pgbStatus: TProgressBar;
    shpMultSel: TShape;
    Label4: TLabel;
    lstEmpresas: TCheckListBox;
    pgcOpcao: TcxPageControl;
    TSCalGer: TcxTabSheet;
    TSCalABC: TcxTabSheet;
    pnlCalcGeral: TPanel;
    Label2: TLabel;
    edtDiaEst: TEditFocus;
    pnlCalcABC: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtDiaEstA: TEditFocus;
    edtDiaEstB: TEditFocus;
    edtDiaEstC: TEditFocus;
    edtFatGer: TEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    edtFatA: TEditFocus;
    lbl1: TLabel;
    edtQtdMes: TEditFocus;
    lbl2: TLabel;
    edtQtdMesABC: TEditFocus;
    btnGerar: TBitBtnLocked;
    TSCalXYZ: TcxTabSheet;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtDiaEstZ: TEditFocus;
    edtDiaEstY: TEditFocus;
    edtDiaEstX: TEditFocus;
    edtFatZ: TEditFocus;
    edtQtdMesXYZ: TEditFocus;
    Label14: TLabel;
    edtFatB: TEditFocus;
    Label15: TLabel;
    edtFatC: TEditFocus;
    Label16: TLabel;
    edtFatY: TEditFocus;
    Label17: TLabel;
    edtFatX: TEditFocus;
    Label18: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    Label19: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    Label167: TLabel;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    Label20: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    Label21: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    rdgTipMed: TRadioGroup;
    Label22: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    chkMostrarPrevia: TCheckBox;
    chkCalcEst: TCheckBox;
    rdgCalcEst: TRadioGroup;
    chkInfMes: TCheckBox;
    lblSelMes: TLabel;
    chkInfMesABC: TCheckBox;
    lblSelMesABC: TLabel;
    chkInfMesXYZ: TCheckBox;
    lblSelMesXYZ: TLabel;
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure lstEmpresasEnter(Sender: TObject);
    procedure lstEmpresasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtFatGerKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdMesChange(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure chkMostrarPreviaClick(Sender: TObject);
    procedure edtFatGerExit(Sender: TObject);
    procedure chkCalcEstClick(Sender: TObject);
    procedure lblSelMesClick(Sender: TObject);
    procedure chkInfMesClick(Sender: TObject);
    procedure chkInfMesABCClick(Sender: TObject);
    procedure chkInfMesXYZClick(Sender: TObject);
    procedure lblSelMesABCClick(Sender: TObject);
    procedure lblSelMesXYZClick(Sender: TObject);
  private
    { Private declarations }
    objAltEst: TAltEst;
    intQtdMes: Integer;
    arrFornecedor,
    arrLinhaGrupo,
    arrMarca,
    arrGrupoPro,
    arrGruCmp,
    arrCodDep,
    arrCodIte : TConsultasArray;
    cdsMeses  : TMesesGiro;
    strMeses  : String;
    strCamGir : String;
    strSQLGiro: String;

    strFornecedor,
    strEmpresa,
    strLinGru,
    strMarca ,
    strPrdGru,
    strCodDep,
    strGruCmp,
    strCodIte : String;

    qryItens,
    qryUpdate,
    qryInsLog: TUniQuery;

    frmGravando: TfrmGravando;

    procedure pAtualizaLst;

    Function fSQLEstMin(strDiaEst: String): String;
    Function fAtualizaPrg(prgProgresso: TCxProgressBar): Boolean;
    Function fAtualiza: Boolean;
    procedure pMontarSelectPreviewOrUpdate(out ASql : String; blnPorItem: Boolean = False);
    procedure pSetarParametros(var AQuery: TUniQuery; const AQtdDia : Integer);
    procedure pGerarStrEstMin(var ASql : String);
    procedure pGerarEstMaxABC(var ASql : String);
    procedure pGerarEstMaxXYZ(var ASql : String);
    procedure pPrepararPreview(var ADados : TUniClientDataSet; ASqlPrevia : String; AProgresso: TCxProgressBar);
    function fRetNroMeses: Integer;

    Function fSQLCarregaItensEmpresa: String;
    Function fSQLFiltros: String;
    procedure pSetaFiltros(AQuery: TUniQuery);

    Procedure pCarregaItens;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses SysUtils, Math, Forms, strUtils, untConsultas, untFuncoesConsulta,
  UniDataSetProvider, untCalEstMinPreview;

{$R *.dfm}

{*****************}
{* VALIDA CAMPOS *}
{**************AF*}
function TfrmCalEstMin.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtDiaEst) And (pgcOpcao.ActivePage = TSCalGer) Then
  Begin
    If (fEmptyStr(edtDiaEst.Text)) Then
    Begin
      pgcOpcao.ActivePage := TSCalGer;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo" deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtDiaEst.Text) <= 0) Then
    Begin
      pgcOpcao.ActivePage := TSCalGer;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo" deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtDiaEstA) And (pgcOpcao.ActivePage = TSCalABC) Then
  Begin
    If (fEmptyStr(edtDiaEstA.Text)) Then
    Begin
      pgcOpcao.ActivePage := TSCalABC;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo de produtos Nível A" deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtDiaEstA.Text) <= 0) Then
    Begin
      pgcOpcao.ActivePage := TSCalABC;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo de produtos Nível A" deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtDiaEstZ) And (pgcOpcao.ActivePage = TSCalXYZ) Then
  Begin
    If (fEmptyStr(edtDiaEstZ.Text)) Then
    Begin
      pgcOpcao.ActivePage := TSCalXYZ;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo de produtos Nível Z" deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtDiaEstZ.Text) <= 0) Then
    Begin
      pgcOpcao.ActivePage := TSCalXYZ;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo de produtos Nível Z" deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtDiaEstB) And (pgcOpcao.ActivePage = TSCalABC) Then
  Begin
    If (fEmptyStr(edtDiaEstB.Text)) Then
    Begin
      pgcOpcao.ActivePage := TSCalABC;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo de produtos Nível B" deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtDiaEstB.Text) <= 0) Then
    Begin
      pgcOpcao.ActivePage := TSCalABC;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo de produtos Nível B" deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtDiaEstY) And (pgcOpcao.ActivePage = TSCalXYZ) Then
  Begin
    If (fEmptyStr(edtDiaEstY.Text)) Then
    Begin
      pgcOpcao.ActivePage := TSCalXYZ;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo de produtos Nível Y" deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtDiaEstY.Text) <= 0) Then
    Begin
      pgcOpcao.ActivePage := TSCalXYZ;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo de produtos Nível Y" deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtDiaEstC) And (pgcOpcao.ActivePage = TSCalABC) Then
  Begin
    If (fEmptyStr(edtDiaEstC.Text)) Then
    Begin
      pgcOpcao.ActivePage := TSCalABC;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo de produtos Nível C" deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtDiaEstC.Text) <= 0) Then
    Begin
      pgcOpcao.ActivePage := TSCalABC;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo de produtos Nível C" deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtDiaEstX) And (pgcOpcao.ActivePage = TSCalXYZ) Then
  Begin
    If (fEmptyStr(edtDiaEstX.Text)) Then
    Begin
      pgcOpcao.ActivePage := TSCalXYZ;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo de produtos Nível X" deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtDiaEstX.Text) <= 0) Then
    Begin
      pgcOpcao.ActivePage := TSCalXYZ;
      fMensagem('ATENÇÃO!', 'O campo "Dias para estoque mínimo de produtos Nível X" deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtQtdMes) And (pgcOpcao.ActivePage = TSCalGer) Then
  Begin
    If (fEmptyStr(edtQtdMes.Text)) Then
    Begin
      pgcOpcao.ActivePage := TSCalGer;
      fMensagem('ATENÇÃO!', 'O campo "Qtd. Meses para cálculo da média" deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtQtdMes.Text) < 1) Or (fStrToFloat(edtQtdMes.Text) > 12) Then
    Begin
      pgcOpcao.ActivePage := TSCalGer;
      fMensagem('ATENÇÃO!', 'O campo "Qtd. Meses para cálculo da média" deve ser entre 1 e 12!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatGer) And (pgcOpcao.ActivePage = TSCalGer) Then
  Begin
    If fStrToFloat(edtFatGer.Text) = 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Fator para cálculo estoque máximo Inválido!', ['&Ok']);
      edtFatGer.Text := '1,0000';
      Result := False;
      Exit;
    End;

    If (fStrToFloat(edtFatGer.Text) < 1) And (fStrToFloat(edtFatGer.Text) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Fator para cálculo estoque máximo Inválido!', ['&Ok']);
      edtFatGer.Text := '1,0000';
      Result := False;
    End
  End

  Else If (Sender = edtFatA) And (pgcOpcao.ActivePage = TSCalABC) Then
  Begin
    If (fStrToFloat(edtFatA.Text) < 1) And (fStrToFloat(edtFatA.Text) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Fator para cálculo estoque máximo Inválido!', ['&Ok']);
      edtFatA.Text := '1,0000';
    End
  End

  Else If (Sender = edtFatB) And (pgcOpcao.ActivePage = TSCalABC) Then
  Begin
    If (fStrToFloat(edtFatB.Text) < 1) And (fStrToFloat(edtFatB.Text) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Fator para cálculo estoque máximo Inválido!', ['&Ok']);
      edtFatB.Text := '1,0000';
    End
  End

  Else If (Sender = edtFatC) And (pgcOpcao.ActivePage = TSCalABC) Then
  Begin
    If (fStrToFloat(edtFatC.Text) < 1) And (fStrToFloat(edtFatC.Text) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Fator para cálculo estoque máximo Inválido!', ['&Ok']);
      edtFatC.Text := '1,0000';
    End
  End

  Else If (Sender = edtFatX) And (pgcOpcao.ActivePage = TSCalXYZ) Then
  Begin
    If (fStrToFloat(edtFatX.Text) < 1) And (fStrToFloat(edtFatX.Text) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Fator para cálculo estoque máximo Inválido!', ['&Ok']);
      edtFatX.Text := '1,0000';
    End
  End

  Else If (Sender = edtFatY) And (pgcOpcao.ActivePage = TSCalXYZ) Then
  Begin
    If (fStrToFloat(edtFatY.Text) < 1) And (fStrToFloat(edtFatY.Text) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Fator para cálculo estoque máximo Inválido!', ['&Ok']);
      edtFatY.Text := '1,0000';
    End
  End

  Else If (Sender = edtFatZ) And (pgcOpcao.ActivePage = TSCalXYZ) Then
  Begin
    If (fStrToFloat(edtFatZ.Text) < 1) And (fStrToFloat(edtFatZ.Text) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Fator para cálculo estoque máximo Inválido!', ['&Ok']);
      edtFatZ.Text := '1,0000';
    End
  End

  Else If (Sender = edtQtdMesABC) And (pgcOpcao.ActivePage = TSCalABC) Then
  Begin
    If (fEmptyStr(edtQtdMesABC.Text)) Then
    Begin
      pgcOpcao.ActivePage := TSCalABC;
      fMensagem('ATENÇÃO!', 'O campo "Qtd. Meses para cálculo da média" deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtQtdMesABC.Text) < 1) Or (fStrToFloat(edtQtdMesABC.Text) > 12) Then
    Begin
      pgcOpcao.ActivePage := TSCalABC;
      fMensagem('ATENÇÃO!', 'O campo "Qtd. Meses para cálculo da média" deve ser entre 1 e 12!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtQtdMesXYZ) And (pgcOpcao.ActivePage = TSCalXYZ) Then
  Begin
    If (fEmptyStr(edtQtdMesXYZ.Text)) Then
    Begin
      pgcOpcao.ActivePage := TSCalXYZ;
      fMensagem('ATENÇÃO!', 'O campo "Qtd. Meses para cálculo da média" deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtQtdMesXYZ.Text) < 1) Or (fStrToFloat(edtQtdMesXYZ.Text) > 12) Then
    Begin
      pgcOpcao.ActivePage := TSCalXYZ;
      fMensagem('ATENÇÃO!', 'O campo "Qtd. Meses para cálculo da média" deve ser entre 1 e 12!', ['&Ok']);
      Result := False;
    End;
  End


  {******************************}
  {* VALIDA FORNECEDOR          *}
  {***************************LA*}
  Else If (Sender = edtCodFor) Then
    pDesmarcaLista(edtCodFor,arrFornecedor)

  Else If (Sender = edtCodIte) Then
    pDesmarcaLista(edtCodIte,arrCodIte);

  If Not Result Then
    pSetFocus(Sender);
end;


Function TfrmCalEstMin.fSQLEstMin(strDiaEst: String): String;
  Var
    intAno: Word;
    intMes: Word;
    intDia: Word;
    dtaBas: TDate;
    objEstMed: TStringList;
    strEstSom,
    strEstMin,
    strAno: String;
    strSQL: String;
    intAux: Integer;
    blnInfMes: Boolean;
    stlMeses : TStringList;
    strMesSel: String;
    strGirMes: String;
    strNomCam: String;
    strWhere : String;
Begin
  objEstMed := TStringList.Create;
  stlMeses  := TStringList.Create;
  Try
    blnInfMes := False;
    dtaBas := VS_Date;
    DecodeDate(dtaBas, intAno, intMes, intDia);

    case pgcOpcao.ActivePageIndex Of
      0: Begin
        intQtdMes := StrToInt(edtQtdMes.Text);
        blnInfMes := chkInfMes.Checked;
      End;
      1: Begin
        intQtdMes := StrToInt(edtQtdMesABC.Text);
        blnInfMes := chkInfMesABC.Checked;
      End;
      2: Begin
        intQtdMes := StrToInt(edtQtdMesXYZ.Text);
        blnInfMes := chkInfMesXYZ.Checked;
      End;
    End;
    strEstMin := ' 0 ';
    strGirMes := '';
    strCamGir := '';

    If (blnInfMes) Then
    Begin //MESES SELECIONADOS
      intAno := 0;
      strEstSom := '';
      stlMeses.Text := cdsMeses.fRetMeses;

      For intAux := stlMeses.Count - 1 DownTo 0 Do
      Begin
        strMesSel := Copy(stlMeses[intAux],6,2);
        intAno    := StrToInt(Copy(stlMeses[intAux],1,4));

        If Pos(IntToStr(intAno), strAno) <= 0 Then
        Begin
          If Not fEmptyStr(strAno) Then
            strAno := strAno + ', ';

          strAno := strAno + QuotedStr(IntToStr(intAno));
        End;

        strEstSom := ' SUM(IF(GIR_A_N_O_ = ' +
          QuotedStr(IntToStr(intAno)) + ', IF(IFNULL(GIR_QSAI' + strMesSel + ', 0) > 0, IFNULL(GIR_QSAI' +strMesSel + ', 0), 0), 0)) ' + #13;

        strNomCam := 'MES_' + strMesSel + IntToStr(intAno);

        strGirMes := strGirMes + ' SUM(IF(GIR_A_N_O_ = ' +
          QuotedStr(IntToStr(intAno)) + ', IF(IFNULL(GIR_QSAI' + strMesSel + ', 0) > 0, IFNULL(GIR_QSAI' +strMesSel +
          ', 0), 0), 0)) AS ' + strNomCam + ', ' + #13;

        strCamGir := strCamGir + strNomCam + ', ';

        strEstMin := strEstMin + ' + ' + strEstSom;
        objEstMed.Add(strEstSom);
      End;
    End //MESES SELECIONADOSO
    Else
    Begin
      For intAux := intQtdMes Downto 1 Do
      Begin
        dtaBas := VS_Date;
        dtaBas :=  IncMonth(dtaBas, -intAux);
        DecodeDate(dtaBas, intAno, intMes, intDia);

        If Pos(IntToStr(intAno), strAno) <= 0 Then
        Begin
          If Not fEmptyStr(strAno) Then
            strAno := strAno + ', ';

          strAno := strAno + QuotedStr(IntToStr(intAno));
        End;

        strEstSom := ' SUM(IF(GIR_A_N_O_ = ' +
           QuotedStr(IntToStr(intAno)) + ', IF(IFNULL(GIR_QSAI' + fStrZero(intMes,2) + ', 0) > 0, IFNULL(GIR_QSAI' + fStrZero(intMes,2) + ', 0), 0), 0)) ' + #13;

        strNomCam := 'MES_' + fStrZero(intMes,2) + IntToStr(intAno);

        strGirMes := strGirMes + ' SUM(IF(GIR_A_N_O_ = ' +
          QuotedStr(IntToStr(intAno)) + ', IF(IFNULL(GIR_QSAI' + fStrZero(intMes,2) + ', 0) > 0, IFNULL(GIR_QSAI' +fStrZero(intMes,2) +
          ', 0), 0), 0)) AS ' + strNomCam + ', ' + #13;

        strCamGir := strCamGir + strNomCam + ', ';

        strEstMin := strEstMin + ' + ' + strEstSom;
        objEstMed.Add(strEstSom);
    //    strEstMin := strEstMin + ' + SUM(IF(GIR_A_N_O_ = ' +
    //       QuotedStr(IntToStr(intAno)) + ', IF(IFNULL(GIR_QSAI' + fStrZero(intMes,2) + ', 0) > 0, IFNULL(GIR_QSAI' + fStrZero(intMes,2) + ', 0), 0), 0)) ';
      End;
    End;

    if pgcOpcao.ActivePageIndex = 0 then
    Begin
      if rdgTipMed.ItemIndex = 1 then
      Begin
        strEstMin := strEstMin + (' - GREATEST( ' + objEstMed.DelimitedText + ')- LEAST(' +
          objEstMed.DelimitedText + ')').Replace('"','');
      End;
    End;

    strCamGir := Copy(strCamGir, 1, Length(strCamGir) - 2);

    strEstMin := ' (( ' + strEstMin + ' ) / :QTDDIA) * :' + strDiaEst;

    strWhere := '';
    strWhere := strWhere + ' FROM ';
    strWhere := strWhere + '   GIRITE ';
    strWhere := strWhere + ' WHERE ';
    strWhere := strWhere + '   GIR_CODITE = G.ITE_CODITE AND ';
    strWhere := strWhere + '   GIR_CODEMP = G.ITE_CODEMP AND ';
    strWhere := strWhere + '   GIR_A_N_O_ IN (' + strAno + ')  ';
    strWhere := strWhere + ' GROUP BY ';
    strWhere := strWhere + '   GIR_CODITE ';

    strSQL := ' (SELECT ';
    strSQL := strSQL +    strEstMin;
    strSQL := strSQL +    strWhere + ')';


    strSQLGiro := ' SELECT ';
    strSQLGiro := strSQLGiro + strGirMes;
    strSQLGiro := strSQLGiro + ' GIR_CODITE, GIR_CODEMP ';

    If (Not fEmptyStr(edtCodIte.Text)) And (Length(arrCodIte) <= 1) Then
      strWhere := StringReplace(strWhere, 'G.ITE_CODITE', ':CODITE', [])
    Else
      strWhere := StringReplace(strWhere, 'GIR_CODITE = G.ITE_CODITE', 'TRUE', []);

    strWhere := StringReplace(strWhere, 'G.ITE_CODEMP', ':CODEMP', []);

    strSQLGiro := strSQLGiro + strWhere;

    Result := strSQL;
  Finally
    FreeAndNil(objEstMed);
    FreeAndNil(stlMeses);
  End;
End;

Function TfrmCalEstMin.fAtualiza: Boolean;
Begin
  Result := TfrmGravando.fExecuta(fAtualizaPrg, frmGravando, 'Atualizando itens, aguarde...');
End;

procedure TfrmCalEstMin.pSetarParametros(var AQuery : TUniQuery; const AQtdDia : Integer);
begin
  If AQuery.Params.FindParam('FATMAX') <> Nil Then
    AQuery.ParambyName('FATMAX').AsFloat := fStrToFloat(edtFatGer.Text);

  If AQuery.Params.FindParam('FATMAXA') <> Nil Then
    AQuery.ParambyName('FATMAXA').AsFloat := fStrToFloat(edtFatA.Text);

  If AQuery.Params.FindParam('FATMAXB') <> Nil Then
    AQuery.ParambyName('FATMAXB').AsFloat := fStrToFloat(edtFatB.Text);

  If AQuery.Params.FindParam('FATMAXC') <> Nil Then
    AQuery.ParambyName('FATMAXC').AsFloat := fStrToFloat(edtFatC.Text);

  If AQuery.Params.FindParam('FATMAXX') <> Nil Then
    AQuery.ParambyName('FATMAXX').AsFloat := fStrToFloat(edtFatX.Text);

  If AQuery.Params.FindParam('FATMAXY') <> Nil Then
    AQuery.ParambyName('FATMAXY').AsFloat := fStrToFloat(edtFatY.Text);

  If AQuery.Params.FindParam('FATMAXZ') <> Nil Then
    AQuery.ParambyName('FATMAXZ').AsFloat := fStrToFloat(edtFatZ.Text);

  If AQuery.Params.FindParam('CODEMP') <> Nil Then
    AQuery.ParamByName('CODEMP').AsString := strEmpresa;

  If AQuery.Params.FindParam('QTDDIA') <> Nil Then
    if rdgTipMed.ItemIndex = 0 then
      AQuery.ParamByName('QTDDIA').AsFloat := AQtdDia
    else
      AQuery.ParamByName('QTDDIA').AsFloat := AQtdDia - 60;

  If AQuery.Params.FindParam('DIAEST') <> Nil Then
    AQuery.ParamByName('DIAEST').AsFloat := StrToInt(edtDiaEst.Text);

  If AQuery.Params.FindParam('DIAESTA') <> Nil Then
    AQuery.ParamByName('DIAESTA').AsFloat := StrToInt(edtDiaEstA.Text);

  If AQuery.Params.FindParam('DIAESTB') <> Nil Then
    AQuery.ParamByName('DIAESTB').AsFloat := StrToInt(edtDiaEstB.Text);

  If AQuery.Params.FindParam('DIAESTC') <> Nil Then
    AQuery.ParamByName('DIAESTC').AsFloat := StrToInt(edtDiaEstC.Text);

  If AQuery.Params.FindParam('DIAESTZ') <> Nil Then
    AQuery.ParamByName('DIAESTZ').AsFloat := StrToInt(edtDiaEstZ.Text);

  If AQuery.Params.FindParam('DIAESTY') <> Nil Then
    AQuery.ParamByName('DIAESTY').AsFloat := StrToInt(edtDiaEstY.Text);

  If AQuery.Params.FindParam('DIAESTX') <> Nil Then
    AQuery.ParamByName('DIAESTX').AsFloat := StrToInt(edtDiaEstX.Text);

  pSetaFiltros(AQuery);
end;

procedure TfrmCalEstMin.pSetaFiltros(AQuery: TUniQuery);
Begin
  pSetaParam(mskLinGru.Text, arrLinhaGrupo, strLinGru,     'CODGRU', AQuery);
  pSetaParam(edtCodFor.Text, arrFornecedor, strFornecedor, 'CODFOR', AQuery);
  pSetaParam(edtCodMar.Text, arrMarca,      strMarca ,     'CODMAR', AQuery);
  pSetaParam(edtPrdGru.Text, arrGrupoPro,   strPrdGru,     'PRDGRU', AQuery);
  pSetaParam(edtGruCmp.Text, arrGruCmp,     strGruCmp,     'GRUCMP', AQuery);
  pSetaParam(edtCodDep.Text, arrCodDep,     strCodDep,     'CODDEP', AQuery);
  pSetaParam(edtCodIte.Text, arrCodIte,     strCodIte,     'CODITE', AQuery);
End;

procedure TfrmCalEstMin.pGerarStrEstMin(var ASql : String);
  Var
    strEstMin : String;
begin
  If Pos('<#ESTMIN#>', ASql) = 0 then
    Exit;
  strEstMin := EmptyStr;
  Case pgcOpcao.ActivePageIndex Of
    0: strEstMin := strEstMin + fSQLEstMin('DIAEST');
    1: Begin
         strEstMin := strEstMin +' (CASE IF(TIPGIR.SIS_VALCFG = "S", G.ITE_NIVGIR, I.ITE_NVLGIR) ';
         strEstMin := strEstMin +'  WHEN "A" THEN ' + fSQLEstMin('DIAESTA');
         strEstMin := strEstMin +'  WHEN "B" THEN ' + fSQLEstMin('DIAESTB');
         strEstMin := strEstMin +'  WHEN "C" THEN ' + fSQLEstMin('DIAESTC');
         strEstMin := strEstMin +'  ELSE G.ITE_ESTMIN ';
         strEstMin := strEstMin +' END) ';
       End;

    2: Begin
         strEstMin := strEstMin +' (CASE IF(TIPCRI.SIS_VALCFG = "S", G.ITE_NIVCRI, I.ITE_NVLCRI) ';
         strEstMin := strEstMin +'  WHEN "Z" THEN ' + fSQLEstMin('DIAESTZ');
         strEstMin := strEstMin +'  WHEN "Y" THEN ' + fSQLEstMin('DIAESTY');
         strEstMin := strEstMin +'  WHEN "X" THEN ' + fSQLEstMin('DIAESTX');
         strEstMin := strEstMin +'  ELSE G.ITE_ESTMIN ';
         strEstMin := strEstMin +' END) ';
       End;
  End;
  ASql := StringReplace(ASql, '<#ESTMIN#>', strEstMin, []);

  If (Not fEmptyStr(strCamGir)) Then
  Begin
    ASql := StringReplace(ASql, '<#CAMGIR#>', ', ' + strCamGir, []);
    Asql := StringReplace(ASql, '<#SQLGIR#>', ' LEFT JOIN (' + strSQLGiro + ') AS X ON X.GIR_CODITE = G.ITE_CODITE AND X.GIR_CODEMP = G.ITE_CODEMP ', []);
  End
  Else
  Begin
    ASql := StringReplace(ASql, '<#CAMGIR#>', ' ', []);
    Asql := StringReplace(ASql, '<#SQLGIR#>', ' ', []);
  End;
end;

procedure TfrmCalEstMin.pGerarEstMaxABC(var ASql : String);
  Var
    strEstMaxABC : String;
begin
  If Pos('<#ESTMAXABC#>', ASql) = 0 then
    Exit;

  strEstMaxABC := EmptyStr;
  strEstMaxABC := strEstMaxABC + ' (CASE IF(TIPGIR.SIS_VALCFG = "S", G.ITE_NIVGIR, I.ITE_NVLGIR)  ';

  If (fStrToFloat(edtFatA.Text) <> 0) Then
    strEstMaxABC := strEstMaxABC + '  WHEN "A" THEN '+ IIf(chkCalcEst.Checked, IIf(rdgCalcEst.Itemindex = 0, 'CEIL', 'FLOOR'), '') + '(@ESTMIN * :FATMAXA)';

  If (fStrToFloat(edtFatB.Text) <> 0) Then
    strEstMaxABC := strEstMaxABC + '  WHEN "B" THEN '+ IIf(chkCalcEst.Checked, IIf(rdgCalcEst.Itemindex = 0, 'CEIL', 'FLOOR'), '') + '(@ESTMIN * :FATMAXB)';

  If (fStrToFloat(edtFatC.Text) <> 0) Then
    strEstMaxABC := strEstMaxABC + '  WHEN "C" THEN '+ IIf(chkCalcEst.Checked, IIf(rdgCalcEst.Itemindex = 0, 'CEIL', 'FLOOR'), '') + '(@ESTMIN * :FATMAXC)';

  strEstMaxABC := strEstMaxABC + '  ELSE G.ITE_ESTMAX';
  strEstMaxABC := strEstMaxABC + ' END) ';

  ASql := StringReplace(ASql, '<#ESTMAXABC#>', strEstMaxABC, []);
end;

procedure TfrmCalEstMin.pGerarEstMaxXYZ(var ASql : String);
  Var
    strEstMaxXYZ : String;
begin
  If Pos('<#ESTMAXXYZ#>', ASql) = 0 then
    Exit;

  strEstMaxXYZ := EmptyStr;
  strEstMaxXYZ := strEstMaxXYZ + ' (CASE IF(TIPCRI.SIS_VALCFG = "S", G.ITE_NIVCRI, I.ITE_NVLCRI) ';

  If (fStrToFloat(edtFatZ.Text) <> 0) Then
    strEstMaxXYZ := strEstMaxXYZ + '  WHEN "Z" THEN '+ IIf(chkCalcEst.Checked, IIf(rdgCalcEst.Itemindex = 0, 'CEIL', 'FLOOR'), '') + '(@ESTMIN * :FATMAXZ)';

  If (fStrToFloat(edtFatY.Text) <> 0) Then
    strEstMaxXYZ := strEstMaxXYZ + '  WHEN "Y" THEN '+ IIf(chkCalcEst.Checked, IIf(rdgCalcEst.Itemindex = 0, 'CEIL', 'FLOOR'), '') + '(@ESTMIN * :FATMAXY)';

  If (fStrToFloat(edtFatX.Text) <> 0) Then
    strEstMaxXYZ := strEstMaxXYZ + '  WHEN "X" THEN '+ IIf(chkCalcEst.Checked, IIf(rdgCalcEst.Itemindex = 0, 'CEIL', 'FLOOR'), '') + '(@ESTMIN * :FATMAXX)';

  strEstMaxXYZ := strEstMaxXYZ + '  ELSE G.ITE_ESTMAX';
  strEstMaxXYZ := strEstMaxXYZ + ' END) ';

   ASql := StringReplace(ASql, '<#ESTMAXXYZ#>', strEstMaxXYZ, []);
end;

procedure TfrmCalEstMin.pMontarSelectPreviewOrUpdate(out ASql : String; blnPorItem: Boolean = False);
begin
  ASql := EmptyStr;
  If Not chkMostrarPrevia.Checked Then
    ASql := ASql + ' UPDATE '
  Else
  Begin
    ASql := ASql + ' SELECT I.ITE_CODITE, I.ITE_DESITE, U.UNI_DESUNI, G.ITE_CODEMP, ' +
      'G.ITE_ESTMIN, G.ITE_ESTMAX, @ESTMIN:=COALESCE('+ IIf(chkCalcEst.Checked, IIf(rdgCalcEst.Itemindex = 0, 'CEIL', 'FLOOR'), '') + '(<#ESTMIN#>),0) ESTMIN';

    ASql := ASql + ' <#CAMGIR#> ';

    If ((pgcOpcao.ActivePage = TSCalABC) And
               ((fStrToFloat(edtFatA.Text) <> 0) Or (fStrToFloat(edtFatB.Text) <> 0) Or (fStrToFloat(edtFatC.Text) <> 0))) Then
    Begin
      ASql := ASql + ' , @ESTMAX:=COALESCE('+ IIf(chkCalcEst.Checked, IIf(rdgCalcEst.Itemindex = 0, 'CEIL', 'FLOOR'),  '') + '(<#ESTMAXABC#>),0) ESTMAX';
    End
    Else If ((pgcOpcao.ActivePage = TSCalXYZ) And
             ((fStrToFloat(edtFatX.Text) <> 0) Or (fStrToFloat(edtFatY.Text) <> 0) Or (fStrToFloat(edtFatZ.Text) <> 0))) Then
    Begin
      ASql := ASql + ' , @ESTMAX:=COALESCE('+ IIf(chkCalcEst.Checked, IIf(rdgCalcEst.Itemindex = 0, 'CEIL', 'FLOOR'),  '') + '(<#ESTMAXXYZ#>),0) ESTMAX';
    End
    Else
      ASql := ASql + ' , @ESTMAX:='+ IIf(chkCalcEst.Checked, IIf(rdgCalcEst.Itemindex = 0, 'CEIL', 'FLOOR'),  '') + '(@ESTMIN * :FATMAX) ESTMAX';
    ASql := ASql + ' FROM ';
  End;

  ASql := ASql + ' ITEGER G ';
  ASql := ASql + ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';
  ASql := ASql + ' INNER JOIN CFGSIS TIPGIR  ON TIPGIR.SIS_CODCFG = "CFG_TIPGIR" AND TIPGIR.SIS_CODEMP = G.ITE_CODEMP ';
  ASql := ASql + ' INNER JOIN CFGSIS TIPCRI  ON TIPCRI.SIS_CODCFG = "CFG_TIPCRI" AND TIPCRI.SIS_CODEMP = G.ITE_CODEMP ';

  If Not chkMostrarPrevia.Checked Then
  Begin
    ASql := ASql +' SET ';
    ASql := ASql +' G.ITE_ESTMIN = @ESTMIN:='+ IIf(chkCalcEst.Checked, IIf(rdgCalcEst.Itemindex = 0, 'CEIL', 'FLOOR'), '') + '(<#ESTMIN#>)';
  End
  Else
  Begin
    ASql := ASql + ' <#SQLGIR#> ';
    ASql := ASql + ' LEFT JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI AND U.UNI_CODEMP = I.ITE_CODEMP ';
  End;

  If Not chkMostrarPrevia.Checked Then
  Begin
    If ((pgcOpcao.ActivePage = TSCalGer) And (fStrToFloat(edtFatGer.Text) <> 0)) Then
      ASql := ASql + ' , G.ITE_ESTMAX = @ESTMAX:='+ IIf(chkCalcEst.Checked, IIf(rdgCalcEst.Itemindex = 0, 'CEIL', 'FLOOR'), '') + '(@ESTMIN * :FATMAX) '

    Else If ((pgcOpcao.ActivePage = TSCalABC) And
             ((fStrToFloat(edtFatA.Text) <> 0) Or (fStrToFloat(edtFatB.Text) <> 0) Or (fStrToFloat(edtFatC.Text) <> 0))) Then
    Begin
      ASql := ASql + ' , G.ITE_ESTMAX = @ESTMAX:=<#ESTMAXABC#>';
    End

    Else If ((pgcOpcao.ActivePage = TSCalXYZ) And
             ((fStrToFloat(edtFatX.Text) <> 0) Or (fStrToFloat(edtFatY.Text) <> 0) Or (fStrToFloat(edtFatZ.Text) <> 0))) Then
    Begin
      ASql := ASql + ' , G.ITE_ESTMAX = @ESTMAX:=<#ESTMAXXYZ#>';
    End;
  End;

  pGerarStrEstMin(ASql);
  pGerarEstMaxABC(ASql);
  pGerarEstMaxXYZ(ASql);

  ASql := ASql + 'WHERE ';

  If blnPorItem Then
  Begin
    ASql := ASql + '     G.ITE_CODITE = :CODITE ';
    ASql := ASql + ' AND G.ITE_CODEMP = :CODEMP ';
  End Else
  Begin
    ASql := ASql + fSQLFiltros;
  End;

  ASql := ASql + ';';
end;

Function TfrmCalEstMin.fSQLFiltros: String;
  Var
   strSQL: String;
Begin
  strSQL := '';
  strSQL :=  strSQL + '   G.ITE_ESMIDG = "G" AND';
  strSQL :=  strSQL + '   G.ITE_CODEMP = :CODEMP';

  strSQL :=  strSQL + fStrLocateLinGru(mskLinGru, arrLinhaGrupo, 'I.ITE_CODGRU', 'CODGRU');
  strSQL :=  strSQL + fStrLocate(edtCodFor, arrFornecedor, 'I.ITE_CODFOR', 'CODFOR');
  strSQL :=  strSQL + fStrLocate(edtCodMar, arrMarca     , 'I.ITE_CODMAR', 'CODMAR');
  strSQL :=  strSQL + fStrLocate(edtPrdGru, arrGrupoPro  , 'I.ITE_PRDGRU', 'PRDGRU');
  strSQL :=  strSQL + fStrLocate(edtGruCmp, arrGruCmp    , 'I.ITE_GRUCMP', 'GRUCMP');
  strSQL :=  strSQL + fStrLocate(edtCodDep, arrCodDep    , 'I.ITE_CODDEP', 'CODDEP');
  strSQL :=  strSQL + fStrLocate(edtCodIte, arrCodIte    , 'I.ITE_CODITE', 'CODITE');

  Result := strSQL;
End;

procedure TfrmCalEstMin.pPrepararPreview(var ADados : TUniClientDataSet; ASqlPrevia : String; AProgresso: TCxProgressBar);
  Var
    i         : Integer;
    qryDados  : TUniQuery;
    intQtdEmp,
    intQtdDia : Integer;
begin
  intQtdEmp := 0;

  For i := 0 To lstEmpresas.Count -1 Do
    If lstEmpresas.Checked[i] Then
      Inc(intQtdEmp);

  AProgresso.Properties.Max := intQtdEmp;

  intQtdDia := 30 * intQtdMes;

  qryDados := fCriaQuery;
  try
    qryDados.SQL.Text := ASqlPrevia;
    qryDados.Prepare;
    For i := 0 To lstEmpresas.Count -1 Do
    Begin

      If lstEmpresas.Checked[i] Then
      Begin
        strEmpresa := LeftStr(lstEmpresas.Items[i],3);

        frmGravando.lblGravando.Caption := 'Calculando itens da empresa ' + strEmpresa + ', aguarde...';
        Application.ProcessMessages;

        qryDados.Close;
        pSetarParametros(qryDados, intQtdDia);
        qryDados.Open;
        If Not Assigned(ADados) then
          ADados := fCriaClientDatset(qryDados)
        Else
        Begin
          qryDados.First;
          While Not qryDados.Eof Do
          Begin
            pCopiaRegistroDataSet(qryDados, ADados);
            qryDados.Next;
          End;
        End;

        AProgresso.Position := AProgresso.Position + 1;
        Application.ProcessMessages;

      End;

    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

Function TfrmCalEstMin.fSQLCarregaItensEmpresa: String;
  Var
   strSQL: String;
Begin
  strSQL := '';
  strSQL :=  strSQL + ' SELECT  ';
  strSQL :=  strSQL + '   I.ITE_CODITE, ';
  strSQL :=  strSQL + '   G.ITE_ESTMIN, ';
  strSQL :=  strSQL + '   G.ITE_ESTMAX  ';
  strSQL :=  strSQL + ' FROM   ';
  strSQL :=  strSQL + ' ITEGER G ';
  strSQL :=  strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';

  strSQL :=  strSQL + ' WHERE   ';

  strSQL :=  strSQL + fSQLFiltros;

  Result := strSQL;
End;

Procedure TfrmCalEstMin.pCarregaItens;
Begin
  qryItens.SQL.Text := fSQLCarregaItensEmpresa;

  pSetaFiltros(qryItens);

  qryItens.ParamByName('CODEMP').AsString := strEmpresa;

  TDBAccessUtils.SetFetchAll(qryItens, True);   // <-- garante leitura completa antes de qualquer commit
  qryItens.Open;
End;

Function TfrmCalEstMin.fAtualizaPrg(prgProgresso: TCxProgressBar): Boolean;
Const
  TAM_LOTE = 100;
Var
  intContador        : Integer;
  intItensNoLote     : Integer;
  strAutInc,
  strUpdate          : String;
  APreview           : TFrmCalEstMinPreview;
  blnTransacaoAberta : Boolean;
Begin
  Result := True;
  VS_blnGravaLogTransacao := False;
  VS_GravaUsuRep := 'N';
  blnTransacaoAberta := False;

  Try
    Try
      If chkMostrarPrevia.Checked Then
      Begin
        pMontarSelectPreviewOrUpdate(strUpdate);

        APreview := TFrmCalEstMinPreview.Create(Self);
        Try
          pPrepararPreview(APreview.FDados, strUpdate, prgProgresso);

          If APreview.ShowModal = mrOk Then
          Begin
            For intContador := 0 To lstEmpresas.Count -1 Do
            If lstEmpresas.Checked[intContador] Then
            Begin
              strEmpresa := LeftStr(lstEmpresas.Items[intContador], 3);
              If Not APreview.fAtualizaEmpresa(strEmpresa, frmGravando) Then
              Begin
                Result := False;
                Break;
              End;
            End;
          End
          Else Result := False;
        Finally
          FreeAndNil(APreview);
        End;

      End Else
      Begin
        // Monta SQL UMA única vez — depende só do estado do form
        pMontarSelectPreviewOrUpdate(strUpdate, True{blnPorItem});
        strUpdate := Trim(strUpdate);
        If EndsText(';', strUpdate) Then
          strUpdate := Copy(strUpdate, 1, Length(strUpdate) - 1);

        For intContador := 0 To lstEmpresas.Count -1 Do
        If lstEmpresas.Checked[intContador] Then
        Begin
          strEmpresa := LeftStr(lstEmpresas.Items[intContador], 3);
          pCarregaItens;

          frmGravando.lblGravando.Caption := 'Atualizando empresa ' + strEmpresa + ', aguarde...';
          prgProgresso.Position := 0;
          prgProgresso.Properties.Max := qryItens.RecordCount;
          Application.ProcessMessages;

          strAutInc := fRetAutoIncrem('ALTEST', VS_strCodEmp, qryItens.RecordCount);

          // ==================================================================
          // OPÇÃO 2 — Prepare 1× por empresa, parâmetros fixos fora do loop
          // ==================================================================
          qryUpdate.Close;
          qryUpdate.SQL.Text := strUpdate;
          pSetarParametros(qryUpdate, 30 * intQtdMes);   // já seta CODEMP

          qryInsLog.Close;
          qryInsLog.SQL.Text := TAltEst.fSQLInsertLogParam;
          qryInsLog.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
          qryInsLog.ParamByName('CODEMP').AsString := strEmpresa;
          qryInsLog.ParamByName('NOMFRM').AsString := 'frmCalEstMin';

          Try
            qryUpdate.Prepare;
            qryInsLog.Prepare;

            // ===============================================================
            // OPÇÃO 1 — Mini-batches com transação aberta SOB DEMANDA
            // ===============================================================
            intItensNoLote := 0;
            blnTransacaoAberta := False;

            While Not qryItens.Eof Do
            Begin
              // Abre transação só quando há trabalho — evita commit vazio
              If Not blnTransacaoAberta Then
              Begin
                fStartTransaction;
                blnTransacaoAberta := True;
              End;

              // UPDATE — só CODITE varia por item
              qryUpdate.ParamByName('CODITE').AsString := qryItens.FieldByName('ITE_CODITE').AsString;
              qryUpdate.Execute;

              // INSERT no log — mesma conexão lê @ESTMIN/@ESTMAX
              qryInsLog.ParamByName('AUTOINC').AsString := strAutInc;
              qryInsLog.ParamByName('CODITE').AsString  := qryItens.FieldByName('ITE_CODITE').AsString;
              qryInsLog.ParamByName('ESTMIN').AsFloat   := qryItens.FieldByName('ITE_ESTMIN').AsFloat;
              qryInsLog.ParamByName('ESTMAX').AsFloat   := qryItens.FieldByName('ITE_ESTMAX').AsFloat;
              qryInsLog.Execute;

              strAutInc := fNextAutoIncrem(strAutInc);
              Inc(intItensNoLote);

              // Fecha o lote (próxima transação será aberta sob demanda)
              If intItensNoLote >= TAM_LOTE Then
              Begin
                fCommit;
                blnTransacaoAberta := False;
                intItensNoLote := 0;
              End;

              qryItens.Next;
              prgProgresso.Position := prgProgresso.Position + 1;

              If (Trunc(prgProgresso.Position) Mod 100) = 0 Then
                Application.ProcessMessages;
            End;

            // Commit do lote parcial final (se houver)
            If blnTransacaoAberta Then
            Begin
              fCommit;
              blnTransacaoAberta := False;
            End;

          Finally
            Try If qryUpdate.Prepared Then qryUpdate.UnPrepare; Except End;
            Try If qryInsLog.Prepared Then qryInsLog.UnPrepare; Except End;
          End;

        End;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;

        If blnTransacaoAberta Then
        Begin
          fRollBack;
        End;

        VS_blnGravaLogTransacao := True;
        VS_GravaUsuRep := 'S';

        pMensagensErro(E.Message, 'TfrmCalEstMin.fAtualizaPrg');
      End;
    End;
  Finally
    VS_blnGravaLogTransacao := True;
    VS_GravaUsuRep := 'S';
  End;
End;

procedure TfrmCalEstMin.btnGerarClick(Sender: TObject);
  Var
    strMensagem: String;
    i : Integer;
    blnOk : Boolean;
begin
  inherited;
  blnOk := False;
  For i := 0 To lstEmpresas.Count -1 Do
    If lstEmpresas.Checked[i] Then
    Begin
      blnOk := True;
      Break;
    End;
  If Not blnOk Then
  Begin
    fMensagem('AVISO', 'Ao menos uma empresa deve ser selecionada!!', ['&O K']);
    Exit;
  End;


  If fEmptyStr(edtFatGer.Text) Then
    edtFatGer.Text := '0,0000';

  If fEmptyStr(edtFatA.Text) Then
    edtFatA.Text := '0,0000';

  If fEmptyStr(edtFatB.Text) Then
    edtFatB.Text := '0,0000';

  If fEmptyStr(edtFatC.Text) Then
    edtFatC.Text := '0,0000';

  If fEmptyStr(edtFatX.Text) Then
    edtFatX.Text := '0,0000';

  If fEmptyStr(edtFatY.Text) Then
    edtFatY.Text := '0,0000';

  If fEmptyStr(edtFatZ.Text) Then
    edtFatZ.Text := '0,0000';

  If fVerificaCampos Then
  Begin

    If (chkInfMes.Checked) Or (chkInfMesABC.Checked) Or (chkInfMesXYZ.Checked) Then
    Begin
      If Not cdsMeses.fValidaMeses(fRetNroMeses) Then
      Begin
        pMensagemOk('Selecione os meses desejados para o giro!');
        Case pgcOpcao.ActivePageIndex Of
          0: lblSelMesClick(lblSelMes);
          1: lblSelMesClick(lblSelMesABC);
          2: lblSelMesClick(lblSelMesXYZ);
        End;
        Exit;
      End;
    End;

    Case pgcOpcao.ActivePageIndex Of
      0: strMensagem := 'Confirma Estoque Mínimo atráves do Cálculo Geral?';
      1: strMensagem := 'Confirma Estoque Mínimo atráves do Cálculo por ABC?';
      2: strMensagem := 'Confirma Estoque Mínimo atráves do Cálculo por XYZ?';
    End;

    If fMensagem('AVISO', strMensagem, ['&Sim', '&Não']) = 1 Then
    Begin
      Try
        btnGerar.Enabled := False;
        btnSair.Enabled := False;
        pnlFundo.Enabled := False;

        If fAtualiza Then
          fMensagem('','Cálculo gerado com sucesso!',['&OK']);

      Finally
        btnGerar.Enabled := True;
        btnSair.Enabled  := True;
        pnlInfo.Caption  := '';
        pnlFundo.Enabled := True;
        pgbStatus.Visible:= False;
        pSetFocus(edtCodFor);
      End;

    End;

  End;
end;

procedure TfrmCalEstMin.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor,edtNomFor,arrFornecedor,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmCalEstMin.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornecedor, False) Then
  Begin
    fValidaCampos(edtCodFor, False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalEstMin.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmCalEstMin.edtGruCmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCalEstMin.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrGrupoPro, fRetNomeGrupoProduto, nil, 'do Grupo de Produtos', edtPrdGru.MaxLength);
end;

procedure TfrmCalEstMin.edtPrdGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrGrupoPro, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalEstMin.edtQtdMesChange(Sender: TObject);
begin
  inherited;
  rdgTipMed.Enabled := fStrToFloat(edtQtdMes.Text) >= 6;

  If Not rdgTipMed.Enabled Then
    rdgTipMed.ItemIndex := 0;
end;

procedure TfrmCalEstMin.FormCreate(Sender: TObject);
begin
  inherited;
  pAtualizaLst;

  objAltEst := TAltEst.Create(Self);
  cdsMeses := TMesesGiro.Create(Self, 12);

  qryItens  := fCriaQuery(Self);
  qryUpdate := fCriaQuery(Self);
  qryInsLog := fCriaQuery(Self);


  edtCodIte.TamCampo := fTamCodIte;
  edtCodIte.MaxLength := edtCodIte.TamCampo;
end;

procedure TfrmCalEstMin.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objAltEst);
end;

procedure TfrmCalEstMin.pAtualizaLst;
  Var
    strSQL     : String;
    intContador: Integer;
    qryGen     : TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    lstEmpresas.Items.Clear;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_CODEMP, ';
    strSQL := strSQL + '  EMP_NOMEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  LOCATE(EMP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      While Not Eof Do
      Begin
        Application.ProcessMessages;
        lstEmpresas.Items.Add(FieldByName('EMP_CODEMP').AsString + ' - ' +
                              FieldByName('EMP_NOMEMP').AsString);
        Next;
      End;
      Close;
    End;

    For intContador := 0 To lstEmpresas.Items.Count -1 Do
    Begin
      lstEmpresas.Checked[intContador] := True;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TfrmCalEstMin.lstEmpresasEnter(Sender: TObject);
begin
  inherited;
  If lstEmpresas.Items.Count > 0 Then
    lstEmpresas.Selected[0] := True
  Else
    SelectNext(ActiveControl,True,True);

end;

procedure TfrmCalEstMin.lstEmpresasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Return: SelectNext(ActiveControl,True,True);
  End;
end;

procedure TfrmCalEstMin.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinhaGrupo, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmCalEstMin.mskLinGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrLinhaGrupo, False) Then
  Begin
    If fValidaCampos(mskLinGru, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalEstMin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (ActiveControl Is TcxPageControl) Then
  Begin
    Case Key Of
      VK_Return: Begin
                   Case pgcOpcao.ActivePageIndex Of
                     0: pSetFocus(edtQtdMes);
                     1: pSetFocus(edtQtdMesABC);
                     2: pSetFocus(edtQtdMesXYZ);
                   End;
                 End;
    End;
  End;
end;

procedure TfrmCalEstMin.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(mskLinGru);

  pgcOpcao.ActivePageIndex := 0;
end;

procedure TfrmCalEstMin.chkCalcEstClick(Sender: TObject);
begin
  inherited;
  rdgCalcEst.Enabled := chkCalcEst.Checked;
end;

procedure TfrmCalEstMin.chkMostrarPreviaClick(Sender: TObject);
begin
  inherited;
  btnGerar.Caption := 'Gravar';
  If chkMostrarPrevia.Checked then
    btnGerar.Caption := 'Prévia' ;
end;

procedure TfrmCalEstMin.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrCodDep, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmCalEstMin.edtCodDepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrCodDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalEstMin.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar,edtDesMar,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmCalEstMin.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalEstMin.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte, edtDesIte, arrCodIte, Nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmCalEstMin.edtCodIteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrCodIte, False) then
  Begin
    If fValidaCampos(edtCodIte, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalEstMin.edtFatGerExit(Sender: TObject);
begin
  inherited;
  If fValidaCampos(edtFatGer, True) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCalEstMin.edtFatGerKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = '-' Then
    Key := #0;
end;

procedure TfrmCalEstMin.chkInfMesABCClick(Sender: TObject);
begin
  lblSelMesABC.Enabled := chkInfMesABC.Checked;

  If chkInfMesABC.Checked Then
    lblSelMesClick(lblSelMesABC);
end;

procedure TfrmCalEstMin.chkInfMesClick(Sender: TObject);
begin
  lblSelMes.Enabled := chkInfMes.Checked;

  If chkInfMes.Checked Then
    lblSelMesClick(lblSelMes);
end;

procedure TfrmCalEstMin.chkInfMesXYZClick(Sender: TObject);
begin
  lblSelMesXYZ.Enabled := chkInfMesXYZ.Checked;

  If chkInfMesXYZ.Checked Then
    lblSelMesClick(lblSelMesXYZ);
end;

procedure TfrmCalEstMin.lblSelMesABCClick(Sender: TObject);
begin
  If fEmptyStr(edtQtdMesABC.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe a Quantidade de Meses!', ['&Ok']);
    pSetFocus(edtQtdMesABC);
    Exit;
  End;

  cdsMeses.fSelecionaMeses(fRetNroMeses, strMeses);
end;

procedure TfrmCalEstMin.lblSelMesClick(Sender: TObject);
begin
  If fEmptyStr(edtQtdMes.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe a Quantidade de Meses!', ['&Ok']);
    pSetFocus(edtQtdMes);
    Exit;
  End;

  cdsMeses.fSelecionaMeses(fRetNroMeses, strMeses);
end;

procedure TfrmCalEstMin.lblSelMesXYZClick(Sender: TObject);
begin
  If fEmptyStr(edtQtdMesXYZ.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe a Quantidade de Meses!', ['&Ok']);
    pSetFocus(edtQtdMesXYZ);
    Exit;
  End;

  cdsMeses.fSelecionaMeses(fRetNroMeses, strMeses);
end;

Function TfrmCalEstMin.fRetNroMeses: Integer;
Var
  LQtdMes: Integer;
Begin
  LQtdMes := 3;
  Try
    Case pgcOpcao.ActivePageIndex Of
      0: LQtdMes := StrToInt(edtQtdMes.Text);
      1: LQtdMes := StrToInt(edtQtdMesABC.Text);
      2: LQtdMes := StrToInt(edtQtdMesXYZ.Text);
    End;
    Result := LQtdMes;
  Except
    Result := 3;
  End;
End;

end.



