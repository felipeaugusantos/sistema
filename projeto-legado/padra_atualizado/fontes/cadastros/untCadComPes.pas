{*********************************************************}
{* CADASTRO DE FAIXAS DE COMISSÃO POR PESO               *}
{*                                                       *}
{* DATA......: 20/05/2009                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI                  *}
{*                                                       *}
{******************************************************AF*}
unit untCadComPes;

interface

uses
  Windows, Classes, Controls, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, Uni,
  ExtCtrls, DB, Grids, DBGridCitel, DBGrids, DBEditFocus, EditFocus, untComPes, untPaiCad,
  BitBtnLockedIncrem, Mask, DBCtrls, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadComPes = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dtsComPes: TDataSource;
    pnlTopo: TPanel;
    dbeCodPes: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dbeDescricao: TDBEditFocus;
    dbeValIni: TDBEditFocus;
    dbeValFin: TDBEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    pnlGrid: TPanel;
    pnlCentro: TPanel;
    dbgDados: TDBGridCitel;
    edtPesIni: TEditFocus;
    edtPesFin: TEditFocus;
    edtPerCom: TEditFocus;
    Label5: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    dtsDados: TDataSource;
    btnAdicionar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
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
    procedure FormDestroy(Sender: TObject);
    procedure dbgDadosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    objComPes: TComPes;
    blnUsaProCod: Boolean;
    fltValIniOld,
    fltValFinOld: Double;
    
    procedure pLimpaCampos;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; Override;
  end;

implementation

uses SysUtils, Forms, untFuncoesSimples, untConstantes, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadComPes.FormCreate(Sender: TObject);
begin
  objComPes := TComPes.Create(Self);
  inherited;

  fltValIniOld := 0;
  fltValFinOld := 0;

  strNomeTabela := 'COMPES';
  strNomeCampo  := 'COM_CODTAB';
  qryTabela     := objComPes.qryTabela;
  dtsComPes.DataSet := qryTabela;
  dtsDados.DataSet  := objComPes.cdsDados;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPes;
  blnUsaProCod := fUsaProCodigo('COMPES');
  pHabilitaCodigo(dbeCodPes, dbeCodPes, Not blnUsaProCod);
  objComPes.blnUsaProCod := blnUsaProCod;
end;

procedure TfrmCadComPes.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objComPes);
end;

procedure TfrmCadComPes.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadComPes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COM_CODTAB');
  stlCampos.Add('COM_DESCRI');
  stlCampos.Add('COM_PESINI');
  stlCampos.Add('COM_PESFIN');
  stlCampos.Add('COM_VALINI');
  stlCampos.Add('COM_VALFIN');
  stlCampos.Add('COM_PERCOM');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COM_CODTAB+COM_PESINI+COM_PESFIN');
  stlCamInd.Add('COM_DESCRI');
  stlCamInd.Add('COM_CODTAB');

  stlDesInd.Add('Código+Pes.Ini+Pes.Fin');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadComPes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  fltValIniOld := 0;
  fltValFinOld := 0;
  pLimpaCampos;
  objComPes.cdsDados.EmptyDataSet;
  objComPes.objTipoAcao := aoInserindo;
  If blnUsaProCod Then
    pSetFocus(dbeDescricao)
  Else
    pSetFocus(dbeCodPes);
end;

procedure TfrmCadComPes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
  objComPes.objTipoAcao := aoEditando;
  pHabilitaCodigo(dbeCodPes, dbeCodPes, Not blnUsaProCod);
  If blnUsaProCod Then
    pSetFocus(dbeDescricao)
  Else
    pSetFocus(dbeCodPes);
end;

procedure TfrmCadComPes.pLimpaCampos;
begin
  edtPesIni.Text := '0,000';
  edtPesFin.Text := '0,000';
  edtPerCom.Text := '0,00'; 
end;

