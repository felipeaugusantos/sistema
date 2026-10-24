unit untFatLiberacaoEntFut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxCore,
  EditFocus, Uni,
  UniClientDataSet, UniDataSetProvider, Math, frxClass, frxDBSet,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatLiberacaoEntFut = class(TfrmPaiConfirma)
    pnlDados: TPanel;
    cxgItensTab: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensCodIte: TcxGridDBColumn;
    cxgItensDecri: TcxGridDBColumn;
    cxgItensRefere: TcxGridDBColumn;
    cxgItensSigUni: TcxGridDBColumn;
    cxgItensNumDoc: TcxGridDBColumn;
    cxgItensEspDoc: TcxGridDBColumn;
    cxgItensCodEmp: TcxGridDBColumn;
    cxgItensDtaFut: TcxGridDBColumn;
    cxgItensQtdIte: TcxGridDBColumn;
    cxgItensQtdNot: TcxGridDBColumn;
    Label3: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label5: TLabel;
    edtNumDoc: TEditFocus;
    Label2: TLabel;
    edtEspDoc: TEditFocus;
    rdgAtender: TRadioGroup;
    dtsConsul: TDataSource;
    Label4: TLabel;
    edtSerie: TEditFocus;
    frxReportM: TfrxReport;
    frxDataSet: TfrxDBDataset;
    frxReportJ: TfrxReport;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure rdgAtenderExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    intQtdDec: Integer;
    qryNotEnt: TUniQuery;

    qryIteEnt: TUniQuery;
    cdsIteEnt: TUniClientDataSet;
    dspIteEnt: TUniDataSetProvider;

    qryConsul: TUniQuery;
    cdsConsul: TUniClientDataSet;
    dspConsul: TUniDataSetProvider;

    Function fValidaNota(strNumDoc, strSerie, strEspDoc,
                         strCodEmp, strCodFor: String): Boolean;

    Function fConfima: Boolean;

    Procedure pAbreConsulta;
    Procedure pAbreItensNota;
    Procedure pProcessaItems;
    Procedure pAtualizaItem(strAutInc: String);
    Procedure pIncluiMestreLog(Var strAutInc: String);
    Procedure pIncluiItensLog(strAutLog, strAutInc, strEspNTE: String);
    procedure pLimpaCampos;
    procedure pImprimirRelatorio;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untCfgRel, untConstantes, untFuncoesSimples,untConsultas, StrUtils,
  untTypesSistema;

{$R *.dfm}

procedure TfrmFatLiberacaoEntFut.pLimpaCampos;
Begin
  cdsConsul.Close;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtNumDoc.Clear;
  edtEspDoc.Clear;
  edtSerie.Clear;
  pSetFocus(edtNumDoc);
End;

procedure TfrmFatLiberacaoEntFut.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not cdsConsul.IsEmpty) And
     fPergunta('Confirma a liberação dos itens?') And fConfima Then
  Begin
    pMensagemOk('Operação realizada com sucesso!');
    pLimpaCampos;
  End;

end;

procedure TfrmFatLiberacaoEntFut.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatLiberacaoEntFut.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatLiberacaoEntFut.FormCreate(Sender: TObject);
begin
  inherited;

  intQtdDec := fCfgSis('DECQTD', varInteger);
  
  qryConsul := fCriaQuery(Self);
  dspConsul := TUniDataSetProvider.Create(Self);
  cdsConsul := TUniClientDataSet.Create(Self);
  dtsConsul.DataSet := cdsConsul;

  qryNotEnt := fCriaQuery(Self);

  qryIteEnt := fCriaQuery(Self);
  dspIteEnt := TUniDataSetProvider.Create(Self);
  cdsIteEnt := TUniClientDataSet.Create(Self);
end;

procedure TfrmFatLiberacaoEntFut.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
  End;
  
end;

procedure TfrmFatLiberacaoEntFut.FormShow(Sender: TObject);
begin
  inherited;
  edtNumDoc.TamCampo  := fTamNumDoc;
  edtNumDoc.MaxLength := edtNumDoc.TamCampo;

  pSetFocus(edtNumDoc);
end;

