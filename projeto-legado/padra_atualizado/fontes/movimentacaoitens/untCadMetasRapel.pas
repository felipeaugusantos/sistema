unit untCadMetasRapel;

interface

uses
  Windows, Classes, Controls, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, Mask, MaskEditFocus, untPaiConfirma, Grids,
  DBGridCitel, DBGrids, EditFocus, untZClient, DB, Uni, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadMetasRapel = class(TfrmPaiConfirma)
    pnlCabec: TPanel;
    pnlCorpo: TPanel;
    lblFornecedor: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtMeta: TEditFocus;
    edtRapel: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    dbgItens: TDBGridCitel;
    Bevel1: TBevel;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    btnCopiarMetas: TBitBtnLocked;
    pnlMesAnoOrigem: TPanel;
    Label4: TLabel;
    Bevel2: TBevel;
    mskDtaOrigem: TMaskEditFocus;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    mskPeriodo: TMaskEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dbgItensKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCopiarMetasClick(Sender: TObject);
  private
    qryTabela : TZClient;
    dtsTabela : TDataSource;
    strAutoInc: String;
    arrAutDel : Array of String;
    intNumAlt : Integer;

    procedure pLiberaEdicao(blnLibera : Boolean);
    function fGetSql : String;

    procedure pLimpaCampos;
    procedure pCarregaDados;
    procedure pDeletaItem;
    procedure pCopiaMeta;

//    procedure pAfterOpen(dtsDados: TDataSet);
//    procedure pAfterClose(dtsDados: TDataSet);

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses SysUtils, Forms, DateUtils, untConsultas, untFuncoesConsulta, untFuncoesSimples,
  untTypesSistema;

{$R *.dfm}

{ TfrmCadMetasRapel }

procedure TfrmCadMetasRapel.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If not fValidaPanel(pnlCorpo) then
    Exit;

  With qryTabela Do
  Begin
    If fEmptyStr(strAutoInc) Then
    Begin
      Insert;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADRAP', edtCodEmpresa.Text);
    End
    Else
    Begin
      Locate('AUTOINCREM', strAutoInc, []);
      Edit;
    End;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      FieldByName('RAP_CODEMP').AsString := edtCodEmpresa.Text;

    FieldByName('RAP_PERIOD').AsString := mskPeriodo.Text;
    FieldByName('RAP_CODFOR').AsString := edtCodFor.Text;
    FieldByName('RAP_VALMET').AsFloat  := fStrToFloat(edtMeta.Text);
    FieldByName('RAP_RAPEL_').AsFloat  := fStrToFloat(edtRapel.Text);
    FieldByName('FOR_NOMFOR').AsString := fRetNomFornecedor(edtCodFor.Text);

    Post;

    Inc(intNumAlt);

    strAutoInc := EmptyStr;
  End;
  pLimpaCampos

end;

procedure TfrmCadMetasRapel.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
  strAutoInc := EmptyStr;
    
end;

procedure TfrmCadMetasRapel.btnConfirmaClick(Sender: TObject);
  Var
    qryInsert : TUniQuery;

  Procedure pAddAtualiza;
  Begin
    With qryInsert, SQL Do
    Begin
      Clear;

      Add( 'REPLACE INTO CADRAP ( ');
      Add( '  AUTOINCREM, ');
      Add( '  RAP_CODEMP, ');
      Add( '  RAP_PERIOD, ');
      Add( '  RAP_CODFOR, ');
      Add( '  RAP_VALMET, ');
      Add( '  RAP_RAPEL_  ');
      Add( ') VALUES (    ');
      Add( '  :AUTOIN,    ');
      Add( '  :CODEMP,    ');
      Add( '  :PERIOD,    ');
      Add( '  :CODFOR,    ');
      Add( '  :VALMET,    ');
      Add( '  :RAPEL_     ');
      Add( ')             ');

      ParamByName('AUTOIN').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      ParamByName('CODEMP').Value    := qryTabela.FieldByName('RAP_CODEMP').Value;
      ParamByName('PERIOD').AsString := qryTabela.FieldByName('RAP_PERIOD').AsString;
      ParamByName('CODFOR').AsString := qryTabela.FieldByName('RAP_CODFOR').AsString;
      ParamByName('VALMET').AsFloat  := qryTabela.FieldByName('RAP_VALMET').AsFloat;
      ParamByName('RAPEL_').AsFloat  := qryTabela.FieldByName('RAP_RAPEL_').AsFloat;

      ExecSQL;

    End;

  End;

  procedure pDeletaItens;
    Var
      intContador : Integer;
      qryDeleta : TUniQuery;
  Begin
    Try
      qryDeleta := fCriaQuery(Self);
      With qryDeleta Do
      Begin
        SQL.Add(' DELETE FROM CADRAP WHERE AUTOINCREM = :AUTOINC ');

        For intContador := Low(arrAutDel) To High(arrAutDel) Do
        Begin
          ParamByName('AUTOINC').AsString := arrAutDel[intContador];
          ExecSQL;
        End;

      End;
    Finally
      FreeAndNil(qryDeleta);
    End;

  End;

