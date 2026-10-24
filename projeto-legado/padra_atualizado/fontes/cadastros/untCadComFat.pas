{*********************************************************}
{* CADASTRO DE FAIXAS DE COMISSÃO POR FATURAMENTO        *}
{*                                                       *}
{* DATA......: 15/07/2009                                *}
{* AUTOR.....: MARCOS VINICIUS DA SILVA                  *}
{*                                                       *}
{******************************************************AF*}
unit untCadComFat;

interface

uses
  Windows, Classes, Controls, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, Uni,
  ExtCtrls, DB, Grids, DBGridCitel, DBGrids, DBEditFocus, EditFocus, untComFat, untPaiCad,
  BitBtnLockedIncrem, Mask, DBCtrls, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid;

type
  TfrmCadComFat = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dtsComFat: TDataSource;
    pnlTopo: TPanel;
    dbeCodPes: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dbeDescricao: TDBEditFocus;
    pnlGrid: TPanel;
    pnlCentro: TPanel;
    dbgDados: TDBGridCitel;
    edtFatIni: TEditFocus;
    edtFatFin: TEditFocus;
    edtPerCom: TEditFocus;
    Label5: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    dtsDados: TDataSource;
    btnAdicionar: TBitBtnLocked;
    Label8: TLabel;
    dbeMarIni: TEditFocus;
    dbeMarFin: TEditFocus;
    Label9: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    pnlDepartamento: TPanel;
    lblCodDep: TLabel;
    dbeCodDep: TDBEditFocus;
    edtDesDep: TEditFocus;
    pnlMecanicos: TPanel;
    Panel2: TPanel;
    btnAddMecanico: TBitBtnLocked;
    edtNomMec: TEditFocus;
    edtCodMec: TEditFocus;
    lbl1: TLabel;
    Panel3: TPanel;
    grdDbMecanicos: TcxGridDBTableViewCitel;
    grdMecanicosLevel1: TcxGridLevel;
    grdMecanicos: TcxGridCitel;
    grdDbMecanicosColumn1: TcxGridDBColumn;
    grdDbMecanicosColumn2: TcxGridDBColumn;
    dtsMecanicos: TDataSource;
    lbl19: TLabel;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodPesExit(Sender: TObject);
    procedure dbeCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure dbgDadosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodMecKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddMecanicoClick(Sender: TObject);
    procedure grdDbMecanicosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    objComFat: TComFat;
    blnUsaProCod: Boolean;
    FTipoComissao : TTipoComissao;

    procedure pLimpaCampos;
  public
    { Public declarations }
    property TipoComissao : TTipoComissao read FTipoComissao write FTipoComissao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; Override;
  end;

implementation

uses SysUtils, Forms, untFuncoesSimples, untConstantes, untConsultas, untTypesSistema,
     untFuncoesAutocenter;

{$R *.dfm}

procedure TfrmCadComFat.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objComFat);
end;

procedure TfrmCadComFat.FormShow(Sender: TObject);
begin
  objComFat := TComFat.Create(Self, FTipoComissao);

  strNomeTabela     := objComFat.NomeDaTabela;
  strNomeCampo      := 'COM_CODTAB';
  qryTabela         := objComFat.qryTabela;

  if FTipoComissao = tcMecanico then
  begin
    dbeCodDep.DataSource    := Nil;
    pnlDepartamento.Visible := False;
    pnlTopo.height          := 35;
    Self.Height             := 600;
    Self.Caption            := 'Faixa de Faturamento de Mecânicos - Serviços';

    objComFat.pCarregaDadosMecanicos;
    dtsMecanicos.DataSet    := objComFat.cdsMecanicos;
  end
  else
  begin
    pnlMecanicos.Visible := False;
  end;

  dtsComFat.DataSet := qryTabela;

  dtsDados.DataSet  := objComFat.cdsDados;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPes;
  blnUsaProCod := fUsaProCodigo(objComFat.NomeDaTabela);
  pHabilitaCodigo(dbeCodPes, dbeCodPes, Not blnUsaProCod);
  objComFat.blnUsaProCod := blnUsaProCod;

  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadComFat.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COM_CODTAB');
  stlCampos.Add('COM_DESCRI');
  stlCampos.Add('COM_FATINI');
  stlCampos.Add('COM_FATFIN');
  stlCampos.Add('COM_MARINI');
  stlCampos.Add('COM_MARFIN');
  stlCampos.Add('COM_PERCOM');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COM_CODTAB+COM_FATINI+COM_FATFIN');
  stlCamInd.Add('COM_DESCRI');
  stlCamInd.Add('COM_CODTAB');

  stlDesInd.Add('Código/Faturamento Inicial/Faturamento Final');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadComFat.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
  objComFat.cdsDados.EmptyDataSet;

  if FTipoComissao = tcMecanico then
    objComFat.cdsMecanicos.EmptyDataSet;

  objComFat.objTipoAcao := aoInserindo;
  If blnUsaProCod Then
    pSetFocus(dbeDescricao)
  Else
    pSetFocus(dbeCodPes);
