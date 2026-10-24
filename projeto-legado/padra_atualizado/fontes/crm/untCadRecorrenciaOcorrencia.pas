unit untCadRecorrenciaOcorrencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.CheckLst, untTRecorrenciaOcorrencia,
  EditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Mask, MaskEditFocus,
  untPaiConfirma;

type
  TfrmCadRecorrenciaOcorrencia = class(TfrmPaiConfirma)
    pnlPrincipal: TPanel;
    pnlIntervalo: TPanel;
    pnlRecorrenciaFreq: TPanel;
    pnlRecorrencia: TPanel;
    lblRecorrencia: TLabel;
    CheckListTipoRecorrencia: TCheckListBox;
    pnlFrequencia: TPanel;
    lblFrequencia: TLabel;
    CheckListFrequencia: TCheckListBox;
    lblDias1: TLabel;
    edtQtdFre: TEditFocus;
    lblDias2: TLabel;
    pnlIntervaloRecorrencia: TPanel;
    pnlTipoIntervaloRecorrencia: TPanel;
    CheckListIntervaloOcorrencia: TCheckListBox;
    lblIntervalo: TLabel;
    lblQtdOcorrencias: TLabel;
    mskDtaTer: TMaskEditFocus;
    edtNroOcoTer: TEditFocus;
    pnlCabecalho: TPanel;
    pnlUltPro: TPanel;
    lblDataUltPro: TLabel;
    mskDtaUltPro: TMaskEditFocus;
    mskhraUltPro: TMaskEditFocus;
    pnlDataInicial: TPanel;
    lblDtaInicial: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskHraIni: TMaskEditFocus;
    pnlOpcoes: TPanel;
    chkGerarTodasOcorrencias: TCheckBox;
    procedure CheckListTipoRecorrenciaClick(Sender: TObject);
    procedure CheckListFrequenciaClick(Sender: TObject);
    procedure CheckListIntervaloOcorrenciaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtQtdFreExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    intTamCheckListFrequencia: Integer;

    procedure pAjustarCampos;
    procedure pCarregaTipoRecorrencia;
    procedure pCarregaFrequencia;
    procedure pCarregaFrequenciaDiaria;
    procedure pCarregaFrequenciaSemanal;
    procedure pCarregaFrequenciaMensal;
    procedure pCarregaFrequenciaAnual;
    procedure pCarregaIntervaloRecorrencia;
    procedure pSelecaoItemRecorrencia;
    procedure pSelecaoFrequencia;
    procedure pSelecaoIntervaloRecorrencia;
    procedure pInformarFrequencia;
    procedure pCarregarProRec;

    function fValidaCampoData(const strDataHora: String): Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
     ObjRecorrencia: TRecorrenciaOcorrencia;

     procedure pCarregarRecorrencia;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmRecorrenciaOcorrencia }

procedure TfrmCadRecorrenciaOcorrencia.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  fVerificaCampos;
  ObjRecorrencia.Status := IIF(chkGerarTodasOcorrencias.Checked, tpTodas, tpAberta);

end;

procedure TfrmCadRecorrenciaOcorrencia.btnSairClick(Sender: TObject);
begin
  inherited;

  ObjRecorrencia.pLimpar;
end;

procedure TfrmCadRecorrenciaOcorrencia.CheckListFrequenciaClick(Sender: TObject);
begin
  inherited;

  pSelecaoFrequencia;
end;

procedure TfrmCadRecorrenciaOcorrencia.CheckListIntervaloOcorrenciaClick(
  Sender: TObject);
begin
  inherited;

  pSelecaoIntervaloRecorrencia;
end;

procedure TfrmCadRecorrenciaOcorrencia.CheckListTipoRecorrenciaClick(
  Sender: TObject);
begin
  inherited;

  ObjRecorrencia.Frequencia.Clear;
  pSelecaoItemRecorrencia;
end;

procedure TfrmCadRecorrenciaOcorrencia.edtQtdFreExit(Sender: TObject);
begin
  inherited;

  If ObjRecorrencia.TipoRecorrencia <> tpSemanal Then
    pInformarFrequencia;
end;

procedure TfrmCadRecorrenciaOcorrencia.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  If ModalResult <> mrOk Then
    Exit;

  If Not objRecorrencia.fValidarRecorrenciaPreenchida Then
  Begin
    fMensagem('Atenção', objRecorrencia.MensagemRetorno, ['&OK']);
    CanClose := False;
  End;