begin
//  inherited;

  If fMensagem('ATENÇÃO', 'Deseja gravar as alterações realizadas?', ['&Sim', '&Não']) = 2 Then
    Exit; 

  With qryTabela Do
  Begin
    Try
      qryInsert := fCriaQuery(Self);

      DisableControls;

      First;
      While not Eof Do
      Begin
        pAddAtualiza;
        Next;
      End;
      First;

      pDeletaItens;

      mskPeriodo.Clear;
      pLiberaEdicao(False);
      pLimpaCampos;
      pSetFocus(mskPeriodo);

      If qryTabela.Active Then
        qryTabela.EmptyDataSet;

    Finally
      EnableControls;
      FreeAndNil(qryInsert);
    End;


  End;

end;

procedure TfrmCadMetasRapel.btnCopiarMetasClick(Sender: TObject);
begin
  inherited;

  If Not btnCopiarMetas.Enabled Then
    Exit;

  If pnlMesAnoOrigem.Visible Then
  Begin
    pnlMesAnoOrigem.Visible := False;
    mskDtaOrigem.Clear;
  End Else
  Begin
    pnlMesAnoOrigem.Visible := True;
    blnMudarFoco := True;
    pSetFocus(mskDtaOrigem);
  End;

end;

procedure TfrmCadMetasRapel.btnSairClick(Sender: TObject);
begin
  If (intNumAlt > 0) And
     (fMensagem('ATENÇÃO', 'Realmente deseja cancelar todas as alteraçoes realizadas sem salvar?', ['&Sim', '&Não']) = 2) then
    Exit; 


  If not pnlCabecalho.Enabled Then
  Begin
    pLiberaEdicao(False);
    pLimpaCampos;
    mskPeriodo.Clear;
    pSetFocus(mskPeriodo);
  End
  Else
    inherited;  

end;

procedure TfrmCadMetasRapel.dbgItensKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN : pCarregaDados;
    VK_DELETE : pDeletaItem;
  End;
end;

procedure TfrmCadMetasRapel.edtCodEmpresaExit(Sender: TObject);
  Var
    arrEmpresa : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa,edtDesEmpresa,arrEmpresa,fRetNomeEmpresa,nil,'da Empresa');
end;

procedure TfrmCadMetasRapel.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmpresa : TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, True, True) Then
  Begin
    fvalidaCampos(edtCodEmpresa,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadMetasRapel.edtCodForExit(Sender: TObject);
  Var
    arrCodFor : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrCodFor, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmCadMetasRapel.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCodFor : TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrCodFor, True) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCadMetasRapel.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + ' CADRAP.AUTOINCREM,  ';
  Result := Result + '        RAP_CODEMP,  ';
  Result := Result + '        RAP_PERIOD,  ';
  Result := Result + '        RAP_CODFOR,  ';
  Result := Result + '        RAP_VALMET,  ';
  Result := Result + '        RAP_RAPEL_,  ';
  Result := Result + '        FOR_NOMFOR   ';
  Result := Result + ' FROM CADRAP         ';
  Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = RAP_CODFOR ';

  Result := Result + ' WHERE  ';
  Result := Result + '   RAP_PERIOD = :PERIOD AND ';

  If fEmptyStr(edtCodEmpresa.Text) Then
    Result := Result + '   RAP_CODEMP IS NULL '
  Else
    Result := Result + '   RAP_CODEMP = :CODEMP '
end;

