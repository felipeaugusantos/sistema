unit untFrmManipulaContasPagarPrevisaoNao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.CheckLst, Uni, untFuncoesSimples,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, MaskUtils, UniClientDataSet, untLogCtp,
  cxCurrencyEdit, untTCadPag, untTCadPagRepository, untCadPag;

type
  TFrmManipulaContasPagarPrevisaoNao = class(TfrmPaiConfirma)
    meInformativo: TMemo;
    rgOperacoes: TRadioGroup;
    cxgTitulosComPrevisaoSimDBTableView1: TcxGridDBTableView;
    cxgTitulosComPrevisaoSimLevel1: TcxGridLevel;
    cxgTitulosComPrevisaoSim: TcxGrid;
    dsTitulosComPrevisaoSim: TDataSource;
    cxgTitulosComPrevisaoSimCTP_NUMDUP: TcxGridDBColumn;
    cxgTitulosComPrevisaoSimCTP_CODEMP: TcxGridDBColumn;
    cxgTitulosComPrevisaoSimCTP_CODFOR: TcxGridDBColumn;
    cxgTitulosComPrevisaoSimCTP_CODPOR: TcxGridDBColumn;
    cxgTitulosComPrevisaoSimCTP_DTACAD: TcxGridDBColumn;
    cxgTitulosComPrevisaoSimCTP_DTAVEN: TcxGridDBColumn;
    cxgTitulosComPrevisaoSimCTP_VALDUP: TcxGridDBColumn;
    cxgTitulosComPrevisaoSimFOR_NOMFOR: TcxGridDBColumn;
    cxgTitulosComPrevisaoSimCTA_DESCTA: TcxGridDBColumn;
    cxgTitulosComPrevisaoSimCTP_NOMPOR: TcxGridDBColumn;
    cxgTitulosComPrevisaoSimAUTOINCREM: TcxGridDBColumn;
    cxgTitulosComPrevisaoSimMARDES: TcxGridDBColumn;
    btnConfirmar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure rgOperacoesClick(Sender: TObject);
    procedure cxgTitulosComPrevisaoSimDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cxgTitulosComPrevisaoSimDBTableView1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure cxgTitulosComPrevisaoSimDBTableView1DblClick(Sender: TObject);
  private
    { Private declarations }
    FstrAUTOINCREM : String;
    FstrDtaVen : String ;
    FstrCodFor : String ;
    FstrNomFor : String ;
    FstrCodCta : String ;
    FstrDesCta : String ;
    FstrValDup : String ;
    FstrValOri : String ;
    FcdsContasPagarComPrevisaoSim : TUniClientDataSet;
    FqryContasPagarComPrevisaoNao : TUniQuery ;
    FstrOperacao : String;
    procedure pCarregarMemoInformativo ;
    procedure pCarregarClbTitulosComPrevisaoSim ;
    procedure pAbaterValDupDaPrevisao ;
    procedure pExcluirPrevisao;
    procedure pGravaLogCtp(AstrAUTOINCREM, AstrDescricao: String);
    procedure pSelecionarRegistroParaAbater;
    procedure pSelecionarRegistroParaExcluir;
    procedure pLimpaCTPCom(AstrCTPCom: String);
    procedure pDeletaCtpDet(AstrNumDup, AstrParcel, AstrSerie, AstrCodEmp, AstrCodFor: String);
    function fVerificarRegistrosSelecionadosNoGrid:Boolean ;
    function fDeleteCADPAG(AstrAutoInc: String): Boolean;
  public
    { Public declarations }
    property AUTOINCREM : String read FstrAUTOINCREM write FstrAUTOINCREM;
    function fCarregarDadosCtaPagarComPrevisaoSim : Boolean ;
    procedure pCarregarDadosCtaPagarComPrevisaoNao ; overload ;
    procedure pCarregarDadosCtaPagarComPrevisaoNao(AstrNumDoc, AstrCodFor, AstrSerie: String; AdtaDtaDoc : TDateTime) ; overload ;
  end;

var
  frmManipulaContasPagarPrevisaoNao : TFrmManipulaContasPagarPrevisaoNao;

implementation

{$R *.dfm}

{ TFrmManipulaContasPagarPrevisaoNao }