function TfrmFatLiberacaoEntFut.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número do Documento deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Espécie deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Length(edtEspDoc.Text) <> 2 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Espécie deve ter exatamente 2 caracteres!', ['&O k']);
        Result := False;
      End;
    End
    
    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

          If fEmptyStr(edtNomEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
            Result := False;
          End

        End;
      End;
    End

    Else If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Fornecedor deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&O k']);
          Result := False;
        End

        Else If not fValidaNota(edtNumDoc.Text,
                                edtSerie.Text,
                                edtEspDoc.Text,
                                edtCodEmp.Text,
                                edtCodFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Nota de entrada não encontrada!', ['&O k']);
          Result := False;
        End

        Else If fNotaUtilizadaLibEntFut(edtEspDoc.Text, qryNotEnt.FieldByName('AUTOINCREM').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', 'Nota de entrada já utilizada para liberação!', ['&O k']);
          Result := False;
        End;

      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmFatLiberacaoEntFut.fValidaNota(strNumDoc, strSerie, strEspDoc,
  strCodEmp, strCodFor: String): Boolean;

  Procedure pAddConsulta;
  Begin
    With qryNotEnt, SQL Do
    Begin
      Add('SELECT');
      Add(' GER_ESPDOC, ');
      Add(' AUTOINCREM ');
      Add('FROM MOVGER ');
      Add('WHERE ');
      Add('  GER_NUMDOC = :NUMDOC AND ');
      Add('  GER_ESPDOC = :ESPDOC AND ');
      Add('  GER_CODEMP = :CODEMP AND ');
      Add('  GER_CODFOR = :CODFOR AND ');
      Add('  IFNULL(GER_SERIE_, "") = :SERIE_ AND ');
      Add('  IFNULL(GER_ORIDOC, "") = "" ');
    End;
  End;

Begin

  With qryNotEnt, SQL Do
  Begin
    Close;
    Clear;

    pAddConsulta;
    Add(' LIMIT 1');

    ParamByName('NUMDOC').AsString :=  strNumDoc;
    ParamByName('CODEMP').AsString :=  strCodEmp;
    ParamByName('ESPDOC').AsString :=  strEspDoc;
    ParamByName('CODFOR').AsString :=  strCodFor;
    ParamByName('SERIE_').AsString :=  strSerie;

    Open;

    Result := Not IsEmpty;
  End;
End;

Procedure TfrmFatLiberacaoEntFut.pAbreItensNota;
Begin
  With qryIteEnt, SQL Do
  Begin
    Close;
    cdsIteEnt.Close;

    Clear;

    Add('SELECT');
    Add('  DET_CODITE      AS CODITE, ');
    Add('  SUM(DET_QTDITE) AS QTDITE, ');
    Add('  SUM(DET_QTDITE) AS QTDDIS  ');
    Add('FROM');
    Add('  MOVDET ');
    Add('WHERE');
    Add('  DET_SEQGER = :AUTINC');
    Add('GROUP BY');
    Add('  DET_CODITE ');

    ParamByName('AUTINC').AsString := qryNotEnt.FieldByName('AUTOINCREM').AsString;

    Open;
    pSetaClient(qryIteEnt);

    dspIteEnt.DataSet := qryIteEnt;
    cdsIteEnt.SetProvider(dspIteEnt);
    cdsIteEnt.Open;
    pSetaClient(cdsIteEnt);
  End;
End;

procedure TfrmFatLiberacaoEntFut.rdgAtenderExit(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
    pAbreConsulta;

end;

Procedure TfrmFatLiberacaoEntFut.pAbreConsulta;

  Procedure pAddConsulta;
  Begin

    With qryConsul, SQL Do
    Begin
      Add('SELECT');
      Add('  0          AS ATENDI,');
      Add('  CONCAT(DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI) AS QUEBRA, ');
      Add('  CONCAT(DET_CODCLI, "-", CLI_NOMCLI) AS NOMCLI,');
      Add('  CONCAT(DET_CODVEN, "-", OPE_NOMOPE) AS NOMVEN,');
      Add('  DET_MOTFUT AS MOTFUT,');
      Add('  DET_NUMDOC AS NUMDOC,');
      Add('  DET_ESPDOC AS ESPDOC,');
      Add('  DET_CODEMP AS CODEMP,');

      Add('  DET_REFERE AS REFERE,');
      Add('  UNI_SIGUNI AS SIGUNI,');
      Add('  DET_CODITE AS CODITE,');
      Add('  DET_DESCRI AS DESCRI,');

      Add('  (DET_QTDITE - IFNULL(DET_QTDENT,0)) AS QTDITE,');
      Add('  QTDNOT,');
      Add('  DET_DTAFUT AS DTAFUT,');
      Add('  D.AUTOINCREM AS AUTINC');

      Add('FROM ');
      Add('MOVDET AS D ');
      Add('JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ');
      Add('JOIN CADOPE ON OPE_CODOPE = D.DET_CODVEN ');

      Add(' INNER JOIN MOVGER G ON ');
      Add('  G.AUTOINCREM = DET_SEQGER AND ');
      Add('  GER_ENTFUT = "S"');

      Add('INNER JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD');

      Add('INNER JOIN (');

      Add('SELECT');
      Add('  DET_CODITE      AS CODITE,');
      Add('  SUM(DET_QTDITE) AS QTDNOT ');
      Add('FROM');
      Add('  MOVDET ');
      Add('WHERE');
      Add('  DET_SEQGER = :AUTINC');
      Add('GROUP BY');
      Add('  DET_CODITE ');

      Add(') AS ENTRADA ON ');
      Add('   DET_CODITE = CODITE ');

      Add('WHERE ');

      Add('  (DET_QTDITE - IFNULL(DET_QTDENT,0)) > 0 AND ');
      Add('  DET_MOTFUT = "F" AND ');
      Add('  D.DET_EFBAIX = "N" AND ');
      Add('  DET_QTDITE <= QTDNOT ');

      If rdgAtender.ItemIndex = 0 Then
        Add(' AND DET_CODEMP = ' + QuotedStr(VS_strCodEmp));

    End;

  End;

Begin
  Try
    cdsConsul.DisableControls;
    
    pAbreItensNota;

    With qryConsul, SQL Do
    Begin
      Close;
      cdsConsul.Close;

      Clear;

      pAddConsulta;

      ParamByName('AUTINC').AsString := qryNotEnt.FieldByName('AUTOINCREM').AsString;

      Open;
      pSetaClient(qryConsul);

      dspConsul.DataSet := qryConsul;
      cdsConsul.SetProvider(dspConsul);
      cdsConsul.Open;
      pSetaClient(cdsConsul);

      TFloatField(cdsConsul.FieldByName('QTDITE')).DisplayFormat := '#,##0.' + fStrZero('0', intQtdDec);
      TFloatField(cdsConsul.FieldByName('QTDNOT')).DisplayFormat := '#,##0.' + fStrZero('0', intQtdDec);
    End;

    cdsConsul.IndexFieldNames := 'DTAFUT';

    pProcessaItems;

    cdsConsul.EnableControls;

    pSetFocus(cxgItens);

    If cdsConsul.IsEmpty Then
      pMensagemOk('Nenhum item encontrado!')

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatLiberacaoEntFut.pAbreConsulta]');
      cdsConsul.EnableControls;
    End;
  End;
End;

Procedure TfrmFatLiberacaoEntFut.pProcessaItems;
Begin
  With cdsConsul Do
  Begin
    First;

    While Not Eof Do
    Begin
      If cdsIteEnt.Locate('CODITE', FieldByName('CODITE').AsString, []) And
         (RoundTo(cdsIteEnt.FieldByName('QTDDIS').AsFloat, -intQtdDec) >=
          RoundTo(FieldByName('QTDITE').AsFloat, -intQtdDec)) Then
      Begin

        cdsIteEnt.Edit;
        cdsIteEnt.FieldByName('QTDDIS').AsFloat :=
           cdsIteEnt.FieldByName('QTDDIS').AsFloat -
           FieldByName('QTDITE').AsFloat;
        cdsIteEnt.Post;

        Edit;
        FieldByName('ATENDI').AsInteger := 1;
        Post;

      End;

      Next;
    End;

    Filter   := 'ATENDI = 0';
    Filtered := True;

    While Not Eof Do
      Delete;

    Filtered := False;
  End;
End;

Procedure TfrmFatLiberacaoEntFut.pAtualizaItem(strAutInc: String);
  Var
    qryUpdIte: TUniQuery;
Begin
  qryUpdIte := fCriaQuery(Self);
  With qryUpdIte, SQL Do
  Begin
    Clear;

    Add('UPDATE MOVDET ');
    Add(' SET');
    Add('   DET_MOTFUT = "P",');
    Add('   DET_DTAFUT = IF(DET_DTAFUT < :DTAATU, :DTAATU, DET_DTAFUT)');
    Add(' WHERE ');
    Add('   AUTOINCREM = :AUTINC ');

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('DTAATU').AsDate   := VS_Date;

    ExecSQL;
  End;
  FreeAndNil(qryUpdIte);
End;

Procedure TfrmFatLiberacaoEntFut.pIncluiMestreLog(Var strAutInc: String);
  Var
    qryLefGer: TUniQuery;
Begin
  strAutInc := fRetAutoIncrem('LEFGER', VS_strCodEmp);

  qryLefGer := fCriaQuery(Self);

  With qryLefGer, SQL Do
  Begin
    Clear;

    Add('SELECT * FROM ');
    Add('LEFGER');
    Add('WHERE FALSE');

    Open;

    qryLefGer.Insert;

    FieldByName('AUTOINCREM').AsString   := strAutInc;
    FieldByName('LEF_CODEMP').AsString   := VS_strCodEmp;
    FieldByName('LEF_CODOPE').AsString   := strLoginUsuarioLogado;
    FieldByName('LEF_DTALIB').AsDateTime := VS_DATE;
    FieldByName('LEF_HORLIB').AsDateTime := fTime();
    FieldByName('LEF_SEQNOT').AsString   := qryNotEnt.FieldByName('AUTOINCREM').AsString;

    Post;

  End;

  FreeAndNil(qryLefGer);
End;

Procedure TfrmFatLiberacaoEntFut.pIncluiItensLog(strAutLog,
                                                 strAutInc,
                                                 strEspNTE: String);
  Var
    qryLefDet: TUniQuery;
Begin
  qryLefDet := fCriaQuery(Self);

  With qryLefDet, SQL Do
  Begin
    Clear;

    Add('SELECT * FROM LEFDET ');
    Add('WHERE FALSE');

    Open;

    qryLefDet.Insert;

    FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LEFDET', VS_strCodEmp);
    FieldByName('LEF_AUTDET').AsString := strAutInc;
    FieldByName('LEF_SEQGER').AsString := strAutLog;
    FieldByName('LEF_ESPNTE').AsString := strEspNTE;

    Post;

  End;

  FreeAndNil(qryLefDet);
End;

Function TfrmFatLiberacaoEntFut.fConfima: Boolean;
  Var
    strAutLog: String;
Begin

  Try

    With cdsConsul Do
    Begin
      DisableControls;

      fStartTransaction;

      pIncluiMestreLog(strAutLog);

      First;
      While Not Eof Do
      Begin
        pAtualizaItem(FieldByName('AUTINC').AsString);

        pIncluiItensLog(strAutLog,
                        FieldByName('AUTINC').AsString,
                        qryNotEnt.FieldByName('GER_ESPDOC').AsString);

        Next;
      End;

      fCommit;

      pImprimirRelatorio;

      Result := True;
      EnableControls;
    End;


  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TfrmFatLiberacaoEntFut.fConfima]');
      cdsConsul.EnableControls;
    End;
  End;

End;

procedure TfrmFatLiberacaoEntFut.pImprimirRelatorio;
  Var
    cdsDados: TUniClientDataSet;
    frxRep: TfrxReport;
    strNomeFila: String;
    strTipImp: String;
begin
  If fMensagem('', 'Deseja imprimir?', ['&Sim', '&Não']) = 2 Then
    Exit;

  pCarregaConfImpr(qryCfgRel, Self.Name);
  fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);

  cdsDados := TUniClientDataSet.Create(Self);
  cdsDados.Data := cdsConsul.Data;

  cdsDados.IndexFieldNames := 'QUEBRA;CODITE';

  frxDataSet.DataSet := cdsDados;

  If (strTipImp = 'M') Then
    frxRep := frxReportM
  Else
    frxRep := frxReportJ;

  frxRep.Script.Variables['NOMREL'] := 'ITENS LIBERADOS PARA ENTREGA FUTURA';
  frxRep.Script.Variables['NOMEMP'] := VS_strCodEmp + '-' + fRetNomeEmpresa;
  frxRep.Script.Variables['DADOS_NOTA'] := Format('DOCUMENTO: %s - %s - %s - %s',
    [edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtSerie.Text]);
  frxRep.Script.Variables['FORNECEDOR'] := 'FORNECEDOR: ' + edtCodFor.Text + '-' + edtNomFor.Text;

  frxRep.PrintOptions.Printer := AnsiReplaceText(strNomeFila,'\\' + fRetNomeRede + '\','');
  pPreviewReport(Self.Name, Self.Caption, frxRep);

  FreeAndNil(cdsDados);
end;

end.