procedure TfrmCadMetasRapel.pCopiaMeta;
  Var
    qryCadRap: TUniQuery;
Begin
  qryCadRap := fCriaQuery;
  With qryCadRap Do
  Begin
    SQL.Text := fGetSql;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    ParamByName('PERIOD').AsString := mskDtaOrigem.Text;

    Open;

    While Not Eof Do
    Begin

      If qryTabela.Locate('RAP_CODFOR', FieldByName('RAP_CODFOR').AsString, []) Then
      Begin
        qryTabela.Edit;
      End Else
      Begin
        qryTabela.Insert;
        qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADRAP', edtCodEmpresa.Text);
      End;

      qryTabela.FieldByName('RAP_CODEMP').Value    := FieldByName('RAP_CODEMP').Value;
      qryTabela.FieldByName('RAP_PERIOD').AsString := mskPeriodo.Text;
      qryTabela.FieldByName('RAP_CODFOR').AsString := FieldByName('RAP_CODFOR').AsString;
      qryTabela.FieldByName('RAP_VALMET').AsFloat  := FieldByName('RAP_VALMET').AsFloat;
      qryTabela.FieldByName('RAP_RAPEL_').AsFloat  := FieldByName('RAP_RAPEL_').AsFloat;
      qryTabela.FieldByName('FOR_NOMFOR').AsString := fRetNomFornecedor(FieldByName('RAP_CODFOR').AsString);

      qryTabela.Post;

      Inc(intNumAlt);

      Next;
    End;

    If IsEmpty Then
    Begin
      pMensagemOk('Nenhuma meta cadastrada para esse período!')
    End Else
    Begin
      mskDtaOrigem.Clear;
      pnlMesAnoOrigem.Visible := False;
      pMensagemOk('Metas copiadas com sucesso!')
    End;
  End;
  FreeAndNil(qryCadRap);
End;

(*
procedure TfrmCadMetasRapel.pAfterOpen(dtsDados: TDataSet);
Begin
  btnCopiarMetas.Enabled := True;
End;

procedure TfrmCadMetasRapel.pAfterClose(dtsDados: TDataSet);
Begin
  btnCopiarMetas.Enabled := False;
End;
*)

procedure TfrmCadMetasRapel.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela := TZClient.Create(Self, fGetSql);
  dtsTabela := TDataSource.Create(Self);

  dtsTabela.DataSet   := qryTabela;
  dbgItens.DataSource := dtsTabela;

//  qryTabela.AfterOpen := pAfterOpen;
//  qryTabela.AfterClose:= pAfterClose;
end;

procedure TfrmCadMetasRapel.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryTabela);
  FreeAndNil(dtsTabela);

end;

procedure TfrmCadMetasRapel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_F11: btnCopiarMetas.Click;
  End;
end;

procedure TfrmCadMetasRapel.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskPeriodo);
  edtCodEmpresa.Text := VS_strCodEmp;
  edtCodEmpresaExit(edtCodEmpresa);

end;