procedure TFrmManipulaContasPagarPrevisaoNao.btnConfirmaClick(Sender: TObject);
begin
  //inherited;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.btnConfirmarClick(Sender: TObject);
var
  LintQtdMardesM : Integer;
begin
  inherited;
  Try
    case rgOperacoes.ItemIndex of
      0 : begin
        if fMensagem('AVISO!', 'Deseja realmente manter a previsão sem alterar nada?', ['&Sim', '&Não']) = 1 then
          close;
      end;

      1: begin
        LintQtdMardesM := 0;
        FcdsContasPagarComPrevisaoSim.DisableControls;
        FcdsContasPagarComPrevisaoSim.First;
        while not FcdsContasPagarComPrevisaoSim.Eof do
        begin
          if FcdsContasPagarComPrevisaoSim.FieldByName('MARDES').AsString = 'M' then
            inc(LintQtdMardesM);
          FcdsContasPagarComPrevisaoSim.Next;
        end;
        FcdsContasPagarComPrevisaoSim.EnableControls;

        if LintQtdMardesM = 0 then
        begin
          fMensagem('AVISO!', 'Nenhum registro selecionado para abater o valor!', ['&Ok']);
          exit
        end;

        if LintQtdMardesM = 1 then
        begin
          pAbaterValDupDaPrevisao;
          exit;
        end;

        if LintQtdMardesM > 1 then
        begin
          fMensagem('AVISO!', 'Selecione apenas um registro para abater o valor!', ['&Ok']);
          exit;
        end;
      end;

      2: pExcluirPrevisao;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.btnConfirmarClick]');
    End;
  End;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.cxgTitulosComPrevisaoSimDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  Try
    if AViewInfo.Selected then
      ACanvas.Font.Color := clWhite
    else
      ACanvas.Font.Color := clBlack;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgTitulosComPrevisaoSimMARDES.Index]) = 'M' Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlack;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.cxgTitulosComPrevisaoSimDBTableView1CustomDrawCell]');
    End;
  End;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.cxgTitulosComPrevisaoSimDBTableView1DblClick(
  Sender: TObject);
var
  LfltValorDupTotal : Double;
begin
  inherited;
  Try
    if FstrOperacao = 'EXCLUIR' then
    begin
      FcdsContasPagarComPrevisaoSim.Edit;
      pSelecionarRegistroParaExcluir;
      exit;
    end;

    if FstrOperacao = 'ABATER' then
    begin
      LfltValorDupTotal := StrToFloat(FstrValDup);
      if cxgTitulosComPrevisaoSimDBTableView1.Controller.FocusedRecord.Values[cxgTitulosComPrevisaoSimCTP_VALDUP.Index] <= LfltValorDupTotal then
      begin
        fMensagem('AVISO!', 'O valor da previsão selecionada deve ser maior que o valor da duplicata cadastrada', ['&Ok']);
        exit;
      end;
      pSelecionarRegistroParaAbater;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.cxgTitulosComPrevisaoSimDBTableView1DblClick]');
    End;
  End;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.cxgTitulosComPrevisaoSimDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Try
    If Key = VK_RETURN Then
    begin
      if FstrOperacao = 'EXCLUIR' then
      begin
        FcdsContasPagarComPrevisaoSim.Edit;
        pSelecionarRegistroParaExcluir;
        exit;
      end;

      if FstrOperacao = 'ABATER' then
        pSelecionarRegistroParaAbater;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.cxgTitulosComPrevisaoSimDBTableView1KeyDown]');
    End;
  End;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.FormCreate(Sender: TObject);
begin
  inherited;
  Try
    FqryContasPagarComPrevisaoNao := fCriaQuery ;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.FormCreate]');
    End;
  End;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.FormDestroy(Sender: TObject);
begin
  inherited;
  if assigned(FqryContasPagarComPrevisaoNao) then
    FreeAndNil(FqryContasPagarComPrevisaoNao) ;

  if assigned(FcdsContasPagarComPrevisaoSim) then
    FreeAndNil(FcdsContasPagarComPrevisaoSim) ;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarMemoInformativo ;
  pCarregarClbTitulosComPrevisaoSim ;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.rgOperacoesClick(Sender: TObject);