end;

procedure TfrmCadComFat.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
  objComFat.objTipoAcao := aoEditando;
  pHabilitaCodigo(dbeCodPes, dbeCodPes, Not blnUsaProCod);
  If blnUsaProCod Then
    pSetFocus(dbeDescricao)
  Else
    pSetFocus(dbeCodPes);
end;

procedure TfrmCadComFat.pLimpaCampos;
begin
  dbeMarIni.Text := '0,000';
  dbeMarFin.Text := '0,000';
  edtFatIni.Text := '0,000';
  edtFatFin.Text := '0,000';
  edtPerCom.Text := '0,00';

  If Not fEmptyStr(dbeCodDep.Text) Then
    edtDesDep.Text := fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [dbeCodDep.Text])
  Else
    edtDesDep.Text := '';

  edtCodMec.Text := '';
  edtNomMec.Text := '';
end;

function TfrmCadComFat.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  var
    LMensagem : String;
begin
  Result := True;

  Try

    If Sender = dbeCodPes Then
    Begin
      objComFat.strCodTab := dbeCodPes.Text;
      If fEmptyStr(dbeCodPes.Text) And (Not blnUsaProCod) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If Sender = dbeDescricao Then
    Begin
      objComFat.strDescri := dbeDescricao.Text;
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End
    Else If Sender = dbeMarIni Then
    Begin
      objComFat.strMarIni := fStrToFloat(dbeMarIni.Text);
      If (fStrToFloat(dbeMarIni.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Margem Inicial deve ser maior que zero!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not blnBuscaPorChave) Then
          Result := objComFat.fValidaMargemOuFatInvidual(fStrToFloat(dbeMarIni.Text),
                                                        'COM_MARINI',
                                                        'COM_MARFIN',
                                                        fStrToFloat(edtFatIni.Text),
                                                        fStrToFloat(edtFatFin.Text));
      End;
    End
    Else If Sender = dbeMarFin Then
    Begin
      objComFat.strMarFin := fStrToFloat(dbeMarFin.Text);
      If (fStrToFloat(dbeMarFin.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Margem Final deve ser maior que zero!', ['&Ok']);
        Result := False;
      end
      Else If fStrToFloat(dbeMarIni.Text) > fStrToFloat(dbeMarFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Margem Final deve ser maior que a Margem Inicial!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not blnBuscaPorChave) Then
          Result := objComFat.fValidaMargemOuFatInvidual(fStrToFloat(dbeMarFin.Text),
                                                         'COM_MARINI',
                                                         'COM_MARFIN',
                                                         fStrToFloat(edtFatIni.Text),
                                                         fStrToFloat(edtFatFin.Text));
      End;
    End
    Else If (Sender = dbeCodDep) Then
    Begin
      objComFat.strCodDep := '';
      If (fEmptyStr(dbeCodDep.Text)) Then
        edtDesDep.Clear
      Else
      Begin
        edtDesDep.Text := fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [dbeCodDep.Text]);
        If fEmptyStr(edtDesDep.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Esse departamento não está cadastrado!',['&OK']);
          Result := False;
        End
        Else
          objComFat.strCodDep := dbeCodDep.Text;
      End;
    End
    Else If (Sender = edtFatIni) And blnBuscaPorChave Then
    Begin
      objComFat.strFatIni := fStrToFloat(edtFatIni.Text);
      If (fStrToFloat(edtFatIni.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Faturamento Inicial deve ser maior que zero!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtFatFin) And blnBuscaPorChave Then
    Begin
      objComFat.strFatFin := fStrToFloat(edtFatFin.Text);
      If (fStrToFloat(edtFatFin.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Faturamento Final deve ser maior que zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatIni.Text) > fStrToFloat(edtFatFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Faturamento Final deve ser maior que o Faturamento Inicial!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtPerCom) And blnBuscaPorChave Then
    Begin
      objComFat.strPerCom := fStrToFloat(edtPerCom.Text);
      If (fStrToFloat(edtPerCom.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O % de Comissão deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodMec) Then
    Begin
      If Not fEmptyStr(edtCodMec.Text) Then
      Begin
        If Not fExisteMecanico(edtCodMec.Text) Then
        Begin
          Result := False;
          pMensagemOk('Nenhum mecânico encontrado com este código!');
        End
        Else If objComFat.fValidarMecanicoJaExiste(edtCodMec.Text, LMensagem) Then
        Begin
          Result := False;
          fMensagem('', LMensagem, ['&Ok']);
        End
        Else
        Begin
          If fMecanicoInativo(edtCodMec.Text) then
          Begin
            Result := False;
            fMensagem('', 'Este mecânico está inativo! Verifique o Cadastro de Operadores.', ['&Ok']);
          End
          Else
          begin
            edtNomMec.Text           := fRetNomeOperador(edtCodMec.Text);
            objComFat.CodigoMecanico := edtCodMec.Text;
            objComFat.NomeMecanico   := edtNomMec.Text;
          end;
        End;
      End;
    End
  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadComFat.fValidaCampos]');
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadComFat.grdDbMecanicosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if not btnGravar.Enabled then
    Exit;

    Case Key Of
    VK_DELETE:
      If btnGravar.Enabled Then
      begin
        objComFat.pExcluiMecanico;
        grdDbMecanicos.ApplyBestFit();
      end;
    VK_ESCAPE: pEscapePressed;
  End;
end;

procedure TfrmCadComFat.dbgDadosDblClick(Sender: TObject);
begin
  inherited;
  If btnGravar.Enabled Then
  Begin
    dbeMarIni.Text      := FormatFloat('#,##0.000', objComFat.cdsDados.FieldByName('COM_MARINI').AsFloat);
    dbeMarFin.Text      := FormatFloat('#,##0.000', objComFat.cdsDados.FieldByName('COM_MARFIN').AsFloat);
    edtFatIni.Text      := FormatFloat('#,##0.000', objComFat.cdsDados.FieldByName('COM_FATINI').AsFloat);
    edtFatFin.Text      := FormatFloat('#,##0.000', objComFat.cdsDados.FieldByName('COM_FATFIN').AsFloat);
    edtPerCom.Text      := FormatFloat('#,##0.00' , objComFat.cdsDados.FieldByName('COM_PERCOM').AsFloat);
    objComFat.strAutInc := objComFat.cdsDados.FieldByName('AUTOINCREM').AsString;
    pSetFocus(dbeMarIni);
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadComFat.dbgDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE: If btnGravar.Enabled Then objComFat.pDeletaItem;
    VK_ESCAPE: pEscapePressed;
    VK_RETURN: dbgDadosDblClick(Sender);
  End;

end;

procedure TfrmCadComFat.edtCodMecKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOperador: TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self,
                   edtCodMec,
                   edtNomMec,
                   Nil,
                   Key,
                   arrOperador,
                   True,
                   True,
                   False,
                   True) Then
  Begin
    If fValidaCampos(edtCodMec, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadComFat.btnGravarClick(Sender: TObject);
  var
    LMensagem : String;
begin
  //inherited;

  Try
    pnlInfo.Caption := 'Gravando registro! Aguarde....';
    If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
    Begin
      If blnUsaProCod And (qryTabela.State = dsInsert) And fEmptyStr(dbeCodPes.Text) Then
      Begin
        dbeCodPes.Text := fPadL(fAtualizaProCod(objComFat.NomeDaTabela, ''), fRetTamCampo(objComFat.NomeDaTabela), '0');

        While objComFat.fExisteProCodCadastrado(dbeCodPes.Text) Do
          dbeCodPes.Text := fPadL(fAtualizaProCod(objComFat.NomeDaTabela, ''), fRetTamCampo(objComFat.NomeDaTabela), '0');

        objComFat.strCodTab := dbeCodPes.Text;
      End;

      If (fValidaCampos(dbeCodPes)) And
         (fValidaCampos(dbeDescricao)) Then
      Begin
        if not objComFat.fAtualizaRegistros(LMensagem) then
        begin
          pMensagemOk(LMensagem);
          pnlInfo.Caption := '';
          Exit;
        end;

        objComFat.cdsDados.ApplyUpdates(0);

        if FTipoComissao = tcMecanico then
          objComFat.pSalvarDadosMecanicos;

        qryTabela.Cancel;
        objComFat.pAtualizaTabela;

        pOnStateChange;
        pEnabled(Self, False);
        If btnIncluir.CanFocus Then
          pSetFocus(btnIncluir)
        Else If btnPesquisa.CanFocus Then
          pSetFocus(btnPesquisa);

        blnGravou := True;
      End;

      pLimpaCampos;
      pnlInfo.Caption := '';
    End;
  Except
    On E: EUniError Do
    Begin
      If E.ErrorCode = ERROR_PRIMARY_KEY_INSERT Then
      Begin
        pMensagensErro(E.Message, '[TfrmCadComFat.btnGravarClick]');
      End
      Else
      Begin
        pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[ Gravar registro ]');
      End;
      blnGravou := False;
    End;

    On E: Exception Do
    Begin
      blnGravou := False;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, '[TfrmCadComFat.btnGravarClick]');
    End;
  End;

end;

procedure TfrmCadComFat.btnAddMecanicoClick(Sender: TObject);
begin
  inherited;
  If (Not btnGravar.Enabled) or (fEmptyStr(edtCodMec.Text)) Then
    Exit;

  Try
    If fValidaCampos(edtCodMec) Then
    Begin
      objComFat.strCodTab := dbeCodPes.Text;
      objComFat.pAdicionarMecanico;
      pLimpaCampos;
      pSetFocus(edtCodMec);
      grdDbMecanicos.ApplyBestFit();
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadComFat.btnAddMecanico]');
    End;
  End;
end;

procedure TfrmCadComFat.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If Not btnGravar.Enabled Then
    Exit;  

  Try
    If fVerificaCampos And
       fValidaCampos(edtPerCom) Then
    Begin
      objComFat.strFatIni := fStrToFloat(edtFatIni.Text);
      objComFat.strFatFin := fStrToFloat(edtFatFin.Text);

      If (Not fEmptyStr(objComFat.strAutInc)) Then
        objComFat.pAlteraDados
      Else
        objComFat.pInsereDados;

      pLimpaCampos;
      pSetFocus(dbeMarIni);
      objComFat.strAutInc := '';
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadComFat.btnAdicionarClick]');
    End;
  End;

end;

procedure TfrmCadComFat.btnCancelaClick(Sender: TObject);
begin
  inherited;
  objComFat.pAtualizaDados;
  dtsMecanicos.DataSet := objComFat.cdsMecanicos;
  pLimpaCampos;
end;

procedure TfrmCadComFat.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
    qryPesq: TUniQuery;
begin
  chrKey := '/';
  qryPesq := fCriaQuery(Self);
  
  if fPesqComissaoFat(conSimples,
                     Self,
                     nil,
                     nil,
                     qryPesq,
                     chrKey,
                     arrsel,
                     True,
                     IIF(FTipoComissao = tcDepartamento,
                         'Consulta Faixas de Faturamento para Comissão',
                         'Consulta Faixas de Faturamento para Comissão de Mecânicos - Serviços'),
                     objComFat.NomeDaTabela) then
  Begin
    If (qryPesq.Active) And (Not qryPesq.IsEmpty) Then
    Begin
      With qryTabela Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM '+objComFat.NomeDaTabela+' WHERE COM_CODTAB = :CODTAB');
        ParamByName('CODTAB').AsString := qryPesq.FieldByName('COM_CODTAB').AsString;
        Open;
      End;

      If (Not qryTabela.IsEmpty) Then
      begin
        objComFat.pAtualizaDados;

        if FTipoComissao = tcMecanico then
        begin
          dtsMecanicos.DataSet := objComFat.cdsMecanicos;
          grdDbMecanicos.ApplyBestFit();
        end;
      end;
    End
    Else
      objComFat.cdsDados.EmptyDataSet;

    pLimpaCampos;
    pSetFocus(btnAlterar);
  End;

  If (fEmptyStr(dbeCodDep.Text)) Then
    edtDesDep.Clear
  Else
    edtDesDep.Text := fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [dbeCodDep.Text]);

  FreeAndNil(qryPesq);
end;

procedure TfrmCadComFat.btnExcluirClick(Sender: TObject);
begin
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
  Begin
    objComFat.objTipoAcao := aoDeletando;
    objComFat.strCodTab   := dbeCodPes.Text;
    If objComFat.fExcluiRegistro Then
    Begin
      objComFat.cdsDados.EmptyDataSet;

      if FTipoComissao = tcMecanico then
        objComFat.cdsMecanicos.EmptyDataSet;

      qryTabela.Close;
      qryTabela.Open;
      pLimpaCampos;
    End;
  End;
end;

procedure TfrmCadComFat.dbeCodDepKeyPress(Sender: TObject; var Key: Char);
  Var
    arrDep: TConsultasArray;
begin
  inherited;
  If fPesqDepartamento(Self, dbeCodDep, edtDesDep, Nil, Key, arrDep) Then
  Begin
    If fValidaCampos(dbeCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadComFat.dbeCodPesExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(dbeCodPes.Text) Then
  begin
    objComFat.pAtualizaDados;
    dtsMecanicos.DataSet := objComFat.cdsMecanicos;
  end;

end;

end.