function TfrmCadMetasRapel.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intAno,
    intMes,
    intDia: Word;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaOrigem) Then
    Begin

      If pnlMesAnoOrigem.Visible Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaOrigem.Text)) Then
        Begin
          fMensagem('', 'Informar o mês / ano de origem !', ['&O k']);
          Result := False;
        End
        Else
        Begin
          mskDtaOrigem.Text := FormatDateTime('MM/YYYY', StrToDateDef('01/' + mskDtaOrigem.Text, 0));

          Try
            strToDate('01/' + mskDtaOrigem.Text);
          Except
            fMensagem('', 'Mês / Ano inválido !', ['&O k']);
            Result := False;
          End;

          If Result Then
            pCopiaMeta;

        End;
      End Else
      Begin
        mskDtaOrigem.Clear;
      End;

    End

    Else If (Sender = mskPeriodo) Then
    Begin

      If Not fEmptyDate(mskPeriodo.Text) Then
        mskPeriodo.Text := FormatDateTime('MM/YYYY', StrToDateDef('01/' + mskPeriodo.Text, 0));

      intAno := StrToIntDef(Copy(mskPeriodo.Text, 4, 4),0);
      intMes := StrToIntDef(Copy(mskPeriodo.Text, 1, 2),0);
      intDia := 1;

      If Not IsValidDate(intAno, intMes, intDia) Then
      Begin
        pLiberaEdicao(False);
        Result := False;
        fMensagem('ATENÇÃO', 'O período informado é inválido!', ['OK']);
      End;

    End

    Else
    If (Sender = edtCodEmpresa) Then
    Begin
      If fEmptyStr(fRetNomeEmpresaSelec(edtCodEmpresa.Text)) then
        edtDesEmpresa.Text := 'TODAS';

      If Not fEmptyDate(mskPeriodo.Text) Then
        mskPeriodo.Text := FormatDateTime('MM/YYYY', StrToDateDef('01/' + mskPeriodo.Text, 0));

      intAno := StrToIntDef(Copy(mskPeriodo.Text, 4, 4),0);
      intMes := StrToIntDef(Copy(mskPeriodo.Text, 1, 2),0);
      intDia := 1;

      If IsValidDate(intAno, intMes, intDia) Then
      Begin
        pLiberaEdicao(True);
        SetLength(arrAutDel, 0);
        intNumAlt := 0;
      End
      Else
      Begin
        pLiberaEdicao(False);
        Result := False;
        fMensagem('ATENÇÃO', 'O período informado é inválido!', ['OK']);
      End;

    End

    Else
    If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(fRetNomFornecedor(edtCodFor.Text)) then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'O fornecedor informado é inválido!', ['OK']);
      End
      Else
      If blnBuscaPorChave And qryTabela.Locate('RAP_CODFOR', edtCodFor.Text, []) Then
        pCarregaDados;
    End

    Else
    If (Sender = edtRapel) Then
    Begin
      If fStrToFloat(edtRapel.Text) <= 0 Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'O valor do rapel deve ser maior que zero!', ['&OK']);
      End;
    End
    Else
    If (Sender = edtMeta) Then
    Begin
      If fStrToFloat(edtMeta.Text) <= 0 Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'O valor da meta deve ser maior que zero!', ['&OK']);
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadMetasRapel.pCarregaDados;
begin
  With qryTabela Do
  Begin
    edtCodFor.Text := FieldByName('RAP_CODFOR').AsString;
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
    edtMeta.Text   := FormatFloat('#,##0.00', FieldByName('RAP_VALMET').AsFloat);
    edtRapel.Text  := FormatFloat('#,##0.00', FieldByName('RAP_RAPEL_').AsFloat);
    strAutoInc     := FieldByName('AUTOINCREM').AsString;
    pSetFocus(edtCodFor);

    If not qryTabela.ControlsDisabled Then
      qryTabela.DisableControls;
  End;
end;

procedure TfrmCadMetasRapel.pDeletaItem;
begin
  If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Exit;
    
  SetLength(arrAutDel, Length(arrAutDel) + 1);
  arrAutDel[High(arrAutDel)] := qryTabela.FieldByName('AUTOINCREM').AsString;
  qryTabela.Delete;

  Inc(intNumAlt);  

end;

procedure TfrmCadMetasRapel.pLiberaEdicao(blnLibera: Boolean);
begin
  pnlCabecalho.Enabled := not blnLibera;
  pnlCorpo.Enabled     := blnLibera;

  If blnLibera Then
  Begin
    qryTabela.qryQuery.SQL.Text := fGetSql;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      qryTabela.qryQuery.ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    qryTabela.qryQuery.ParamByName('PERIOD').AsString := mskPeriodo.Text;
    qryTabela.fAbreClient(True, 'TfrmCadMetasRapel.pLiberaEdicao');

    TFloatField(qryTabela.FieldByName('RAP_VALMET')).DisplayFormat := '#,##0.00';
    TFloatField(qryTabela.FieldByName('RAP_RAPEL_')).DisplayFormat := '#,##0.00';

    pSetaClient(qryTabela);

    btnCopiarMetas.Enabled := True;
  End Else
  Begin
    If qryTabela.Active Then
      qryTabela.EmptyDataSet;

    btnCopiarMetas.Enabled := False;
  End;

end;

procedure TfrmCadMetasRapel.pLimpaCampos;
begin
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtMeta.Text := '0,00';
  edtRapel.Text := '0,00';
  pSetFocus(edtCodFor);

  If qryTabela.ControlsDisabled Then
    qryTabela.EnableControls;

end;

end.