end;

procedure TfrmCadRecorrenciaOcorrencia.FormShow(Sender: TObject);
begin
  inherited;

  pAjustarCampos;

  If Not Assigned(ObjRecorrencia) Then
    fMensagem('ATENÇÃO!', 'Não foi informada Ocorrência para gerar Recorrência.', ['&Ok'])
  Else
    pCarregarRecorrencia;
end;

function TfrmCadRecorrenciaOcorrencia.fValidaCampoData(
  const strDataHora: String): Boolean;
var
  dataHora: TDateTime;
begin
  Try
    dataHora := StrToDateTime(strDataHora);
    Result := dataHora > 0;
  Except
    Result := False;
  End;
end;

function TfrmCadRecorrenciaOcorrencia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = mskDtaTer) Then
    Begin
      If Not fEmptyDate(mskDtaTer.Text) Then
        ObjRecorrencia.DataParaTermino := StrToDateTime(mskDtaTer.Text);
    End
    Else
    If (Sender = edtNroOcoTer) Then
    Begin
      If (StrToIntDef(edtNroOcoTer.Text, 0) > fCfgSis('QTOREC', varInteger)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade de recorrência por cliente é superior à máxima estabelecida na configuração ' +
                              '"CFG_QTOREC - Quantidade limite de recorrência de ocorrência por cliente". ' +
                              'É necessário rever as opções desta recorrência ou ajustar a quantidade máxima da configuração e refazer o processo.', ['&Ok']);
        Result := False;
      End
      Else
        ObjRecorrencia.NumeroOcorrenciaParaTermino := StrToIntDef(edtNroOcoTer.Text, 0);
    End
    Else If (Sender = edtQtdFre) Then
    Begin
      If ObjRecorrencia.TipoRecorrencia <> tpSemanal Then
        pInformarFrequencia;
    End
    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyDate(mskDtaIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Campo "Data inicial para geração de ocorrências" é obrigatório!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If fValidaCampoData(mskDtaIni.Text) Then
          ObjRecorrencia.DataInicial := StrToDateTime(mskDtaIni.Text);
      End;
    End
    Else If (Sender = mskHraIni) Then
    Begin
      If fEmptyDate(mskHraIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Campo "Hora inicial para geração de ocorrências" é obrigatório', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If fValidaCampoData(mskHraIni.Text) Then
          ObjRecorrencia.HoraInicial := StrToDateTime(mskHraIni.Text);
      End;
    End
    Else If (Sender = chkGerarTodasOcorrencias) Then
    Begin
      If chkGerarTodasOcorrencias.Checked And (ObjRecorrencia.IntervaloRecorrencia = tpSemData) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para gerar todas as ocorrências período para término precisa ser informado.', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        ObjRecorrencia.Status := IIF(chkGerarTodasOcorrencias.Checked, tpTodas, tpAberta);
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadRecorrenciaOcorrencia.pAjustarCampos;
begin
  CheckListTipoRecorrencia.Clear;
  CheckListIntervaloOcorrencia.Clear;
  CheckListFrequencia.Visible := True;
  lblDias1.Visible := False;
  edtQtdFre.Visible := False;
  lblDias2.Visible := False;

  intTamCheckListFrequencia := CheckListFrequencia.Height;

  pCarregaTipoRecorrencia;
  pCarregaIntervaloRecorrencia;

  If Assigned(ObjRecorrencia) Then
  Begin
    mskDtaIni.Text := DateTimeToStr(ObjRecorrencia.DataInicial);
    mskHraIni.Text := FormatDateTime('hh:mm', ObjRecorrencia.HoraInicial);
  End;

  mskDtaUltPro.Enabled := False;
  mskHraUltPro.Enabled := False;
end;

procedure TfrmCadRecorrenciaOcorrencia.pCarregaFrequencia;
begin
  CheckListFrequencia.Clear;
  CheckListFrequencia.Visible := True;
  lblDias1.Visible := False;
  lblDias2.Visible := False;
  edtQtdFre.Visible := False;

  edtQtdFre.Clear;
  edtQtdFre.Enabled := True;

  Case CheckListTipoRecorrencia.ItemIndex Of
    Integer(tpDiaria) : pCarregaFrequenciaDiaria;
    Integer(tpSemanal): pCarregaFrequenciaSemanal;
    Integer(tpMensal) : pCarregaFrequenciaMensal;
    Integer(tpAnual)  : pCarregaFrequenciaAnual;
  End;
end;

procedure TfrmCadRecorrenciaOcorrencia.pCarregaFrequenciaAnual;
var
  Frequencia: TTipoFrequenciaAnual;
begin
  For Frequencia := Low(arrFrequenciaAnual) to High(arrFrequenciaAnual) Do
  Begin
    CheckListFrequencia.Items.Add(arrFrequenciaAnual[Frequencia]);
  End;

  lblDias1.Visible := True;
  lblDias2.Visible := True;
  edtQtdFre.Visible := True;

  lblDias1.Caption := 'A cada ';
  lblDias2.Caption := '(anos) ';
  CheckListFrequencia.Visible := False;
end;

procedure TfrmCadRecorrenciaOcorrencia.pCarregaFrequenciaDiaria;
var
  Frequencia: TTipoFrequenciaDiaria;
begin
  For Frequencia := Low(arrTipoFrequenciaDiaria) to High(arrTipoFrequenciaDiaria) Do
  Begin
    If Frequencia <> tpCadaNDias Then
      CheckListFrequencia.Items.Add(arrTipoFrequenciaDiaria[Frequencia]);
  End;

  lblDias1.Visible := True;
  lblDias2.Visible := True;
  edtQtdFre.Visible := True;

  lblDias1.Caption := 'A cada ';
  lblDias2.Caption := 'Dia(s) ';

  CheckListFrequencia.Visible := True;
  CheckListFrequencia.Height := intTamCheckListFrequencia - (edtQtdFre.Height + 10);
  CheckListFrequencia.Top := edtQtdFre.Top + 30;
end;

procedure TfrmCadRecorrenciaOcorrencia.pCarregaFrequenciaMensal;
var
  Frequencia: TTipoFrequenciaMensal;
begin
  For Frequencia := Low(arrFrequenciaMensal) to High(arrFrequenciaMensal) Do
  Begin
    CheckListFrequencia.Items.Add(arrFrequenciaMensal[Frequencia]);
  End;

  lblDias1.Visible := True;
  lblDias2.Visible := False;
  edtQtdFre.Visible := True;

  lblDias1.Caption := 'No dia ';
  CheckListFrequencia.Visible := False;
end;

procedure TfrmCadRecorrenciaOcorrencia.pCarregaFrequenciaSemanal;
var
  Frequencia: TTipoFrequenciaSemanal;
begin
  For Frequencia := Low(arrTipoFrequenciaSemanal) to High(arrTipoFrequenciaSemanal) Do
  Begin
    CheckListFrequencia.Items.Add(arrTipoFrequenciaSemanal[Frequencia]);
  End;

  CheckListFrequencia.Visible := True;
  CheckListFrequencia.Height := CheckListTipoRecorrencia.Height;
  CheckListFrequencia.Top := CheckListTipoRecorrencia.Top;
end;

procedure TfrmCadRecorrenciaOcorrencia.pCarregaIntervaloRecorrencia;
var
  IntervaloFrequencia: TTipoIntervaloRecorrencia;
begin
  For IntervaloFrequencia := Low(arrTipoIntervaloRecorrencia) to High(arrTipoIntervaloRecorrencia) Do
  Begin
    If IntervaloFrequencia <> tpNenhum Then
      CheckListIntervaloOcorrencia.Items.Add(arrTipoIntervaloRecorrencia[IntervaloFrequencia]);
  End;
end;

procedure TfrmCadRecorrenciaOcorrencia.pCarregarProRec;
var
  objProRec: TProcessarRecorrencia;
begin
  objProRec := TProcessarRecorrencia.Create;
  Try
    objProRec.pCarregarDataUltimoProcessamento(ObjRecorrencia.AutInc);
    If objProRec.DataUltimoProcessamento > 0 Then
    Begin
      pnlUltPro.Visible := True;
      mskDtaUltPro.Text := DateTimeToStr(objProRec.DataUltimoProcessamento);
      mskHraUltPro.Text := FormatDateTime('hh:mm', objProRec.HoraUltimoProcessamento);

      mskDtaIni.Enabled := False;
      mskHraIni.Enabled := False;
    End
    Else
    Begin
      pnlUltPro.Visible := False;
      pnlCabecalho.Height := pnlCabecalho.Height - pnlUltPro.Height;
    End;
  Finally
    FreeAndNil(objProRec);
  end;
end;

procedure TfrmCadRecorrenciaOcorrencia.pCarregarRecorrencia;
var
  intCnt: Integer;
begin
  If Integer(ObjRecorrencia.TipoRecorrencia) >= 0 Then
  Begin
    CheckListTipoRecorrencia.ItemIndex := Integer(ObjRecorrencia.TipoRecorrencia);
    CheckListTipoRecorrencia.Checked[CheckListTipoRecorrencia.ItemIndex]:= True;
    pSelecaoItemRecorrencia;
  End;

  ObjRecorrencia.pCarregarFrequencia;
  If ObjRecorrencia.Frequencia.Count >= 0 Then
  Begin
    For intCnt:= 0 To ObjRecorrencia.Frequencia.Count-1 Do
    Begin
      CheckListFrequencia.ItemIndex := ObjRecorrencia.Frequencia[intCnt].IndiceFrequencia;

      Case ObjRecorrencia.TipoRecorrencia Of
        tpDiaria:  CheckListFrequencia.Checked[ObjRecorrencia.Frequencia[intCnt].IndiceFrequencia]:= ObjRecorrencia.Frequencia[intCnt].blnTodosDias;
        tpSemanal: Begin
                     CheckListFrequencia.Checked[Integer(ObjRecorrencia.Frequencia[intCnt].DiaSemana)]:= True;
                   End;
      End;

      edtQtdFre.Text := IntToStr(ObjRecorrencia.Frequencia[intCnt].Frequencia);
    End;
  End;

  If Integer(ObjRecorrencia.IntervaloRecorrencia) >= 0 Then
  Begin
    CheckListIntervaloOcorrencia.ItemIndex := Integer(ObjRecorrencia.IntervaloRecorrencia);
    CheckListIntervaloOcorrencia.Checked[CheckListIntervaloOcorrencia.ItemIndex]:= True;
    If ObjRecorrencia.DataParaTermino > 0 Then
      mskDtaTer.Text := DateTimeToStr(ObjRecorrencia.DataParaTermino);
    edtNroOcoTer.Text := IntToStr(ObjRecorrencia.NumeroOcorrenciaParaTermino);

    Case CheckListIntervaloOcorrencia.ItemIndex Of
      Integer(tpData):    Begin
                            mskDtaTer.Enabled := True;
                            edtNroOcoTer.Enabled := False;
                          End;
      Integer(tpApos):    Begin
                            mskDtaTer.Enabled := False;
                            edtNroOcoTer.Enabled := True;
                          End;
      Integer(tpSemData): Begin
                            mskDtaTer.Enabled := False;
                            edtNroOcoTer.Enabled := False;
                          End;
    End;

  End;

  pCarregarProRec;
end;

procedure TfrmCadRecorrenciaOcorrencia.pCarregaTipoRecorrencia;
var
  TipoOcorrencia: TTipoRecorrencia;
begin
  For TipoOcorrencia := Low(arrTipoRecorrencia) to High(arrTipoRecorrencia) Do
  Begin
    If TipoOcorrencia <> tpNone Then
      CheckListTipoRecorrencia.Items.Add(arrTipoRecorrencia[TipoOcorrencia]);
  End;
end;

procedure TfrmCadRecorrenciaOcorrencia.pInformarFrequencia;
var
  ObjFrequencia: TFrequenciaRecorrencia;
begin
  CheckListFrequencia.ItemIndex := IIF(CheckListFrequencia.ItemIndex < 0, 0, CheckListFrequencia.ItemIndex);

  edtQtdFre.Enabled := True;
  Case ObjRecorrencia.TipoRecorrencia Of
      tpDiaria:  Begin
                   ObjRecorrencia.Frequencia.Clear;
                   ObjFrequencia := ObjRecorrencia.fAddFrequencia;
                   ObjFrequencia.blnTodosDias := CheckListFrequencia.Checked[CheckListFrequencia.ItemIndex];
                   If ObjFrequencia.blnTodosDias Then
                   Begin
                     edtQtdFre.Clear;
                     edtQtdFre.Enabled := False;
                   End
                   Else
                     edtQtdFre.Enabled := True;
                   ObjFrequencia.IndiceFrequencia := CheckListFrequencia.ItemIndex;
                   ObjFrequencia.Frequencia := StrToIntDef(edtQtdFre.Text, 0);
                 End;

      tpSemanal: Begin
                   ObjFrequencia := ObjRecorrencia.fAddFrequencia;
                   ObjFrequencia.IndiceFrequencia := CheckListFrequencia.ItemIndex;
                 End;

      tpMensal,
      tpAnual :  Begin
                   ObjRecorrencia.Frequencia.Clear;
                   ObjFrequencia := ObjRecorrencia.fAddFrequencia;
                   ObjFrequencia.IndiceFrequencia := CheckListFrequencia.ItemIndex;
                   ObjFrequencia.Frequencia := StrToIntDef(edtQtdFre.Text, 0);
                 End;

  End;
end;

procedure TfrmCadRecorrenciaOcorrencia.pSelecaoFrequencia;
begin
  If CheckListFrequencia.Checked[CheckListFrequencia.ItemIndex] Then
  Begin
    pInformarFrequencia;
  End
  Else
  Begin
    If ObjRecorrencia.TipoRecorrencia = tpSemanal Then
    Begin
      ObjRecorrencia.fRemFrequencia(CheckListFrequencia.ItemIndex);
    End
    Else
    Begin
      ObjRecorrencia.Frequencia.Clear;
      edtQtdFre.Clear;
      edtQtdFre.Enabled := True;
    End;
  End;
end;

procedure TfrmCadRecorrenciaOcorrencia.pSelecaoIntervaloRecorrencia;
var
  intCnt: Integer;
begin
  mskDtaTer.Enabled := False;
  edtNroOcoTer.Enabled := False;
  If CheckListIntervaloOcorrencia.Checked[CheckListIntervaloOcorrencia.ItemIndex] Then
  Begin
    CheckListIntervaloOcorrencia.Items.BeginUpdate;
    For intCnt := 0 to CheckListIntervaloOcorrencia.Items.Count -1 Do
    Begin
      If intCnt <> CheckListIntervaloOcorrencia.ItemIndex Then
        CheckListIntervaloOcorrencia.Checked[intCnt] := False;
    End;
    CheckListIntervaloOcorrencia.Items.EndUpdate;

    ObjRecorrencia.IntervaloRecorrencia := TTipoIntervaloRecorrencia(CheckListIntervaloOcorrencia.ItemIndex);

    Case CheckListIntervaloOcorrencia.ItemIndex Of
      Integer(tpData):    Begin
                            ObjRecorrencia.DataParaTermino := 0;
                            ObjRecorrencia.NumeroOcorrenciaParaTermino := 0;
                            edtNroOcoTer.Clear;
                            mskDtaTer.Clear;
                            mskDtaTer.Enabled := True;
                            edtNroOcoTer.Enabled := False;
                          End;
      Integer(tpApos):    Begin
                            ObjRecorrencia.DataParaTermino := 0;
                            ObjRecorrencia.NumeroOcorrenciaParaTermino := 0;
                            edtNroOcoTer.Clear;
                            mskDtaTer.Clear;
                            mskDtaTer.Enabled := False;
                            edtNroOcoTer.Enabled := True;
                          End;
      Integer(tpSemData): Begin
                            ObjRecorrencia.DataParaTermino := 0;
                            ObjRecorrencia.NumeroOcorrenciaParaTermino := 0;
                            edtNroOcoTer.Clear;
                            mskDtaTer.Clear;
                            mskDtaTer.Enabled := False;
                            edtNroOcoTer.Enabled := False;
                          End;
    End;

  End
  Else
    ObjRecorrencia.IntervaloRecorrencia := tpNenhum;
end;

procedure TfrmCadRecorrenciaOcorrencia.pSelecaoItemRecorrencia;
var
  intCnt: Integer;
begin
  If CheckListTipoRecorrencia.Checked[CheckListTipoRecorrencia.ItemIndex] Then
  Begin
    CheckListTipoRecorrencia.Items.BeginUpdate;
    For intCnt := 0 to CheckListTipoRecorrencia.Items.Count -1 Do
    Begin
      If intCnt <> CheckListTipoRecorrencia.ItemIndex Then
        CheckListTipoRecorrencia.Checked[intCnt] := False;
    End;
    CheckListTipoRecorrencia.Items.EndUpdate;

    ObjRecorrencia.TipoRecorrencia := TTipoRecorrencia(CheckListTipoRecorrencia.ItemIndex);
  End
  Else
    ObjRecorrencia.TipoRecorrencia := tpNone;

  pCarregaFrequencia;
  ObjRecorrencia.Frequencia.Clear;
end;

end.