begin
  inherited;
  Try
    cxgTitulosComPrevisaoSimDBTableView1.OptionsSelection.MultiSelect := True;
    cxgTitulosComPrevisaoSim.Enabled := True;

    if assigned(FcdsContasPagarComPrevisaoSim) then
    begin
      FcdsContasPagarComPrevisaoSim.first;
      while ((not FcdsContasPagarComPrevisaoSim.Eof)) do
      begin
        FcdsContasPagarComPrevisaoSim.Edit;
        FcdsContasPagarComPrevisaoSim.FieldByName('MARDES').AsString := 'D';
        FcdsContasPagarComPrevisaoSim.Post;
        FcdsContasPagarComPrevisaoSim.Next;
      end;
      pCarregarClbTitulosComPrevisaoSim;
    end;

    case rgOperacoes.ItemIndex of
      0:begin
        cxgTitulosComPrevisaoSim.Enabled := False;
        FstrOperacao := 'MANTER';
      end;

      1: begin
        cxgTitulosComPrevisaoSimDBTableView1.OptionsSelection.MultiSelect := False;
        FstrOperacao := 'ABATER';
      end;

      2: FstrOperacao := 'EXCLUIR';
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.rgOperacoesClick]');
    End;
  End;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.pAbaterValDupDaPrevisao;
var
  LfltValorDupTotal : Double;
  LqryManipularRegistro : TUniQuery;
  LblnItensAlterados : Boolean;
begin
  LblnItensAlterados := False ;

  if fMensagem('AVISO!', 'Abater o valor desta duplicata, do valor da previsão?', ['&Sim', '&Não']) = 2 then
    exit;

  Try
    fStartTransaction;
    LfltValorDupTotal := StrToFloat(FstrValDup);
    try
      LqryManipularRegistro := fCriaQuery;
      FcdsContasPagarComPrevisaoSim.DisableControls;
      FcdsContasPagarComPrevisaoSim.First;
      while not FcdsContasPagarComPrevisaoSim.Eof do
      begin
        if FcdsContasPagarComPrevisaoSim.FieldByName('MARDES').AsString = 'M' then
        begin
          LqryManipularRegistro.SQL.Text := 'UPDATE CADPAG SET CTP_VALDUP = :NovoValDup, CTP_VALORI = :NovoValOri WHERE AUTOINCREM = :AUTOINCREM';
          LqryManipularRegistro.ParamByName('NovoValDup').AsFloat :=
            FcdsContasPagarComPrevisaoSim.FieldByName('CTP_VALDUP').AsFloat - LfltValorDupTotal;
          LqryManipularRegistro.ParamByName('NovoValOri').AsFloat :=
            FcdsContasPagarComPrevisaoSim.FieldByName('CTP_VALORI').AsFloat - LfltValorDupTotal;
          LqryManipularRegistro.ParamByName('AUTOINCREM').AsString := FcdsContasPagarComPrevisaoSim.FieldByName('AUTOINCREM').AsString;
          pGravaLogCtp(FcdsContasPagarComPrevisaoSim.FieldByName('AUTOINCREM').AsString ,'ABATIMENTO: ' + FcdsContasPagarComPrevisaoSim.FieldByName('AUTOINCREM').AsString);
          LqryManipularRegistro.ExecSQL;
          LblnItensAlterados := True;
          break;
        end;
        FcdsContasPagarComPrevisaoSim.Next;
      end;
    finally
      FcdsContasPagarComPrevisaoSim.EnableControls;
      FreeAndNil(LqryManipularRegistro);
    end;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      LblnItensAlterados := False;
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.pAbaterValDupDaPrevisao]');
    End;
  End;

  if LblnItensAlterados then
    fMensagem('AVISO!','Previsão abatida com sucesso.', ['&OK']);

  if fCarregarDadosCtaPagarComPrevisaoSim then
    pCarregarClbTitulosComPrevisaoSim
  else
    close;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.pCarregarClbTitulosComPrevisaoSim;
begin
  Try
    if Assigned(FcdsContasPagarComPrevisaoSim) then
    begin
      cxgTitulosComPrevisaoSimDBTableView1.DataController.DataSource := nil;
      dsTitulosComPrevisaoSim.DataSet := FcdsContasPagarComPrevisaoSim;
      cxgTitulosComPrevisaoSimDBTableView1.DataController.DataSource := dsTitulosComPrevisaoSim;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.pCarregarClbTitulosComPrevisaoSim]');
    End;
  End;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.pCarregarDadosCtaPagarComPrevisaoNao(
  AstrNumDoc, AstrCodFor, AstrSerie: String; AdtaDtaDoc: TDateTime);
