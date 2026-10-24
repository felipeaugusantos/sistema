unit untCadMetas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls,
  DBEditFocus, Grids, DBGridCitel, DBGrids, MaskEditFocus, DB, StrUtils,
    Uni, UniDataSetProvider, UniClientDataSet,
  CheckLst, DateUtils, UntSeqTmp, AppEvnts;

type
  TfrmCadMetas = class(TfrmPai)
    dbgMetas: TDBGridCitel;
    btnConfirmar: TBitBtn;
    btnCopiarMetas: TBitBtn;
    pnlMesAnoAtual: TPanel;
    pnlMesAnoOrigem: TPanel;
    Label1: TLabel;
    mskDtaOrigem: TMaskEditFocus;
    Bevel1: TBevel;
    btnCancelar: TBitBtn;
    mskDtaAtual: TMaskEditFocus;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgMetasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCopiarMetasClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure mskDtaAtualExit(Sender: TObject);
    procedure dbgMetasKeyPress(Sender: TObject; var Key: Char);
    procedure mskDtaOrigemExit(Sender: TObject);
  private
    { Private declarations }

    strTabela: String;

    procedure pCriaTemporaria(blnMudarPeriodo: Boolean; strMesAno: String);
    procedure pDeletaTemporaria;
  public
    { Public declarations }

    strMesAno   : String;
    strMesAnoOri: String;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadMetas: TfrmCadMetas;

implementation

uses untFuncoes, untfuncoesSimples, untModuloCadMet, UntModulo, untModuloCadOpe;

Var
  qryTmpCadMet: TUniQuery;
  dtsTmpCadMet: TDataSource;

{$R *.dfm}

procedure TfrmCadMetas.btnConfirmarClick(Sender: TObject);
  Var
    strSQL: String;
begin
  qryTabela := fCriaQuery;
  
  If fMensagem('','Tem certeza que deseja gravar estas metas?',['&Sim','&Não']) = 2 Then
    Exit;

  qryTmpCadMet.DisableControls;

  Try

    With qryTabela Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  CADMET ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  MET_MESANO = :MESANO ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('MESANO').AsString := strMesAno;
      ExecSQL;
      Close;

      strSQL := '';
      strSQL := strSQL + 'INSERT INTO CADMET ';;
      strSQL := strSQL + 'VALUES ( ';
      strSQL := strSQL + '        :AUTOINCREM, ';
      strSQL := strSQL + '        :CODEMP, ';
      strSQL := strSQL + '        :MESANO, ';
      strSQL := strSQL + '        :CODVEN, ';
      strSQL := strSQL + '        :TOTMET';
      strSQL := strSQL + '       )';

      qryTmpCadMet.First;

      While Not qryTmpCadMet.Eof Do
      Begin

        If qryTmpCadMet.FieldByName('TOTMET').AsFloat <> 0 Then
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CADMET', VS_strCodEmp);
          ParamByName('CODEMP').AsString     := VS_strCodEmp;
          ParamByName('MESANO').AsString     := strMesAno;
          ParamByName('CODVEN').AsString     := qryTmpCadMet.FieldByName('CODVEN').AsString;
          ParamByName('TOTMET').AsFloat      := qryTmpCadMet.FieldByName('TOTMET').AsFloat;
          ExecSQL;
          Close;
        End;
        
        qryTmpCadMet.Next;
      End;

    End;

    fCommit;
    fMensagem('','Metas gravadas com sucesso!',['&OK']);

  Except
    On E: Exception Do
    Begin

      fRollBack;
      FreeAndNil(qryTabela);
			pMensagensErro(E.Message,'[TfrmCadMetas.btnConfirmarClick]');
      qryTmpCadMet.EnableControls;

    End;

  End;

  qryTmpCadMet.EnableControls;
  FreeAndNil(qryTabela);
  pnlMesAnoOrigem.Visible := False;
  pCriaTemporaria(True, strMesAno);
  dbgMetas.SetFocus;
end;

procedure TfrmCadMetas.FormCreate(Sender: TObject);
begin
  inherited;
  //******************************************//
  // CRIAR E CONFIGURA COMPONENTES TEMP.      //
  //***************************************RL*//
  qryTmpCadMet := fCriaQuery;
  dtsTmpCadMet := TDataSource.Create(Self);

  dtsTmpCadMet.DataSet := qryTmpCadMet;
  dbgMetas.DataSource  := dtsTmpCadMet;

  //*****************************************//
  // ADICIONAR E CONFIGURAR COLUNAS NA GRID  //
  //**************************************RL*//
  dbgMetas.Columns.Add;
  dbgMetas.Columns.Items[0].FieldName := 'NOMOPE';
  dbgMetas.Columns.Items[0].Width     := 300;

  dbgMetas.Columns.Add;
  dbgMetas.Columns.Items[1].FieldName       := 'TOTMET';
  dbgMetas.Columns.Items[1].Title.Alignment := taRightJustify;
  dbgMetas.Columns.Items[1].Width           := 150;
end;

