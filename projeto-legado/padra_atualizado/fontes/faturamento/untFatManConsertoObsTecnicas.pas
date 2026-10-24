unit untFatManConsertoObsTecnicas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Menus, Buttons, ExtCtrls, AppEvnts, MemoFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, untConsertoEquipamento, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Uni, untFuncoesSimples, Vcl.ComCtrls,
  cxRichEdit, StrUtils, untConstantes, cxMemo, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTypesSistema;

type
  TfrmFatManConsertoObsTecnicas = class(TfrmPai)
    pnlFundo          : TPanel;
    dtsMsg            : TDataSource;
    pnlFundoMsg       : TPanel;
    btnAddMsg         : TBitBtnLocked;
    cxgConsulta       : TcxGrid;
    cxgConsultaTable  : TcxGridDBTableView;
    cxgConsultaObs    : TcxGridDBColumn;
    cxgConsultaData   : TcxGridDBColumn;
    cxgConsultaHora   : TcxGridDBColumn;
    cxgConsultaLevel1 : TcxGridLevel;
    cxStyleRepositorio: TcxStyleRepository;
    cxStyleGroup      : TcxStyle;
    cxStyleHora       : TcxStyle;
    memMsg            : TMemoFocus;
    cxStyleSelecao    : TcxStyle;
    pnlButtons        : TPanel;
    btnFechar         : TBitBtnLocked;
    btnIniMan         : TBitBtnLocked;
    btnIniOrc         : TBitBtnLocked;
    btnFinOrc         : TBitBtnLocked;
    btnFinMan         : TBitBtnLocked;
    lblIniOrc         : TLabel;
    lblFinOrc         : TLabel;
    lblIniMan         : TLabel;
    lblFinMan         : TLabel;
    lblPauOrc: TLabel;
    btnPauOrc: TBitBtnLocked;
    btnRetOrc: TBitBtnLocked;
    lblRetOrc: TLabel;
    btnManOrc: TBitBtnLocked;
    btnRetMan: TBitBtnLocked;
    lblRetMan: TLabel;
    lblPauMan: TLabel;
    btnHist: TBitBtnLocked;
    procedure memMsgEnter(Sender: TObject);
    procedure memMsgExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddMsgClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure memMsgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnIniOrcClick(Sender: TObject);
    procedure btnFinOrcClick(Sender: TObject);
    procedure btnIniManClick(Sender: TObject);
    procedure btnFinManClick(Sender: TObject);
    procedure btnPauOrcClick(Sender: TObject);
    procedure btnRetOrcClick(Sender: TObject);
    procedure btnManOrcClick(Sender: TObject);
    procedure btnRetManClick(Sender: TObject);
    procedure btnHistClick(Sender: TObject);
  private
    { Private declarations }
    qryObs   : TUniQuery;
    cdsObs   : TUniClientDataSet;
    objConEqu: TConEqu;

    procedure pCarregaObs;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pGetTextObs(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pAtualizaIniFin(ATipo: Integer);
    procedure pAtualizaBotoes;
    procedure pAdicionarObservacao(strMensagem: String);
    function fRetornaMensagem(intTipo: Integer): String;
    function fCriaClient: TUniClientDataSet;
  public
    { Public declarations }
    strSeqGer: String;
    blnConfOrc :Boolean;
    blnConfMan :Boolean;

    blnTemProdServ :Boolean;

    blnIniOrc :Boolean;
    blnFinOrc :Boolean;
    blnIniMan :Boolean;
    blnFinMan :Boolean;

    strStatus :String;
    objConEquOS: TConEqu;

    blnFluxoProcesso: Boolean;
    tpProcessoFlx   : TTipoProcessosFlxConEqu;
  end;

var
  frmFatManConsertoObsTecnicas: TfrmFatManConsertoObsTecnicas;

implementation

uses
  untFatManConsertoHistPausarRetornar;

{$R *.dfm}

procedure TfrmFatManConsertoObsTecnicas.btnAddMsgClick(Sender: TObject);
begin
  inherited;

  pAdicionarObservacao(memMsg.Texto);
end;

procedure TfrmFatManConsertoObsTecnicas.btnFinManClick(Sender: TObject);
begin
  inherited;

  If blnConfMan Then
  Begin
    //Final Orçamento
    pAtualizaIniFin(4);
  End
  Else
  Begin
    pMensagemOk('Não é permitido finalizar a manutenção por'
                +#13 +'pendências na Manutenção da Ordem de Serviço.'
                +#13 +'Verifique as informações e tente novamente.');
    blnFinMan := False;
  End;
end;

procedure TfrmFatManConsertoObsTecnicas.btnFinOrcClick(Sender: TObject);
begin
  inherited;

  If blnConfOrc Then
  Begin
    //Final Orçamento
    pAtualizaIniFin(2);
  End
  Else
  Begin
    pMensagemOk('Não é permitido finalizar o orçamento por'
                +#13 +'pendências na Manutenção da Ordem de Serviço.'
                +#13 +'Verifique as informações e tente novamente.');
    blnFinOrc := False;
  End;
end;

procedure TfrmFatManConsertoObsTecnicas.btnHistClick(Sender: TObject);
var
  LHistPausarRet: TfrmFatManConsertoHistPausarRetornar;
begin
  inherited;

  pCriarFormularios(TfrmFatManConsertoHistPausarRetornar, LHistPausarRet);
  try
    LHistPausarRet.strSeqEqu := strSeqGer;
    LHistPausarRet.ShowModal;
  finally
    pFreeAndNil(LHistPausarRet);
  end;
end;

procedure TfrmFatManConsertoObsTecnicas.btnIniManClick(Sender: TObject);
begin
  inherited;

  //Início Manutenção
  pAtualizaIniFin(3);
end;

procedure TfrmFatManConsertoObsTecnicas.btnIniOrcClick(Sender: TObject);
begin
  inherited;

  //Início Orçamento
  pAtualizaIniFin(1);
end;

procedure TfrmFatManConsertoObsTecnicas.btnManOrcClick(Sender: TObject);
begin
  inherited;
  If blnConfMan Then
  Begin
    //Final Orçamento
    pAtualizaIniFin(7);
  End
  Else
  Begin
    pMensagemOk('Não é permitido finalizar a manutenção por'
                +#13 +'pendências na Manutenção da Ordem de Serviço.'
                +#13 +'Verifique as informações e tente novamente.');
    blnFinMan := False;
  End;
end;

procedure TfrmFatManConsertoObsTecnicas.btnPauOrcClick(Sender: TObject);
begin
  inherited;
  If blnConfOrc Then
  Begin
    //Final Orçamento
    pAtualizaIniFin(5);
  End
  Else
  Begin
    pMensagemOk('Não é permitido finalizar o orçamento por'
                +#13 +'pendências na Manutenção da Ordem de Serviço.'
                +#13 +'Verifique as informações e tente novamente.');
    blnFinOrc := False;
  End;
end;

procedure TfrmFatManConsertoObsTecnicas.btnRetManClick(Sender: TObject);
begin
  inherited;
  If blnConfMan Then
  Begin
    //Final Orçamento
    pAtualizaIniFin(8);
  End
  Else
  Begin
    pMensagemOk('Não é permitido finalizar a manutenção por'
                +#13 +'pendências na Manutenção da Ordem de Serviço.'
                +#13 +'Verifique as informações e tente novamente.');
    blnFinMan := False;
  End;
end;

procedure TfrmFatManConsertoObsTecnicas.btnRetOrcClick(Sender: TObject);
begin
  inherited;
  If blnConfOrc Then
  Begin
    //Final Orçamento
    pAtualizaIniFin(6);
  End
  Else
  Begin
    pMensagemOk('Não é permitido finalizar o orçamento por'
                +#13 +'pendências na Manutenção da Ordem de Serviço.'
                +#13 +'Verifique as informações e tente novamente.');
    blnFinOrc := False;
  End;
end;

function TfrmFatManConsertoObsTecnicas.fCriaClient: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Self);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EQU_HORACU';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EQU_OBSERV';
    DataType := ftMemo;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EQU_HORENT';
    DataType := ftTime;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EQU_DTAENT';
    DataType := ftDatetime;
    Required := False;
  End;

  Result.IndexFieldNames := 'EQU_DTAENT;EQU_HORENT';
  Result.CreateDataSet;
end;

procedure TfrmFatManConsertoObsTecnicas.FormCreate(Sender: TObject);
begin
  inherited;
  objConEqu        := TConEqu.Create(Nil);
  qryObs           := fCriaQuery(Self);
  qryObs.AfterOpen := pAfterOpen;
  cdsObs           := fCriaClient;
  dtsMsg.DataSet   := cdsObs;

  blnIniOrc := False;
  blnFinOrc := False;
  blnIniMan := False;
  blnFinMan := False;
  blnTemProdServ := False;
  blnConfOrc := False;
  blnConfMan := False;
  blnFluxoProcesso := False;
end;

procedure TfrmFatManConsertoObsTecnicas.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(objConEqu) Then
  Begin
    FreeAndNil(objConEqu);
  End;
end;

procedure TfrmFatManConsertoObsTecnicas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_ESCAPE Then
    pEscapePressed;

  If (Shift = [ssAlt]) And (char(Key) = 'S') Then
    pEscapePressed;

  If (btnIniOrc.Enabled) And (Key = VK_F5) Then
    //Início Orçamento
    btnIniOrc.Click;

  If (btnPauOrc.Enabled) And (Key = VK_F6) Then
    //Pausa Orçamento
    btnPauOrc.Click;

  If (btnRetOrc.Enabled) And (Key = VK_F7) Then
    //Retorno Orçamento
    btnRetOrc.Click;

  If (btnFinOrc.Enabled) And (Key = VK_F8) Then
    //Finaliza Orçamento
    btnFinOrc.Click;

  If (btnIniMan.Enabled) And (Key = VK_F9) Then
    //Início Manutenção
    btnIniMan.Click;

  If (btnManOrc.Enabled) And (Key = VK_F10) Then
    //Pausa Manutenção
    btnManOrc.Click;

  If (btnRetMan.Enabled) And (Key = VK_F11) Then
    //Retorno Manutenção
    btnRetMan.Click;

  If (btnFinMan.Enabled) And (Key = VK_F12) Then
    //Finaliza Manutenção
    btnFinMan.Click;
end;

procedure TfrmFatManConsertoObsTecnicas.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaObs;
  cxgConsultaTable.ViewData.Collapse(True);
  objConEqu.strAutInc := strSeqGer;
  pAtualizaBotoes;
end;

function TfrmFatManConsertoObsTecnicas.fRetornaMensagem(intTipo: Integer): String;
begin
  case intTipo of
    1:
      begin
        Result := IIF(objConEqu.dtaIniOrc > 0, FormatDateTime('dd/mm/yyyy', objConEqu.dtaIniOrc) +
                      ' - ' + FormatDateTime('hh:mm', objConEqu.hraIniOrc) +
                      ' - ' + fRetNomeOperador(objConEqu.opeIniOrc), '');
      end;

    2:
      begin
        Result := IIF(objConEqu.dtaFinOrc > 0, FormatDateTime('dd/mm/yyyy', objConEqu.dtaFinOrc) +
                      ' - ' + FormatDateTime('hh:mm', objConEqu.hraFinOrc) +
                      ' - ' + fRetNomeOperador(objConEqu.opeFinOrc), '');
      end;

    3:
      begin
        Result := IIF(objConEqu.dtaIniMan > 0, FormatDateTime('dd/mm/yyyy', objConEqu.dtaIniMan) +
                      ' - ' + FormatDateTime('hh:mm', objConEqu.hraIniMan) +
                      ' - ' + fRetNomeOperador(objConEqu.opeIniMan), '');
      end;

    4:
      begin
        Result := IIF(objConEqu.dtaFinMan > 0, FormatDateTime('dd/mm/yyyy', objConEqu.dtaFinMan) +
                      ' - ' + FormatDateTime('hh:mm', objConEqu.hraFinMan) +
                      ' - ' + fRetNomeOperador(objConEqu.opeFinMan), '');
      end;

    5:
      begin
        Result := IIF(objConEqu.dtaRetOrc > 0, FormatDateTime('dd/mm/yyyy', objConEqu.dtaRetOrc) +
                      ' - ' + FormatDateTime('hh:mm', objConEqu.hraRetOrc) +
                      ' - ' + fRetNomeOperador(objConEqu.opePauOrc), '');
      end;

    6:
      begin
        Result := IIF(objConEqu.dtaRetMan > 0, FormatDateTime('dd/mm/yyyy', objConEqu.dtaRetMan) +
                      ' - ' + FormatDateTime('hh:mm', objConEqu.hraHorMan) +
                      ' - ' + fRetNomeOperador(objConEqu.opeRetOrc), '');
      end;

    7:
      begin
        Result := IIF(objConEqu.dtaPauMan > 0, FormatDateTime('dd/mm/yyyy', objConEqu.dtaPauMan) +
                      ' - ' + FormatDateTime('hh:mm', objConEqu.hraPauMan) +
                      ' - ' + fRetNomeOperador(objConEqu.opePauOrc), '');
      end;

    8:
      begin
        Result := IIF(objConEqu.dtaReManu > 0, FormatDateTime('dd/mm/yyyy', objConEqu.dtaReManu) +
                      ' - ' + FormatDateTime('hh:mm', objConEqu.hraHoManu) +
                      ' - ' + fRetNomeOperador(objConEqu.opeRetOrc), '');
      end;
  end;
end;

procedure TfrmFatManConsertoObsTecnicas.memMsgEnter(Sender: TObject);
begin
  inherited;
  memMsg.Color      := clInfoBk;
  pnlFundoMsg.Color := memMsg.Color;
end;

procedure TfrmFatManConsertoObsTecnicas.memMsgExit(Sender: TObject);
begin
  inherited;
  memMsg.Color      := clWhite;
  pnlFundoMsg.Color := memMsg.Color;
end;

procedure TfrmFatManConsertoObsTecnicas.memMsgKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_F2 Then
    btnAddMsg.Click;
end;

procedure TfrmFatManConsertoObsTecnicas.pAdicionarObservacao(strMensagem: String);
var
  LConfirma: Boolean;
begin
  LConfirma := objConEqu.fAdicionarObservacao(strMensagem);

  if (LConfirma) then
  begin
    pCarregaObs;
    memMsg.Clear;
    pSetFocus(memMsg);
  end;
end;

procedure TfrmFatManConsertoObsTecnicas.pAfterOpen(DataSet: TDataSet);
begin
  TMemoField(Dataset.FieldByName('EQU_OBSERV')).OnGetText := pGetTextObs;
end;

procedure TfrmFatManConsertoObsTecnicas.pAtualizaBotoes;
var
  LTemIniOrc,
  LTemFinOrc,
  LTemIniMan,
  LTemFinMan: Boolean;
  LSituacao : String;
begin
  if (blnFluxoProcesso and (tpProcessoFlx = tprDadosOS)) then
    Exit;

  objConEqu.pVerificaOperacoes(LTemIniOrc, LTemFinOrc, LTemIniMan, LTemFinMan);

  LSituacao := objConEqu.FSituacao;

  btnPauOrc.Enabled := False;
  btnRetOrc.Enabled := False;
  btnFinOrc.Enabled := False;
  btnIniMan.Enabled := False;
  btnManOrc.Enabled := False;
  btnRetMan.Enabled := False;
  btnFinMan.Enabled := False;

  If fCfgSis('CALTOS') = 'S' Then
  Begin
    btnIniOrc.Enabled := (Not LTemIniOrc) And (Not LTemFinOrc);
    btnFinOrc.Enabled := (LTemIniOrc) And (Not LTemFinOrc) And (blnTemProdServ);
    btnIniMan.Enabled := (LTemFinOrc) And (Not LTemIniMan) And (strStatus = 'M');
    btnFinMan.Enabled := (LTemIniMan) And (Not LTemFinMan) And (strStatus = 'M');
  End
  Else
  Begin
    btnIniOrc.Enabled := Not LTemIniOrc;
    btnFinOrc.Enabled := LTemIniOrc And Not LTemFinOrc;
    btnIniMan.Enabled := LTemFinOrc And Not LTemIniMan;
    btnFinMan.Enabled := LTemIniMan And Not LTemFinMan;
  End;

  If LTemIniOrc Then
    lblIniOrc.Caption := fRetornaMensagem(1);

  If LTemFinOrc Then
  Begin
    blnConfOrc := blnConfOrc And LTemFinOrc;
    lblFinOrc.Caption := fRetornaMensagem(2);
  End;

  If LTemFinMan Then
  Begin
    lblFinMan.Caption := fRetornaMensagem(4);
    blnConfMan := blnConfMan And LTemFinMan;
  End;

  case AnsiIndexStr(LSituacao, ['', '1', '2', '3', '4', '5', '6', '7', '8']) of
    1: // Inicia Orçamento
      begin
        btnPauOrc.Enabled := True;

        lblFinOrc.Caption := '';
        lblPauOrc.Caption := '';
        lblRetOrc.Caption := '';

        lblIniMan.Caption := '';
        lblPauMan.Caption := '';
        lblRetMan.Caption := '';
        lblFinMan.Caption := '';
      end;
    5: // Pausa Orçamento
      begin
        btnRetOrc.Enabled := True;
        btnFinOrc.Enabled := False;
        lblPauOrc.Caption := fRetornaMensagem(5);
      end;
    6: // Retorna Orçamento
      begin
        btnPauOrc.Enabled := True;
        btnFinOrc.Enabled := True;

        lblRetOrc.Caption := fRetornaMensagem(6);
      end;
    2: // Finaliza Orçamento
      begin
        lblPauOrc.Caption := fRetornaMensagem(5);
        lblRetOrc.Caption := fRetornaMensagem(6);

        if (not btnFinOrc.Enabled) then
          btnIniMan.Enabled := True;
      end;
    3: // Inicia Manutenção
      begin
        btnManOrc.Enabled := True;

        lblPauMan.Caption := '';
        lblRetMan.Caption := '';
        lblFinMan.Caption := '';

        lblIniMan.Caption := fRetornaMensagem(3);
      end;
    7: // Pausa Manutenção
      begin
        btnRetMan.Enabled := True;
        btnFinMan.Enabled := False;
        lblPauMan.Caption := fRetornaMensagem(7);
      end;
    8: // Retorna Manutenção
      begin
        btnManOrc.Enabled := True;
        btnFinMan.Enabled := True;
        lblRetMan.Caption := fRetornaMensagem(8);
      end;
    4: // Finaliza manutenção
      begin
        if (not btnFinMan.enabled) then
        begin
          lblIniMan.Caption := fRetornaMensagem(3);
          lblPauOrc.Caption := fRetornaMensagem(5);
          lblRetOrc.Caption := fRetornaMensagem(6);
          lblPauMan.Caption := fRetornaMensagem(7);
          lblRetMan.Caption := fRetornaMensagem(8);
        end;
      end;
  end;

  if (LSituacao = '') then
  begin
    lblIniOrc.Caption := '';
    lblFinOrc.Caption := '';
    lblPauOrc.Caption := '';
    lblRetOrc.Caption := '';
    lblIniMan.Caption := '';
    lblPauMan.Caption := '';
    lblRetMan.Caption := '';
    lblFinMan.Caption := '';
  end;
end;

procedure TfrmFatManConsertoObsTecnicas.pAtualizaIniFin(ATipo: Integer);
var
  LTipo: String;
  LContinua: Boolean;
begin
  LContinua := ATipo in [5, 6, 7, 8];

  if (not LContinua) then
    LContinua := (fMensagem('', 'Essa operação não poderá ser desfeita. Deseja continuar?' , ['&Sim', '&Não'], 2) = 1);

  if (not LContinua) then
    Exit;

  LTipo := '';

  If (Assigned(objConEquOS)) Then
    objConEquOS.pAtualizaInicioFimOperacoes(ATipo)
  Else
    objConEqu.pAtualizaInicioFimOperacoes(ATipo);

  case ATipo of
    1:
    begin
      LTipo := 'Iniciar Orçamento';
      blnIniOrc := True;
    end;
    2:
    begin
      LTipo := 'Finalizar Orçamento';
      blnFinOrc := True;
    end;
    3:
    begin
      LTipo := 'Iniciar Manutenção';
      blnIniMan := True;
    end;
    4:
    begin
      LTipo := 'Finalizar Manutenção';
      blnFinMan := True;
    end;
    5: LTipo := 'Pausar Orçamento';
    6: LTipo := 'Retornar Orçamento';
    7: LTipo := 'Pausar Manutenção';
    8: LTipo := 'Retornar Manutenção';
  end;

  objConEqu.pInsereObsTecnicas(ATipo, LTipo);
  pAdicionarObservacao(LTipo + ' - ' + fRetNomeOperador(strLoginUsuarioLogado));
  pAtualizaBotoes;
end;

procedure TfrmFatManConsertoObsTecnicas.pCarregaObs;
begin
  Try
    cdsObs.EmptyDataSet;

    With qryObs Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT EQUOBS.*,                ');
      SQL.Add('        CONCAT("[",SUBSTR(EQU_HORENT,1,5),"]") AS HORA ');
      SQL.Add('   FROM EQUOBS                   ');
      SQL.Add('  WHERE EQU_SEQGER = :SEQGER     ');
      SQL.Add('    AND EQU_CODEMP = :CODEMP     ');
      SQL.Add(' ORDER BY EQU_DTAENT, EQU_HORENT ');

      ParamByName('SEQGER').AsString := strSeqGer;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      First;
      While not EOF Do
      Begin
        cdsObs.Insert;
        cdsObs.FieldByName('EQU_HORACU').AsString   := FieldByName('HORA').AsString;
        cdsObs.FieldByName('EQU_OBSERV').Text       := FieldByName('EQU_OBSERV').Text;
        cdsObs.FieldByName('EQU_DTAENT').AsDatetime := FieldByName('EQU_DTAENT').AsDatetime;
        cdsObs.FieldByName('EQU_DTAENT').AsDatetime := FieldByName('EQU_DTAENT').AsDatetime;
        cdsObs.Post;

        Next;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmFatManConsertoObsTecnicas.pCarregaObs]');
    End;
  End;
end;

procedure TfrmFatManConsertoObsTecnicas.pGetTextObs(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := AnsiReplaceStr(Sender.AsString, STRING_QUEBRA, STRING_ENTER);
end;

end.