var
  LstrSQL: String;
begin
  Try
    LstrSQL := '';
    LstrSQL := LstrSQL + 'SELECT ';
    LstrSQL := LstrSQL + '  CP.*, CC.CTA_DESCTA, CF.FOR_NOMFOR ';
    LstrSQL := LstrSQL + 'FROM CADPAG CP ';
    LstrSQL := LstrSQL + 'JOIN CADFOR CF ON CP.CTP_CODFOR = CF.FOR_CODFOR ';
    LstrSQL := LstrSQL + 'JOIN CADCTA CC ON CP.CTP_CODCTA = CC.CTA_CODCTA ';
    LstrSQL := LstrSQL + 'WHERE ';
    LstrSQL := LstrSQL + '  CP.CTP_NUMDUP = :NUMDUP AND ';
    LstrSQL := LstrSQL + '  CP.CTP_CODFOR = :CODFOR AND ';
    LstrSQL := LstrSQL + '  CP.CTP_SERIE_ = :SERIE AND ';
    LstrSQL := LstrSQL + '  CP.CTP_DTACAD = :DTACAD AND ';
    LstrSQL := LstrSQL + '  CP.CTP_PARCEL = :PARCELA ; ';

    FqryContasPagarComPrevisaoNao.Close;
    FqryContasPagarComPrevisaoNao.SQL.Text := LstrSQL;
    FqryContasPagarComPrevisaoNao.ParamByName('NUMDUP').AsString := AstrNumDoc ;
    FqryContasPagarComPrevisaoNao.ParamByName('CODFOR').AsString := AstrCodFor ;
    FqryContasPagarComPrevisaoNao.ParamByName('SERIE').AsString := AstrSerie ;
    FqryContasPagarComPrevisaoNao.ParamByName('DTACAD').AsString := FormatDateTime('yyyy-mm-dd', AdtaDtaDoc);
    FqryContasPagarComPrevisaoNao.ParamByName('PARCELA').AsString := 'A';
    FqryContasPagarComPrevisaoNao.Open;

    FstrCodFor := AstrCodFor ;
    FstrCodCta := '';

    if not FqryContasPagarComPrevisaoNao.IsEmpty then
    begin
      FstrDtaVen := FqryContasPagarComPrevisaoNao.FieldByName('CTP_DTAVEN').AsString ;
      FstrCodCta := FqryContasPagarComPrevisaoNao.FieldByName('CTP_CODCTA').AsString ;
      FstrValDup := FqryContasPagarComPrevisaoNao.FieldByName('CTP_VALDUP').AsString ;
      FstrValOri := FqryContasPagarComPrevisaoNao.FieldByName('CTP_VALORI').AsString ;
      FstrNomFor := FqryContasPagarComPrevisaoNao.FieldByName('FOR_NOMFOR').AsString ;
      FstrDesCta := FqryContasPagarComPrevisaoNao.FieldByName('CTA_DESCTA').AsString ;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.pCarregarDadosCtaPagarComPrevisaoNao]');
    End;
  End;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.pCarregarDadosCtaPagarComPrevisaoNao;
var
  LstrSQL: String;