//***************************************//
// CRIAR TABELA TEMPORÁRIA               //
//************************************RL*//
procedure TfrmCadMetas.pCriaTemporaria(blnMudarPeriodo: Boolean; strMesAno: String);
  Var
    strSQL: String;
Begin
  Try
    If blnMudarPeriodo Then
      fDropTable(strTabela);

    //********************************************//
    // CASO TENHA ALGUM VENDEDO COM A META        //
    // CADASTRADA COM VALOR 0 PARA UM DETERMINADO //
    // PERÍODO, ENTÃO, EXCLUI ESSE VENDEDOR       //
    //*****************************************RL*//
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM CADMET ';
    strSQL := strSQL + '  WHERE MET_MESANO = :MESANO AND';
    strSQL := strSQL + '        MET_TOTMET = 0 ';

    With qryTmpCadMet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('MESANO').AsString := strMesAno;
      ExecSQL;
    End;

    strTabela := 'TMP_CADMET' + fRetSeqTmp;

    //***************************************//
    // MONTA TABELA TEMPORÁRIA               //
    //************************************RL*//
    strSQL := '';
    strSQL := strSQL + ' CREATE TABLE ' + strTabela;
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   M.AUTOINCREM AUTOINCREM, ';
    strSQL := strSQL + '   M.MET_CODVEN CODVEN, ';
    strSQL := strSQL + '   O.OPE_NOMOPE ORDNOM, '; //TRAGO ESSA COLUNA NO SELECT APENAS PARA ORDENAR O RESULTADO DA QUERY NO GRID
    strSQL := strSQL + '   CONCAT(O.OPE_CODOPE, " - ", O.OPE_NOMOPE) NOMOPE, ';
    strSQL := strSQL + '   M.MET_CODEMP CODEMP, ';
    strSQL := strSQL + '   M.MET_MESANO MESANO, ';
    strSQL := strSQL + '   M.MET_TOTMET TOTMET ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADOPE O, ';
    strSQL := strSQL + '   CADMET M ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   M.MET_CODVEN = O.OPE_CODOPE AND ';
    strSQL := strSQL + '   M.MET_MESANO = :MESANO ';

    strSQL := strSQL + ' UNION ALL ';

    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   ""         AUTOINCREM, ';
    strSQL := strSQL + '   OPE_CODOPE CODVEN, ';
    strSQL := strSQL + '   OPE_NOMOPE ORDNOM, '; //TRAGO ESSA COLUNA NO SELECT APENAS PARA ORDENAR O RESULTADO DA QUERY NO GRID
    strSQL := strSQL + '   CONCAT(OPE_CODOPE, " - ", OPE_NOMOPE) NOMOPE, ';
    strSQL := strSQL + '   OPE_CODEMP CODEMP, ';
    strSQL := strSQL + '   ""         MESANO, ';
    strSQL := strSQL + '   0          TOTMET ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADOPE ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   OPE_CODOPE NOT IN (SELECT MET_CODVEN FROM CADMET WHERE MET_MESANO = :MESANO) ';
    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + '   ORDNOM ';

    With qryTmpCadMet Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('MESANO').AsString := strMesAno;
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ' + strTabela);
      Open;

      //****************************************//
      // CONFIGURAR FIELDS DA TABELA TEMPORÁRIA //
      //*************************************RL*//
      FieldByName('AUTOINCREM').Visible := False;
      FieldByName('CODVEN').Visible     := False;
      FieldByName('CODEMP').Visible     := False;
      FieldByName('MESANO').Visible     := False;
      FieldByName('ORDNOM').Visible     := False;

      (FieldByName('TOTMET') As TFloatField).DisplayFormat := '#,###0.00';
      (FieldByName('MESANO') As TStringField).EditMask     := '99/9999;0';
      FieldByName('NOMOPE').DisplayLabel                   := 'Vendedor';
      FieldByName('TOTMET').DisplayLabel                   := 'Valor';
      FieldByName('NOMOPE').ReadOnly                       := True;
    End;

  Except
  	On E: Exception Do
    Begin
    	pMensagensErro(E.Message,'[TfrmCadMetas.pCriaTemporaria]');
    End;
  End;
End;

//***************************************//
// DELETAR TABELA TEMPORÁRIA             //
//************************************RL*//
procedure TfrmCadMetas.pDeletaTemporaria;
Begin

  If Not fEmptyStr(strTabela) Then
    fDropTable(strTabela);

End;

procedure TfrmCadMetas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pDeletaTemporaria;
  FreeAndNil(dtsTmpCadMet);
  FreeAndNil(qryTmpCadMet);
end;

procedure TfrmCadMetas.dbgMetasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) And (qryTmpCadMet.State = dsEdit) Then
    qryTmpCadMet.Cancel;

end;

procedure TfrmCadMetas.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaAtual.Text := FormatDateTime('mm/yyyy', VS_Date);
  strMesAno        := AnsiReplaceStr(mskDtaAtual.Text, '/', '');
  pCriaTemporaria(False, strMesAno);

end;