function TfrmCadComPes.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try
    If Sender = dbeCodPes Then
    Begin
      objComPes.strCodTab := dbeCodPes.Text;

      If fEmptyStr(objComPes.strCodTab) And (Not blnUsaProCod) Then
        Result := False;
    End
    Else If Sender = dbeDescricao Then
    Begin
      objComPes.strDescri := dbeDescricao.Text;

      If fEmptyStr(dbeDescricao.Text) Then
        Result := False;
    End
    Else If Sender = dbeValIni Then
    Begin
      objComPes.strValIni := dbeValIni.Text;

      If fEmptyStr(dbeValIni.Text) Then
        Result := False
      Else If fStrToFloat(dbeValIni.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O valor inicial deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End
      Else
        Result := objComPes.fValidaPesoValorInvidual(fStrToFloat(dbeValIni.Text),
                                                     'COM_VALINI',
                                                     'COM_VALFIN',
                                                     vcValor,
                                                     fltValIniOld);
    End
    Else If Sender = dbeValFin Then
    Begin
      objComPes.strValFin := dbeValFin.Text;

      If fEmptyStr(dbeValFin.Text) Then
        Result := False
      Else If fStrToFloat(dbeValFin.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O valor final deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(dbeValIni.Text) > fStrToFloat(dbeValFin.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O valor final não pode ser menor que o valor inicial!', ['&Ok']);
        Result := False;
      End
      Else
        Result := objComPes.fValidaPesoValorInvidual(fStrToFloat(dbeValFin.Text),
                                                     'COM_VALINI',
                                                     'COM_VALFIN',
                                                     vcValor,
                                                     fltValFinOld);
    End
    Else If (Sender = edtPesIni) And blnBuscaPorChave Then
    Begin
      objComPes.strPesIni := edtPesIni.Text;

      If fEmptyStr(edtPesIni.Text) Then
        Result := False
      Else If fStrToFloat(edtPesIni.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O peso inicial deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End
      Else
        Result := objComPes.fValidaPesoValorInvidual(fStrToFloat(edtPesIni.Text),
                                                    'COM_PESINI',
                                                    'COM_PESFIN',
                                                    vcPeso,
                                                    0);
    End
    Else If (Sender = edtPesFin) And blnBuscaPorChave Then
    Begin
      objComPes.strPesFin := edtPesFin.Text;

      If fEmptyStr(edtPesFin.Text) Then
        Result := False
      Else If fStrToFloat(edtPesFin.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O peso final deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtPesIni.Text) > fStrToFloat(edtPesFin.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O peso final não pode ser menor que o peso inicial!', ['&Ok']);
        Result := False;
      End
      Else
        Result := objComPes.fValidaPesoValorInvidual(fStrToFloat(edtPesFin.Text),
                                                     'COM_PESINI',
                                                     'COM_PESFIN',
                                                     vcPeso,
                                                     0);
    End
    Else If (Sender = edtPerCom) And blnBuscaPorChave Then
    Begin
      objComPes.strPerCom := edtPerCom.Text;

      If fEmptyStr(edtPerCom.Text) Then
        Result := False;

      If fStrToFloat(edtPerCom.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O % de comissão deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End
    End;
  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadComPes.fValidaCampos]');
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadComPes.dbgDadosDblClick(Sender: TObject);
begin
  inherited;
                             
  If btnGravar.Enabled Then
  Begin
    edtPesIni.Text      := FormatFloat('#,##0.000', objComPes.cdsDados.FieldByName('COM_PESINI').AsFloat);
    edtPesFin.Text      := FormatFloat('#,##0.000', objComPes.cdsDados.FieldByName('COM_PESFIN').AsFloat);
    edtPerCom.Text      := FormatFloat('#,##0.00' , objComPes.cdsDados.FieldByName('COM_PERCOM').AsFloat);
    objComPes.strAutInc := objComPes.cdsDados.FieldByName('AUTOINCREM').AsString;
    pSetFocus(edtPesIni);
  End;
end;

procedure TfrmCadComPes.dbgDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Delete: If btnGravar.Enabled Then objComPes.pDeletaItem;
    VK_Escape: pEscapePressed;
    VK_RETURN: dbgDadosDblClick(Sender);
  End;

end;

procedure TfrmCadComPes.btnGravarClick(Sender: TObject);
begin
  //inherited;
  Try
    pnlInfo.Caption := 'Gravando registro! Aguarde....';
    If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
    Begin
      If blnUsaProCod And (qryTabela.State = dsInsert) And fEmptyStr(dbeCodPes.Text) Then
      Begin
        dbeCodPes.Text := fAtualizaProCod('COMPES', 'COM_CODTAB');

        While objComPes.fExisteProCodCadastrado(dbeCodPes.Text) Do
          dbeCodPes.Text := fAtualizaProCod('COMPES', 'COM_CODTAB');

        objComPes.strCodTab := dbeCodPes.Text;
      End;

      If (Not fValidacoesBotaoGravarPai) Then
      Begin
        pnlInfo.Caption := '';
        Exit;
      End;

      blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
      inherited;

      objComPes.pAtualizaRegistros;
      objComPes.cdsDados.ApplyUpdates(0);
      qryTabela.Cancel;
      objComPes.pAtualizaTabela;

      pOnStateChange;
      pEnabled(Self, False);
      If btnIncluir.CanFocus Then
        pSetFocus(btnIncluir)
      Else If btnPesquisa.CanFocus Then
        pSetFocus(btnPesquisa);

      pLimpaCampos;
      pnlInfo.Caption := '';
      blnGravou := True;
      fltValIniOld := 0;
      fltValFinOld := 0;
    End;
  Except
    On E: EUniError Do
    Begin
      If E.ErrorCode = ERROR_PRIMARY_KEY_INSERT Then
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadComPes.btnGravarClick]');
      End
      Else
      Begin
        fRollBack;
        pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[ Gravar registro ]');
      End;
      blnGravou := False;
    End;

    On E: Exception Do
    Begin
      fRollBack;
      blnGravou := False;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message,'[TfrmCadComPes.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadComPes.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If Not btnGravar.Enabled Then
    Exit;  

  Try
    If fVerificaCampos And
       fValidaCampos(edtPesIni) And
       fValidaCampos(edtPesFin) And
       fValidaCampos(edtPerCom) Then
    Begin
      If objComPes.fValidaFaixaPesoValor(fStrToFloat(dbeValIni.Text),
                                         fStrToFloat(dbeValFin.Text),
                                         'COM_VALINI',
                                         'COM_VALFIN',
                                         vcValor,
                                         fltValIniOld,
                                         fltValFinOld) And
         objComPes.fValidaFaixaPesoValor(fStrToFloat(edtPesIni.Text),
                                         fStrToFloat(edtPesFin.Text),
                                         'COM_PESINI',
                                         'COM_PESFIN',
                                         vcPeso,
                                         0,
                                         0) Then
      Begin
        If (Not fEmptyStr(objComPes.strAutInc)) Then
          objComPes.pAlteraDados
        Else
          objComPes.pInsereDados;

        pLimpaCampos;
        pSetFocus(edtPesIni);
        objComPes.strAutInc := '';
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadComPes.btnAdicionarClick]');
    End;
  End;
end;

procedure TfrmCadComPes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
  objComPes.pAtualizaDados;
end;

procedure TfrmCadComPes.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrPeso: TConsultasArray;
    qryPesq: TUniQuery;
begin
  {**********************************}
  {* NOVA CONSULTA DE FAIXA DE PESO *}
  {*******************************RV*}
  chrKey := '/';
  qryPesq := fCriaQuery(Self);
  
  If fPesqFaixaPeso(Self, Nil, Nil, qryPesq, chrKey, arrPeso) Then
  Begin
    pLimpaCampos;
    fltValIniOld := 0;
    fltValFinOld := 0;

    If (qryPesq.Active) And (Not qryPesq.IsEmpty) Then
    Begin
      With qryTabela Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM COMPES WHERE COM_CODTAB = :CODTAB');
        ParamByName('CODTAB').AsString := qryPesq.FieldByName('COM_CODTAB').AsString;
        Open;
      End;
      
      If (Not qryTabela.IsEmpty) Then
      Begin
        objComPes.pAtualizaDados;
        fltValIniOld := fStrToFloat(dbeValIni.Text);
        fltValFinOld := fStrToFloat(dbeValFin.Text);
      End;
    End
    Else
      objComPes.cdsDados.EmptyDataSet;

    pSetFocus(btnAlterar);
  End;

  FreeAndNil(qryPesq);
end;

procedure TfrmCadComPes.btnExcluirClick(Sender: TObject);
begin
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
  Begin
    fltValIniOld := 0;
    fltValFinOld := 0;
    objComPes.objTipoAcao := aoDeletando;
    objComPes.strCodTab   := dbeCodPes.Text;
    If objComPes.fExcluiRegistro Then
    Begin
      pLimpaCampos;
      objComPes.cdsDados.EmptyDataSet;
      qryTabela.Close;
      qryTabela.Open;
    End;
  End;
end;

procedure TfrmCadComPes.dbeCodPesExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(dbeCodPes.Text) Then
    objComPes.pAtualizaDados;

end;

end.