begin
  Try
    LstrSQL := '';
    LstrSQL := LstrSQL + 'SELECT ';
    LstrSQL := LstrSQL + '  CP.*, CC.CTA_DESCTA, CF.FOR_NOMFOR ';
    LstrSQL := LstrSQL + 'FROM CADPAG CP ';
    LstrSQL := LstrSQL + 'JOIN CADFOR CF ON CP.CTP_CODFOR = CF.FOR_CODFOR ';
    LstrSQL := LstrSQL + 'JOIN CADCTA CC ON CP.CTP_CODCTA = CC.CTA_CODCTA ';
    LstrSQL := LstrSQL + 'WHERE ';
    LstrSQL := LstrSQL + '  CP.AUTOINCREM = :AUTOINCREM ;';

    FqryContasPagarComPrevisaoNao.Close;
    FqryContasPagarComPrevisaoNao.SQL.Text := LstrSQL;
    FqryContasPagarComPrevisaoNao.ParamByName('AUTOINCREM').AsString := FstrAUTOINCREM;
    FqryContasPagarComPrevisaoNao.Open;

    FstrDtaVen := FqryContasPagarComPrevisaoNao.FieldByName('CTP_DTAVEN').AsString ;
    FstrCodFor := FqryContasPagarComPrevisaoNao.FieldByName('CTP_CODFOR').AsString ;
    FstrCodCta := FqryContasPagarComPrevisaoNao.FieldByName('CTP_CODCTA').AsString ;
    FstrValDup := FqryContasPagarComPrevisaoNao.FieldByName('CTP_VALDUP').AsString ;
    FstrValOri := FqryContasPagarComPrevisaoNao.FieldByName('CTP_VALORI').AsString ;
    FstrNomFor := FqryContasPagarComPrevisaoNao.FieldByName('FOR_NOMFOR').AsString ;
    FstrDesCta := FqryContasPagarComPrevisaoNao.FieldByName('CTA_DESCTA').AsString ;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.pCarregarDadosCtaPagarComPrevisaoNao]');
    End;
  End;
end;

function TFrmManipulaContasPagarPrevisaoNao.fCarregarDadosCtaPagarComPrevisaoSim : Boolean;
var
  LstrSQL: String;
  LqryContasPagarComPrevisaoSim : TUniQuery;
begin
  Result := False;
  Try
    try
      LstrSQL := '';
      LstrSQL := LstrSQL + 'SELECT ';
      LstrSQL := LstrSQL + ' CAST("D" AS CHAR(1)) AS MARDES, ';
      LstrSQL := LstrSQL + ' CF.FOR_NOMFOR, ';
      LstrSQL := LstrSQL + ' CC.CTA_DESCTA, ';
      LstrSQL := LstrSQL + ' CR.POR_NOMPOR, ';
      LstrSQL := LstrSQL + ' CP.* ';
      LstrSQL := LstrSQL + 'FROM CADPAG CP ';
      LstrSQL := LstrSQL + 'JOIN CADFOR CF ON CP.CTP_CODFOR = CF.FOR_CODFOR ';
      LstrSQL := LstrSQL + 'JOIN CADCTA CC ON CP.CTP_CODCTA = CC.CTA_CODCTA ';
      LstrSQL := LstrSQL + 'JOIN CADPOR CR ON CP.CTP_CODPOR = CR.POR_CODPOR ';
      LstrSQL := LstrSQL + 'WHERE ';
      LstrSQL := LstrSQL + 'CP.CTP_DTAPAG IS NULL AND ';
      LstrSQL := LstrSQL + 'MONTH(CP.CTP_DTAVEN) = MONTH(:DTAVEN) AND YEAR(CP.CTP_DTAVEN) = YEAR(:DTAVEN) AND ';
      LstrSQL := LstrSQL + 'CP.CTP_CODFOR = :CODFOR AND ';
      LstrSQL := LstrSQL + 'CP.CTP_CODCTA = :CODCTA AND ';
      LstrSQL := LstrSQL + 'CP.CTP_PREVIS = :PREVIS ;';
      LqryContasPagarComPrevisaoSim := fCriaQuery;
      LqryContasPagarComPrevisaoSim.Close;
      LqryContasPagarComPrevisaoSim.SQL.Text := LstrSQL;
      if FstrDtaVen = '' then
        LqryContasPagarComPrevisaoSim.ParamByName('DTAVEN').Clear
      else
        LqryContasPagarComPrevisaoSim.ParamByName('DTAVEN').AsString := FormatDateTime('yyyy-mm-dd', StrToDate(FstrDtaVen));
      LqryContasPagarComPrevisaoSim.ParamByName('CODFOR').AsString := FstrCodFor;
      LqryContasPagarComPrevisaoSim.ParamByName('CODCTA').AsString := FstrCodCta;
      LqryContasPagarComPrevisaoSim.ParamByName('PREVIS').AsString := 'S';
      LqryContasPagarComPrevisaoSim.Open;
      if LqryContasPagarComPrevisaoSim.RecordCount <= 0 then
        Exit;
      Result := True;
      FcdsContasPagarComPrevisaoSim := fCriaClientDatset(LqryContasPagarComPrevisaoSim) ;
    finally
      FreeAndNil(LqryContasPagarComPrevisaoSim);
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.fCarregarDadosCtaPagarComPrevisaoSim]');
    End;
  End;