procedure TfrmCadMetas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
  Begin
    Key := 0;
    btnConfirmar.Click;
  End

  Else If (Key = VK_Escape) And (pnlMesAnoOrigem.Visible) Then
  Begin
    btnCancelar.Click;
  End

  Else If (Key = VK_Escape) And (qryTmpCadMet.State <> dsEdit) And
   (ActiveControl = dbgMetas) Then
  Begin
    mskDtaAtual.SetFocus;
  End

  Else If (Key = VK_Escape) And (ActiveControl = mskDtaAtual) And
    (qryTmpCadMet.State <> dsEdit) Then
  Begin
    btnSair.Click;
  End

  Else If (Key = VK_F11) Then
  Begin
    Key := 0;
    btnCopiarMetas.Click;
  End;
end;

procedure TfrmCadMetas.btnCopiarMetasClick(Sender: TObject);
begin
  inherited;
  pnlMesAnoOrigem.Visible := True;
  pnlMesAnoOrigem.Tag := 1;
  mskDtaOrigem.SetFocus;
end;

procedure TfrmCadMetas.pEscapePressed;
begin
  If pnlMesAnoOrigem.Tag = 0 Then
    inherited
  Else
    pnlMesAnoAtual.Tag := 0;
end;

procedure TfrmCadMetas.btnCancelarClick(Sender: TObject);
begin
  inherited;

  pnlMesAnoOrigem.Visible := False;
  pCriaTemporaria(True, strMesAno);
  dbgMetas.SetFocus;
end;

function TfrmCadMetas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {**************************************}
    {* VALIDA DATA DE ORIGEM              *}
    {***********************************RL*}
    If (Sender = mskDtaOrigem) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaOrigem.Text)) Then
      Begin
        fMensagem('', 'Informar o mês / ano de origem !', ['&O k']);
        Result := False;
      End
      Else
      Begin

        Try
          strToDate('01/' + mskDtaOrigem.Text)
        Except
          fMensagem('', 'Mês / Ano inválido !', ['&O k']);
          Result := False;
        End;

      End;

    End

    {**************************************}
    {* VALIDA DATA ATUAL                  *}
    {***********************************RL*}
    Else If (Sender = mskDtaAtual) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaAtual.Text)) Then
      Begin
        fMensagem('', 'Informar o mês / ano atual !', ['&O k']);
        Result := False;
      End
      Else
      Begin

        Try
          strToDate('01/' + mskDtaAtual.Text);
        Except
          fMensagem('', 'Mês / Ano inválido !', ['&O k']);
          Result := False;
        End;

      End;
    End;
  End;

  If Not Result Then
    Sender.SetFocus;
end;

procedure TfrmCadMetas.mskDtaAtualExit(Sender: TObject);
  Var
    strAno: String;
    strMes: String;
begin
  inherited;

  //**********************************************//
  // COMPLETA O ANO PARA 4 DÍGITOS CASO O USUÁRIO //
  // DIGITE APENAS DOIS DÍGITOS NO ANO. EX:       //
  // SE FOR DIGITADO 07, COMPLETA PARA 2007       //
  //*******************************************RL*//
  If (RightStr(mskDtaAtual.Text,4) <> '') And (LeftStr(mskDtaAtual.Text,2) <> '') Then
  Begin
    strMes := Trim(LeftStr(mskDtaAtual.Text,2));
    strAno := Trim(RightStr(mskDtaAtual.Text,4));

    If Length(strAno) = 1 Then
      mskDtaAtual.Text := strMes + '/200' + strAno

    Else If Length(strAno) = 2 Then
      mskDtaAtual.Text := strMes + '/20' + strAno

    Else If Length(strAno) = 3 Then
      mskDtaAtual.Text := strMes + '/2' + strAno;

    strMesAno := AnsiReplaceStr(mskDtaAtual.Text, '/', '');
    pCriaTemporaria(True, strMesAno);
  End;
end;

procedure TfrmCadMetas.dbgMetasKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If (Key = '-') Then
    Key := #0;
    
end;

procedure TfrmCadMetas.mskDtaOrigemExit(Sender: TObject);
  Var
    strAno: String;
    strMes: String;
begin
  inherited;

  //**********************************************//
  // COMPLETA O ANO PARA 4 DÍGITOS CASO O USUÁRIO //
  // DIGITE APENAS DOIS DÍGITOS NO ANO. EX:       //
  // SE FOR DIGITADO 07, COMPLETA PARA 2007       //
  //*******************************************RL*//
  If (RightStr(mskDtaOrigem.Text,4) <> '') And (LeftStr(mskDtaOrigem.Text,2) <> '') Then
  Begin
    strMes := Trim(LeftStr(mskDtaOrigem.Text,2));
    strAno := Trim(RightStr(mskDtaOrigem.Text,4));

    If Length(strAno) = 1 Then
      mskDtaOrigem.Text := strMes + '/200' + strAno
    Else If Length(strAno) = 2 Then
      mskDtaOrigem.Text := strMes + '/20' + strAno
    Else If Length(strAno) = 3 Then
      mskDtaOrigem.Text := strMes + '/2' + strAno;

    strMesAnoOri := AnsiReplaceStr(mskDtaOrigem.Text, '/', '');
    pCriaTemporaria(True, strMesAnoOri);
  End;

end;

end.


