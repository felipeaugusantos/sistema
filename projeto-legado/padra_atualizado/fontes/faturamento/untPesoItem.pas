unit untPesoItem;

interface

uses Windows, Classes, StrUtils, SysUtils, Controls, Uni, UniClientDataSet, UniDataSetProvider, DB,
     EditFocus, Forms, Variants, StdCtrls, untFuncFat, untFuncoesSimples;

Type
  TPesIte = Class(TComponent)

    private
      FPesBruEna: Boolean;
      FPesLiqEna: Boolean;
      FPesBruTab: Boolean;
      FPesBruRea: Boolean;
      FPesLiqTab: Boolean;
      FPesLiqRea: Boolean;

    public
      fatVenda: TFatVenda;

      property blnPesBruEna: Boolean Read FPesBruEna   Write FPesBruEna;
      property blnPesLiqEna: Boolean Read FPesLiqEna   Write FPesLiqEna;
      property blnPesBruTab: Boolean Read FPesBruTab   Write FPesBruTab;
      property blnPesBruRea: Boolean Read FPesBruRea   Write FPesBruRea;
      property blnPesLiqTab: Boolean Read FPesLiqTab   Write FPesLiqTab;
      property blnPesLiqRea: Boolean Read FPesLiqRea   Write FPesLiqRea;

      procedure pAbreTelaDigPesoProduto(edtPesBru, edtPesLiq: TEditFocus);
      Constructor Create(Owner: TComponent); override;
      Destructor  Destroy; override;
End;

implementation



{ TPesIte }

uses untFatDigPesoItem;

constructor TPesIte.Create(Owner: TComponent);
begin
  inherited Create(Owner);
end;

destructor TPesIte.Destroy;
begin
  inherited destroy;
end;

procedure TPesIte.pAbreTelaDigPesoProduto(edtPesBru, edtPesLiq: TEditFocus);
begin

  Try

    If (fatVenda.strEdiPes =  'N') Then
    Begin
      FPesBruEna := edtPesBru.Enabled;
      FPesBruRea := edtPesBru.ReadOnly;
      FPesBruTab := edtPesBru.TabStop;

      FPesLiqEna := edtPesLiq.Enabled;
      FPesLiqRea := edtPesLiq.ReadOnly;
      FPesLiqTab := edtPesLiq.TabStop;
    End;

    pCriarFormularios(TFrmFatDigPesoItem, frmFatDigPesoItem);
    frmFatDigPesoItem.objFatVen := fatVenda;

    frmFatDigPesoItem.ShowModal;

    If (frmFatDigPesoItem.ModalResult = mrOk) Then
    Begin
      edtPesBru.Text := FormatFloat('#,###0.000', fatVenda.fltPesBru);
      edtPesLiq.Text := FormatFloat('#,###0.000', fatVenda.fltPesLiq);

      If (fatVenda.strEdiPes = 'E') Then
      Begin
        edtPesBru.ReadOnly := True;
        edtPesLiq.ReadOnly := True;
        edtPesBru.TabStop  := False;
        edtPesLiq.TabStop  := False;
      End
      Else
      Begin
        edtPesBru.Enabled  := FPesBruEna;
        edtPesLiq.Enabled  := FPesLiqEna;

        edtPesBru.ReadOnly := FPesBruRea;
        edtPesLiq.ReadOnly := FPesLiqRea;

        edtPesBru.TabStop  := FPesBruTab;
        edtPesLiq.TabStop  := FPesLiqTab;
      End;

    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmFatDadosFiscais.pAbreTelaDigPesoProduto]');
  End;

  pFreeAndNil(frmFatDigPesoItem);
end;

end.