end;

function TFrmManipulaContasPagarPrevisaoNao.fDeleteCADPAG(
  AstrAutoInc: String): Boolean;
Var
    LqryDel: TUniQuery;
begin
  Result := True;
  Try
    LqryDel := fCriaQuery(Nil);
    Try
      LqryDel.Close;
      LqryDel.Sql.Clear;
      LqryDel.Sql.Add('DELETE FROM CADPAG WHERE AUTOINCREM = :AUTOINCREM');
      LqryDel.ParamByName('AUTOINCREM').AsString := AstrAutoInc;
      LqryDel.ExecSQL;
    Except
    On E: Exception Do
      Begin
        Result:= False;
        pMensagensErro(E.Message,'[TFrmManipulaContasPagarPrevisaoNao.fDeleteCADPAG]');
      End;
    End;
  Finally
    pFreeAndNil(LqryDel);
  End;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.pCarregarMemoInformativo;
var
  LstrMensagem : String ;
  LstrMascaraCodCta : String ;
  LstrMascaraData : String ;
  LstrMascaraValorDuplicata : String ;
  LfltValorDuplicata : Double ;
begin
  Try
    LstrMensagem := '' ;
    LstrMascaraCodCta := FormatMaskText('00.00.000;0', FstrCodCta);
    LfltValorDuplicata := StrToFloat(FstrValDup);
    LstrMascaraValorDuplicata := FormatFloat('0.00', LfltValorDuplicata) ;
    LstrMascaraData := Copy(FstrDtaVen, 4, 7);
    LstrMensagem := Format(
      'Existe previsão gerada para este plano de contas %s %s , para o fornecedor %s - %s, com vencimento em %s, no valor de R$ %s',
      [LstrMascaraCodCta, FstrDesCta, FstrCodFor, FstrNomFor, LstrMascaraData, LstrMascaraValorDuplicata]
    );
    meInformativo.Text := LstrMensagem ;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.pCarregarMemoInformativo]');
    End;
  End;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.pDeletaCtpDet(AstrNumDup,
  AstrParcel, AstrSerie, AstrCodEmp, AstrCodFor: String);
var
  LstrSQL: String;
  LqryGenDet: TUniQuery;
begin
  Try
    LqryGenDet := fCriaQuery(Self);
    LstrSQL := '';
    LstrSQL := LstrSQL + 'DELETE FROM CTPDET ';
    LstrSQL := LstrSQL + 'WHERE ';
    LstrSQL := LstrSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    LstrSQL := LstrSQL + '  CTP_PARCEL = :PARCEL AND ';
    If (fEmptyStr(AstrSerie)) Then
      LstrSQL := LstrSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) AND '
    Else
      LstrSQL := LstrSQL + '  CTP_SERIE_ = :SERIE_ AND ';
    LstrSQL := LstrSQL + '  CTP_EMPORI = :EMPORI AND ';
    LstrSQL := LstrSQL + '  CTP_CODFOR = :CODFOR ';

    LqryGenDet.Close;
    LqryGenDet.SQL.Clear;
    LqryGenDet.SQL.Add(LstrSQL);
    LqryGenDet.ParamByName('NUMDUP').AsString := AstrNumDup;
    LqryGenDet.ParamByName('PARCEL').AsString := AstrParcel;
    If (Not fEmptyStr(AstrSerie)) Then
      LqryGenDet.ParamByName('SERIE_').AsString := AstrSerie;
    LqryGenDet.ParamByName('EMPORI').AsString := AstrCodEmp;
    LqryGenDet.ParamByName('CODFOR').AsString := AstrCodFor;
    LqryGenDet.ExecSQL;
  Finally
    FreeAndNil(LqryGenDet);
  End;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.pExcluirPrevisao;
var
  LblnItensApagados : Boolean;
  LobjPag : TCadPag;
  LobjRep : TCadPagRepository;
  LstrNumDup,
  LstrParcel,
  LstrCodEmp,
  LstrCodFor,
  LstrSerie,
  LstrCTPCom : String ;
  LblnRatEve : Boolean ;
  LintSeqBai : Integer ;
