unit untFatLiberacaoRomaneio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,  
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, untZClient,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, BitBtnLockedIncrem, MemDS,
  DBAccess, Provider, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmFatLiberacaoRomaneio = class(TfrmPaiOrdena)
    btnMarca: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    rdgLibRom: TRadioGroup;
    btnCarregarRomaneios: TBitBtnLocked;
    btnCancelarRomaneios: TBitBtnLocked;
    Panel1: TPanel;
    btnCancLiber: TBitBtnLocked;
    dbgDocumentos: TDBGridCitel;
    btnImpRom: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCarregarRomaneiosClick(Sender: TObject);
    procedure btnCancelarRomaneiosClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure btnCancLiberClick(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure btnImpRomClick(Sender: TObject);
  private
    strOperadorLiberacao: String;
    cdsDocumentos: TZClient;
    
    procedure pRealizaLiberacoes;
    procedure pLiberarRomaneio(strNumeroRomaneio, strEmpresaRomaneio: String);
    procedure pCancelarLiberacao(strNumeroRomaneio, strEmpresaRomaneio: String);

    function fGetSqlDocumentos: String;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
    function fGetActiveControl: TWinControl; override;    
  end;

implementation

uses untFuncoesSimples, untGravando, untRomGer, untFuncoesRel;

function TfrmFatLiberacaoRomaneio.fGetActiveControl: TWinControl;
begin
  btnCancelarRomaneios.Click;
  Result := TWinControl(rdgLibRom.Controls[rdgLibRom.ItemIndex]);
end;

function TfrmFatLiberacaoRomaneio.fGetSql(blnLike: Boolean): String;
  Var
    strSql : String;
begin
  strSql := '';
  strSql := strSql + 'SELECT ';
  strSql := strSql + '  ROM.GER_NUMROM AS NUMROM, ';
  strSql := strSql + '  ROM.GER_EMPROM AS EMPROM, ';
  strSql := strSql + '  ROM.GER_DTAROM AS DTAROM, ';
  strSql := strSql + '  ROM.GER_DTALIB AS DTALIB, ';
  strSql := strSql + '  ROM.GER_HORLIB AS HORLIB, ';  
  strSql := strSql + '  MOT.MOT_NOMMOT AS NOMMOT, ';
  strSql := strSql + '  TRA.TRA_NOMTRA AS NOMTRA, ';
  strSql := strSql + '  OPR.OPE_NOMOPE AS OPEROM, ';
  strSql := strSql + '  OPL.OPE_NOMOPE AS OPELIB, ';
  strSql := strSql + '  COUNT(*)       AS QTDDOC, ';
  strSql := strSql + '  CONCAT(ROM.GER_NUMROM, ROM.GER_CODEMP) AS AUTOINCREM ';  
  strSql := strSql + 'FROM                        ';
  strSql := strSql + '  ROMGERX ROM               ';
  strSql := strSql + '  LEFT JOIN CADMOT MOT ON MOT.MOT_CODMOT = ROM.GER_CODMOT ';
  strSql := strSql + '  LEFT JOIN CADTRA TRA ON TRA.TRA_CODTRA = ROM.GER_CODTRA ';
  strSql := strSql + '  LEFT JOIN CADOPE OPR ON OPR.OPE_CODOPE = ROM.GER_OPEROM ';
  strSql := strSql + '  LEFT JOIN CADOPE OPL ON OPL.OPE_CODOPE = ROM.GER_OPELIB ';
  strSql := strSql + 'WHERE ';  
  strSql := strSql + '  GER_DTABAI IS NULL AND ';
  strSql := strSql + '  GER_EMPROM = ' + QuotedStr(VS_strCodEmp) + ' AND ';  

  Case rdgLibRom.ItemIndex Of
    0: strSql := strSql + ' GER_DTALIB IS NULL ';
    1: strSql := strSql + ' GER_DTALIB IS NOT NULL ';
  End;

  strSql := strSql + 'GROUP BY  ';
  strSql := strSql + '  NUMROM, ';
  strSql := strSql + '  EMPROM  ';

  Result := strSql;
end;

function TfrmFatLiberacaoRomaneio.fGetSqlDocumentos: String;
  Var
    strSql : String;
begin
  strSql := '';
  strSql := strSql + 'SELECT ';
  strSql := strSql + '  GER_NUMROM AS NUMROM, ';
  strSql := strSql + '  GER_EMPROM AS EMPROM, ';
  strSql := strSql + '  GER_NUMDOC AS NUMDOC, ';
  strSql := strSql + '  GER_ESPDOC AS ESPDOC, ';
  strSql := strSql + '  GER_CODEMP AS CODEMP, ';
  strSql := strSql + '  GER_DTAENT AS DTAENT, ';
  strSql := strSql + '  CLI_NOMCLI AS NOMCLI  ';
  strSql := strSql + 'FROM                    ';
  strSql := strSql + '  ROMGERX               ';
  strSql := strSql + '  LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
  strSql := strSql + 'WHERE ';  
  strSql := strSql + '  GER_DTABAI IS NULL AND ';
  strSql := strSql + '  GER_EMPROM = ' + QuotedStr(VS_strCodEmp) + ' AND ';  

  Case rdgLibRom.ItemIndex Of
    0: strSql := strSql + ' GER_DTALIB IS NULL ';
    1: strSql := strSql + ' GER_DTALIB IS NOT NULL ';
  End;

  strSql := strSql + 'GROUP BY  ';
  strSql := strSql + '  NUMDOC, ';
  strSql := strSql + '  ESPDOC, ';
  strSql := strSql + '  CODEMP, ';
  strSql := strSql + '  NUMROM  ';

  Result := strSql;
end;

function TfrmFatLiberacaoRomaneio.fAbreConsulta(blnLike: Boolean): Boolean;
begin
  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  cdsDocumentos.Close;
  cdsDocumentos.qryQuery.Close;
  cdsDocumentos.qryQuery.SQL.Text := fGetSqlDocumentos;

  Result := cdsDocumentos.fAbreClient(True, 'TfrmFatLiberacaoRomaneio.fAbreConsulta') And inherited fAbreConsulta(blnLike);

  If cdsConsulta.IsEmpty Then
  Begin
    pMensagemOk('Não foram encontrados Romaneios!');
    Result := False;
  End;
  
end;

{$R *.dfm}

procedure TfrmFatLiberacaoRomaneio.FormShow(Sender: TObject);
begin
  inherited;
  cdsDocumentos := TZClient.Create(Self);
  dbgDocumentos.DataSource := cdsDocumentos.dtsSource;

  pConfiguraPopup(btnImpRom);

  blnQuoteLista := False;  
  blnSempreRelerBanco := False;
  btnCancelarRomaneios.Click;
end;

procedure TfrmFatLiberacaoRomaneio.btnMarcaClick(Sender: TObject);
begin
  inherited;
  If btnMarca.Enabled Then
  Begin
    stlListSelecao.Clear;

    With cdsConsulta Do
    Begin

      First;
      DisableControls;

      While Not Eof Do
      Begin
        pAddListaQuery;
        Next;
      End;

      EnableControls;

    End;
  End;    
end;

procedure TfrmFatLiberacaoRomaneio.btnMudaOrdemClick(Sender: TObject);
begin
  If cdsConsulta.Active Then
    inherited;
end;

procedure TfrmFatLiberacaoRomaneio.btnPesquisarClick(Sender: TObject);
begin
  If cdsConsulta.Active Then
    inherited;
end;

procedure TfrmFatLiberacaoRomaneio.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  With cdsDocumentos Do
  Begin
    If Active Then
    Begin
      Filtered := False;
      Filter   := 'NUMROM = ' + QuotedStr(cdsConsulta.FieldByName('NUMROM').AsString) + ' AND ' +
                  'EMPROM = ' + QuotedStr(cdsConsulta.FieldByName('EMPROM').AsString);
      Filtered := True;                        
    End;
  End;
end;

procedure TfrmFatLiberacaoRomaneio.btnCancelarRomaneiosClick(Sender: TObject);
begin
  inherited;
  If cdsConsulta.Active Then
    cdsConsulta.Close;

  If cdsDocumentos.Active Then
    cdsDocumentos.Close;
    
  pLimpaPesquisa;

  stlListSelecao.Clear;      

  rdgLibRom.Enabled    := True;
  dbgConsulta.Enabled  := False;
  dbgDocumentos.Enabled:= False;
  btnGravar.Enabled    := False;
  btnMarca.Enabled     := False;
  btnDesmarca.Enabled  := False;
  btnMudaOrdem.Enabled := False;
  btnPesquisar.Enabled := False;
  btnCancLiber.Enabled := False;
  btnImpRom.Enabled    := False;

  pSetFocus(TWinControl(rdgLibRom.Controls[rdgLibRom.ItemIndex]));
end;

procedure TfrmFatLiberacaoRomaneio.btnCancLiberClick(Sender: TObject);
  Var
    strSenha: String;
begin
  inherited;         

  If Not btnCancLiber.Enabled Then
    Exit;

  If Not fPergunta('Confirma cancelamento da liberação do ' +
                   'Romaneio ' + cdsConsulta.FieldByName('NUMROM').AsString + '?') Then
    Exit;

  If ffrmSenha(strSenha, 'Senha do Operador de Cancelamento Liberação') Then
  Begin
    strOperadorLiberacao := fRetCodVendedor(strSenha);

    If fEmptyStr(strOperadorLiberacao) Then
      pMensagemOk('Operador de cancelamento de Liberação não encontrado!')

    Else If Not fVerificaAcessoSistema('CANLIBROM', strOperadorLiberacao) Then
      pMensagemOk('Operador não possui diereito de acesso para cancelamento de Liberação!')

    Else
    Begin
      pCancelarLiberacao(cdsConsulta.FieldByName('NUMROM').AsString, cdsConsulta.FieldByName('EMPROM').AsString);
      pMensagemOk('Cancelamento de Liberação realizada com sucesso!');
      cdsConsulta.Delete;

      If cdsConsulta.IsEmpty Then
        btnCancelarRomaneios.Click;      
    End;
  End;
    
end;

procedure TfrmFatLiberacaoRomaneio.pLiberarRomaneio(strNumeroRomaneio, strEmpresaRomaneio: String);
  Var
    qryUpd : TUniQuery;
begin

  qryUpd := fCriaQuery(Nil);

  With qryUpd Do
  Begin
    Close;
    SQL.Clear;

    SQL.Add('UPDATE ');
    SQL.Add('  ROMGERX ');
    SQL.Add('SET ');
    SQL.Add('  GER_DTALIB = :DTALIB, ');
    SQL.Add('  GER_HORLIB = :HORLIB, ');
    SQL.Add('  GER_OPELIB = :OPELIB  ');
    SQL.Add('WHERE ');
    SQL.Add('  GER_NUMROM = :NUMROM AND ');
    SQL.Add('  GER_EMPROM = :EMPROM ');

    ParamByName('DTALIB').AsDate   := VS_DATE;
    ParamByName('HORLIB').AsTime   := fTime();
    ParamByName('OPELIB').AsString := strOperadorLiberacao;
    ParamByName('NUMROM').AsString := strNumeroRomaneio;
    ParamByName('EMPROM').AsString := strEmpresaRomaneio;

    ExecSQL;

  End;

  FreeAndNil(qryUpd);

end;

procedure TfrmFatLiberacaoRomaneio.pCancelarLiberacao(strNumeroRomaneio, strEmpresaRomaneio: String);
  Var
    qryUpd : TUniQuery;
begin

  qryUpd := fCriaQuery(Nil);

  With qryUpd Do
  Begin
    Close;
    SQL.Clear;

    SQL.Add('UPDATE ');
    SQL.Add('  ROMGERX ');
    SQL.Add('SET ');
    SQL.Add('  GER_DTALIB = NULL, ');
    SQL.Add('  GER_HORLIB = NULL, ');
    SQL.Add('  GER_OPELIB = NULL  ');
    SQL.Add('WHERE ');
    SQL.Add('  GER_NUMROM = :NUMROM AND ');
    SQL.Add('  GER_EMPROM = :EMPROM ');

    ParamByName('NUMROM').AsString := strNumeroRomaneio;
    ParamByName('EMPROM').AsString := strEmpresaRomaneio;

    ExecSQL;

  End;

  FreeAndNil(qryUpd);

end;

procedure TfrmFatLiberacaoRomaneio.btnCarregarRomaneiosClick(Sender: TObject);
begin
  inherited;
  If fAbreConsulta(True) Then
  Begin
    rdgLibRom.Enabled    := False;
    dbgConsulta.Enabled  := True;
    dbgDocumentos.Enabled:= True;    
    btnMudaOrdem.Enabled := True;
    btnPesquisar.Enabled := True;
    btnGravar.Enabled    := rdgLibRom.ItemIndex = 0; //Nao Liberados
    btnMarca.Enabled     := rdgLibRom.ItemIndex = 0; //Nao Liberados
    btnDesmarca.Enabled  := rdgLibRom.ItemIndex = 0; //Nao Liberados
    blnTemSelecao        := rdgLibRom.ItemIndex = 0; //Nao Liberados
    btnCancLiber.Enabled := rdgLibRom.ItemIndex = 1; //Liberados
    btnImpRom.Enabled    := rdgLibRom.ItemIndex = 1; //Liberados
    pSetFocus(dbgConsulta);
  End;  
end;

procedure TfrmFatLiberacaoRomaneio.btnDesmarcaClick(Sender: TObject);
begin
  inherited;
  If btnDesmarca.Enabled Then
  Begin
    stlListSelecao.Clear;
    dbgConsulta.Repaint;
    cdsConsulta.First;
  End;
end;

procedure TfrmFatLiberacaoRomaneio.btnGravarClick(Sender: TObject);
  Var
    strSenha: String;
begin
  inherited;

  If Not btnGravar.Enabled Then
    Exit;   

  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
    Exit;

  pLimpaPesquisa;    

  If stlListSelecao.Count = 0 Then
    Exit;
    
  If Not fPergunta('Confirma Liberação dos Romaneios selecionados?') Then
    Exit;

  If ffrmSenha(strSenha, 'Senha do Operador de Liberação') Then
  Begin
    strOperadorLiberacao := fRetCodVendedor(strSenha);

    If fEmptyStr(strOperadorLiberacao) Then
      pMensagemOk('Operador de Liberação não encontrado!')

    Else If Not fVerificaAcessoSistema('LIBROM', strOperadorLiberacao) Then
      pMensagemOk('Operador não possui diereito de acesso para Liberação!')

    Else
    Begin
      TfrmGravando.fExecutarModal(pRealizaLiberacoes, 'Aguarde, Realizando Liberações...', '');
      pMensagemOk('Liberações concluídas com sucesso!');      
      btnCancelarRomaneios.Click;      
    End;
  End;
end;    

procedure TfrmFatLiberacaoRomaneio.btnImpRomClick(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'Aguarde, imprimindo romaneio...';

  if not fCfgSis('ROMEDI', varBoolean) then
    pImprimirRomaneio(cdsConsulta.FieldByName('NUMROM').AsString)
  else if Assigned(prcExecutaRelatorio) then
    prcExecutaRelatorio(13, 1361, [1361, 1371],
                        ['NUMROM', 'EMPROM'],
                        [cdsConsulta.FieldByName('NUMROM').AsString, VS_strCodEmp],
                        Sender);

  pnlInfo.Caption := '';    
end;

procedure TfrmFatLiberacaoRomaneio.pRealizaLiberacoes;
  Var
    intIndex: Integer;
begin

  Try
    Screen.Cursor := crHourGlass;

    With cdsConsulta Do
    Begin
      For intIndex := 0 To stlListSelecao.Count - 1 Do
      Begin
        If Locate('AUTOINCREM', stlListSelecao[intIndex], []) Then
        Begin
          pLiberarRomaneio(FieldByName('NUMROM').AsString, FieldByName('EMPROM').AsString);
        End;
        Application.ProcessMessages;
      End;
    End;

  Finally
    Screen.Cursor := crDefault;
  End;

end;

procedure TfrmFatLiberacaoRomaneio.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6 : btnImpRom.Click;
    VK_F7 : btnMarca.Click;
    VK_F8 : btnDesmarca.Click;
    VK_F9 : btnCancLiber.Click;
    VK_F10: Begin
              Key := 0;
              btnGravar.Click;
            End;
  End;
  
end;

end.