begin
  LblnItensApagados := False;

  If fMensagem('AVISO!', 'Excluir a(s) previsão(ões)?', ['&Sim', '&Não']) = 2 Then
    exit;

  if fVerificarRegistrosSelecionadosNoGrid then
  begin
    Try
      fStartTransaction;
      try
        FcdsContasPagarComPrevisaoSim.DisableControls;
        FcdsContasPagarComPrevisaoSim.First;
        while (not FcdsContasPagarComPrevisaoSim.Eof) do
        begin
          if FcdsContasPagarComPrevisaoSim.FieldByName('MARDES').AsString = 'M' then
          begin
            LstrNumDup := FcdsContasPagarComPrevisaoSim.FieldByName('CTP_NUMDUP').AsString;
            LstrParcel := FcdsContasPagarComPrevisaoSim.FieldByName('CTP_PARCEL').AsString;
            LstrSerie  := FcdsContasPagarComPrevisaoSim.FieldByName('CTP_SERIE_').AsString;
            LstrCodEmp := FcdsContasPagarComPrevisaoSim.FieldByName('CTP_CODEMP').AsString;
            LstrCodFor := FcdsContasPagarComPrevisaoSim.FieldByName('CTP_CODFOR').AsString;
            LstrCTPCom := FcdsContasPagarComPrevisaoSim.FieldByName('CTP_CTPCOM').AsString;
            LintSeqBai := FcdsContasPagarComPrevisaoSim.FieldByName('CTP_SEQBAI').AsInteger;

            LobjRep := TCadPagRepository.Create;
            LobjPag := LobjRep.fRetDuplicata(LstrNumDup, LstrParcel, LintSeqBai, LstrCodEmp, LstrCodFor, LstrSerie);

            pGravaLogCtp(FcdsContasPagarComPrevisaoSim.FieldByName('AUTOINCREM').AsString ,'EXCLUSÃO DA DUPLICATA COM PREVISÃO SIM');
            
            if fDeleteCADPAG(FcdsContasPagarComPrevisaoSim.FieldByName('AUTOINCREM').AsString) then
            begin
              If Assigned(LobjPag) Then
                LobjRep.pGravaDelCadPag(LobjPag, Self.Name);
          
              // Limpa CTPCom de todas tabelas
              If Not fEmptyStr(LstrCTPCom) Then
                pLimpaCTPCom(LstrCTPCom);

              {*****************************************}
              {* CASO HAJA ALGUM CTPDET, EXCLUI DA TA- *}
              {* BELA REAL                             *}
              {**************************************MV*}
              If fVerificaCtpDet(LstrNumDup, LstrParcel, LstrSerie, LstrCodEmp, LstrCodFor, LblnRatEve) Then
              Begin
                pDeletaCtpDet(LstrNumDup, LstrParcel, LstrSerie, LstrCodEmp, LstrCodFor);
              End;
              
              LblnItensApagados := True;
            end;
          end;
          FcdsContasPagarComPrevisaoSim.Next;
        end;
        If Assigned(LobjRep) Then
          FreeAndNil(LobjRep);
      finally
        FcdsContasPagarComPrevisaoSim.EnableControls;
      end;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        LblnItensApagados := False;
        pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.pExcluirPrevisao]');
      End;
    End;
  end
  else
    fMensagem('AVISO!','Nenhuma previsão selecionada para exclusão.', ['&OK']);

  if LblnItensApagados then
  begin
    fMensagem('AVISO!','Previsão(ões) excluída(as) com sucesso.', ['&OK']);
    if fCarregarDadosCtaPagarComPrevisaoSim then
      pCarregarClbTitulosComPrevisaoSim
    else
      close;
  end;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.pGravaLogCtp(AstrAUTOINCREM,
  AstrDescricao: String);
begin
  Try
    untLogCtp.GravaLogCtp(AstrAUTOINCREM, AstrDescricao,Self.Name);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TFrmManipulaContasPagarPrevisaoNao.pGravaLogCtp]') ;
  End;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.pLimpaCTPCom(AstrCTPCom: String);
var
  LqryCTPCom: TUniQuery;
  LstrSQL   : String;
begin
  LqryCTPCom := fCriaQuery(Self);

  Try
    LstrSQL := '';
    LstrSQL := LstrSQL + 'UPDATE CADREC  SET CTR_CTPCOM = NULL WHERE CTR_CTPCOM = :CTPCOM; ';
    LstrSQL := LstrSQL + 'UPDATE DUPAGR  SET CTR_CTPCOM = NULL WHERE CTR_CTPCOM = :CTPCOM; ';
    LstrSQL := LstrSQL + 'UPDATE CTRCNF  SET CTR_CTPCOM = NULL WHERE CTR_CTPCOM = :CTPCOM; ';
    LstrSQL := LstrSQL + 'UPDATE LOGCTR  SET CTR_CTPCOM = NULL WHERE CTR_CTPCOM = :CTPCOM; ';
    LstrSQL := LstrSQL + 'UPDATE CADCHQ  SET CHQ_CTPCOM = NULL WHERE CHQ_CTPCOM = :CTPCOM; ';
    LstrSQL := LstrSQL + 'UPDATE MOVCAR  SET MCA_CTPCOM = NULL WHERE MCA_CTPCOM = :CTPCOM; ';

    LqryCTPCom.Close;
    LqryCTPCom.SQL.Clear;
    LqryCTPCom.SQL.Add(LstrSQL);
    LqryCTPCom.ParamByName('CTPCOM').AsString := AstrCTPCom;
    LqryCTPCom.ExecSQL;
    LqryCTPCom.Close;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.pLimpaCTPCom]');
    End;
  End;

  FreeAndNil(LqryCTPCom);
end;

procedure TFrmManipulaContasPagarPrevisaoNao.pSelecionarRegistroParaAbater;
var
  LbkRegistroMarcado: TBookmark;
begin
  Try
  LbkRegistroMarcado := FcdsContasPagarComPrevisaoSim.GetBookmark;
    try
      FcdsContasPagarComPrevisaoSim.DisableControls;
      FcdsContasPagarComPrevisaoSim.First;
      while ((not FcdsContasPagarComPrevisaoSim.Eof)) do
      begin
        FcdsContasPagarComPrevisaoSim.Edit;
        FcdsContasPagarComPrevisaoSim.FieldByName('MARDES').AsString := 'D';
        FcdsContasPagarComPrevisaoSim.Post;
        FcdsContasPagarComPrevisaoSim.Next;
      end;

      if FcdsContasPagarComPrevisaoSim.BookmarkValid(LbkRegistroMarcado) then
        FcdsContasPagarComPrevisaoSim.GotoBookmark(LbkRegistroMarcado);

      FcdsContasPagarComPrevisaoSim.Edit;
      FcdsContasPagarComPrevisaoSim.FieldByName('MARDES').AsString := 'M';
      FcdsContasPagarComPrevisaoSim.Post;
    finally
      FcdsContasPagarComPrevisaoSim.EnableControls;
      FcdsContasPagarComPrevisaoSim.FreeBookmark(LbkRegistroMarcado);
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.pSelecionarRegistroParaAbater]');
    End;
  End;
end;

procedure TFrmManipulaContasPagarPrevisaoNao.pSelecionarRegistroParaExcluir;
begin
  Try
    If FcdsContasPagarComPrevisaoSim.FieldByName('MARDES').AsString = 'M'    Then
      FcdsContasPagarComPrevisaoSim.FieldByName('MARDES').AsString := 'D'
    else
      FcdsContasPagarComPrevisaoSim.FieldByName('MARDES').AsString := 'M';
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.pSelecionarRegistroParaExcluir]');
    End;
  End;
end;

function TFrmManipulaContasPagarPrevisaoNao.fVerificarRegistrosSelecionadosNoGrid:Boolean;
begin
  Result := False;
  Try
    FcdsContasPagarComPrevisaoSim.DisableControls;
    try
      FcdsContasPagarComPrevisaoSim.First;
      while not FcdsContasPagarComPrevisaoSim.EOF do
      begin
        if FcdsContasPagarComPrevisaoSim.FieldByName('MARDES').AsString = 'M' then
        begin
          Result := True;
          break;
        end;
        FcdsContasPagarComPrevisaoSim.Next
      end;
    finally
      FcdsContasPagarComPrevisaoSim.EnableControls;
    end;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFrmManipulaContasPagarPrevisaoNao.fVerificarRegistrosSelecionadosNoGrid]');
    End;
  End;
end;

end.
